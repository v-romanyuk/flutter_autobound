import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:platform/platform.dart';
import 'package:url_launcher/url_launcher.dart';

/// Launch Schemes for supported apps:
const String _LAUNCH_SCHEME_APPLE_MAIL = 'message://';
const String _LAUNCH_SCHEME_GMAIL = 'googlegmail://';
const String _LAUNCH_SCHEME_DISPATCH = 'x-dispatch://';
const String _LAUNCH_SCHEME_SPARK = 'readdle-spark://';
const String _LAUNCH_SCHEME_AIRMAIL = 'airmail://';
const String _LAUNCH_SCHEME_OUTLOOK = 'ms-outlook://';
const String _LAUNCH_SCHEME_YAHOO = 'ymail://';
const String _LAUNCH_SCHEME_FASTMAIL = 'fastmail://';
const String _LAUNCH_SCHEME_SUPERHUMAN = 'superhuman://';

/// Provides ability to query device for installed email apps and open those
/// apps
class OpenMailApp {
  OpenMailApp._();

  @visibleForTesting
  static Platform platform = const LocalPlatform();

  static bool get _isAndroid => platform.isAndroid;

  static bool get _isIOS => platform.isIOS;

  static const MethodChannel _channel = MethodChannel('open_mail_app');
  static List<String> _filterList = <String>['paypal'];
  static final List<MailApp> _supportedMailApps = [
    MailApp(
      name: 'Apple Mail',
      iosLaunchScheme: _LAUNCH_SCHEME_APPLE_MAIL,
      composeData: ComposeData(
        base: 'mailto:',
      ),
    ),
    MailApp(
      name: 'Gmail',
      iosLaunchScheme: _LAUNCH_SCHEME_GMAIL,
      composeData: ComposeData(
        base: _LAUNCH_SCHEME_GMAIL + '/co',
      ),
    ),
    MailApp(
      name: 'Dispatch',
      iosLaunchScheme: _LAUNCH_SCHEME_DISPATCH,
      composeData: ComposeData(
        base: _LAUNCH_SCHEME_DISPATCH + '/compose',
      ),
    ),
    MailApp(
      name: 'Spark',
      iosLaunchScheme: _LAUNCH_SCHEME_SPARK,
      composeData: ComposeData(
        base: _LAUNCH_SCHEME_SPARK + 'compose',
        to: 'recipient',
      ),
    ),
    MailApp(
      name: 'Airmail',
      iosLaunchScheme: _LAUNCH_SCHEME_AIRMAIL,
      composeData: ComposeData(
        base: _LAUNCH_SCHEME_AIRMAIL + 'compose',
        body: 'plainBody',
      ),
    ),
    MailApp(
      name: 'Outlook',
      iosLaunchScheme: _LAUNCH_SCHEME_OUTLOOK,
      composeData: ComposeData(
        base: _LAUNCH_SCHEME_OUTLOOK + 'compose',
      ),
    ),
    MailApp(
      name: 'Yahoo',
      iosLaunchScheme: _LAUNCH_SCHEME_YAHOO,
      composeData: ComposeData(
        base: _LAUNCH_SCHEME_YAHOO + 'mail/compose',
      ),
    ),
    MailApp(
      name: 'Fastmail',
      iosLaunchScheme: _LAUNCH_SCHEME_FASTMAIL,
      composeData: ComposeData(
        base: _LAUNCH_SCHEME_FASTMAIL + 'mail/compose',
      ),
    ),
    MailApp(
      name: 'Superhuman',
      iosLaunchScheme: _LAUNCH_SCHEME_SUPERHUMAN,
      composeData: ComposeData(),
    ),
  ];

  static Future<OpenMailAppResult> openMailApp({
    String nativePickerTitle = '',
  }) async {
    if (_isAndroid) {
      final result = await _channel.invokeMethod<bool>(
            'openMailApp',
            <String, dynamic>{'nativePickerTitle': nativePickerTitle},
          ) ??
          false;
      return OpenMailAppResult(didOpen: result);
    } else if (_isIOS) {
      final apps = await _getIosMailApps();
      if (apps.length == 1) {
        final result = await launch(
          apps.first.iosLaunchScheme,
          forceSafariVC: false,
        );
        return OpenMailAppResult(didOpen: result);
      } else {
        return OpenMailAppResult(didOpen: false, options: apps);
      }
    } else {
      throw Exception('Platform not supported');
    }
  }

  static Future<OpenMailAppResult> composeNewEmailInMailApp({
    String nativePickerTitle = '',
    required EmailContent emailContent,
  }) async {
    if (_isAndroid) {
      final result = await _channel.invokeMethod<bool>(
            'composeNewEmailInMailApp',
            <String, String>{
              'nativePickerTitle': nativePickerTitle,
              'emailContent': emailContent.toJson(),
            },
          ) ??
          false;

      return OpenMailAppResult(didOpen: result);
    } else if (_isIOS) {
      List<MailApp> installedApps = await _getIosMailApps();
      if (installedApps.length == 1) {
        bool result = await launch(
          installedApps.first.iosLaunchScheme,
          forceSafariVC: false,
        );
        return OpenMailAppResult(didOpen: result);
      } else {
        return OpenMailAppResult(didOpen: false, options: installedApps);
      }
    } else {
      throw Exception('Platform currently not supported.');
    }
  }

  static Future<bool> composeNewEmailInSpecificMailApp({
    required MailApp mailApp,
    required EmailContent emailContent,
  }) async {
    if (_isAndroid) {
      final result = await _channel.invokeMethod<bool>(
            'composeNewEmailInSpecificMailApp',
            <String, dynamic>{
              'name': mailApp.name,
              'emailContent': emailContent.toJson(),
            },
          ) ??
          false;
      return result;
    } else if (_isIOS) {
      String? launchScheme = mailApp.composeLaunchScheme(emailContent);
      if (launchScheme != null) {
        return await launch(
          launchScheme,
          forceSafariVC: false,
        );
      }

      return false;
    } else {
      throw Exception('Platform currently not supported');
    }
  }

  static Future<bool> openSpecificMailApp(MailApp mailApp) async {
    if (_isAndroid) {
      var result = await _channel.invokeMethod<bool>(
            'openSpecificMailApp',
            <String, dynamic>{'name': mailApp.name},
          ) ??
          false;
      return result;
    } else if (_isIOS) {
      return await launch(
        mailApp.iosLaunchScheme,
        forceSafariVC: false,
      );
    } else {
      throw Exception('Platform not supported');
    }
  }

  static Future<List<MailApp>> getMailApps() async {
    if (_isAndroid) {
      return await _getAndroidMailApps();
    } else if (_isIOS) {
      return await _getIosMailApps();
    } else {
      throw Exception('Platform not supported');
    }
  }

  static Future<List<MailApp>> _getAndroidMailApps() async {
    var appsJson = await _channel.invokeMethod<String>('getMainApps');
    var apps = <MailApp>[];

    if (appsJson != null) {
      apps = (jsonDecode(appsJson) as Iterable)
          .map((x) => MailApp.fromJson(x))
          .where((app) => !_filterList.contains(app.name.toLowerCase()))
          .toList();
    }

    return apps;
  }

  static Future<List<MailApp>> _getIosMailApps() async {
    var installedApps = <MailApp>[];
    for (var app in _supportedMailApps) {
      if (await canLaunch(app.iosLaunchScheme) && !_filterList.contains(app.name.toLowerCase())) {
        installedApps.add(app);
      }
    }
    return installedApps;
  }

  static void setFilterList(List<String> filterList) {
    _filterList = filterList.map((e) => e.toLowerCase()).toList();
  }
}

class MailAppPickerDialog extends StatelessWidget {
  final String title;

  /// The mail apps for the dialog to provide as options
  final List<MailApp> mailApps;
  final EmailContent? emailContent;

  const MailAppPickerDialog({
    Key? key,
    this.title = 'Choose Your Mail Provider',
    required this.mailApps,
    this.emailContent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
      title: Text(
        title,
        style: const TextStyle(fontSize: 16),
      ),
      actions: [
        for (var app in mailApps)
          CupertinoActionSheetAction(
            child: Text(app.name),
            onPressed: () {
              final content = emailContent;
              if (content != null) {
                OpenMailApp.composeNewEmailInSpecificMailApp(
                  mailApp: app,
                  emailContent: content,
                );
              } else {
                OpenMailApp.openSpecificMailApp(app);
              }

              Navigator.pop(context);
            },
          ),
      ],
      cancelButton: CupertinoActionSheetAction(
        child: const Text('Cancel'),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}

class ComposeData {
  String base;
  String to;
  String cc;
  String bcc;
  String subject;
  String body;
  bool composeStarted = false;

  String get qsPairSeparator {
    String separator = !composeStarted ? '?' : '&';
    composeStarted = true;
    return separator;
  }

  ComposeData({
    this.base = 'mailto:',
    this.to = 'to',
    this.cc = 'cc',
    this.bcc = 'bcc',
    this.subject = 'subject',
    this.body = 'body',
  });

  String getComposeLaunchSchemeForIos(EmailContent content) {
    String scheme = base;

    if (content.to.isNotEmpty) {
      scheme += '$qsPairSeparator$to=${content.to.join(',')}';
    }

    if (content.cc.isNotEmpty) {
      scheme += '$qsPairSeparator$cc=${content.cc.join(',')}';
    }

    if (content.bcc.isNotEmpty) {
      scheme += '$qsPairSeparator$bcc=${content.bcc.join(',')}';
    }

    if (content.subject.isNotEmpty) {
      scheme += '$qsPairSeparator$subject=${content.subject}';
    }

    if (content.body.isNotEmpty) {
      scheme += '$qsPairSeparator$body=${content.body}';
    }

    composeStarted = false;

    return scheme;
  }

  @override
  String toString() {
    return getComposeLaunchSchemeForIos(EmailContent());
  }
}

class MailApp {
  final String name;
  final String iosLaunchScheme;
  final ComposeData? composeData;

  const MailApp({
    required this.name,
    required this.iosLaunchScheme,
    this.composeData,
  });

  factory MailApp.fromJson(Map<String, dynamic> json) => MailApp(
        name: json["name"],
        iosLaunchScheme: json["iosLaunchScheme"] ?? '',
        composeData: json["composeData"] ?? ComposeData(),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "iosLaunchScheme": iosLaunchScheme,
        "composeData": composeData,
      };

  String? composeLaunchScheme(EmailContent content) {
    if (OpenMailApp._isAndroid) {
      return content.toJson();
    } else if (OpenMailApp._isIOS) {
      return composeData!.getComposeLaunchSchemeForIos(content);
    } else {
      throw Exception('Platform not supported');
    }
  }
}

class OpenMailAppResult {
  final bool didOpen;
  final List<MailApp> options;

  bool get canOpen => options.isNotEmpty;

  OpenMailAppResult({
    required this.didOpen,
    this.options = const <MailApp>[],
  });
}

class EmailContent {
  final List<String> to;
  final List<String> cc;
  final List<String> bcc;
  final String _subject;

  String get subject => OpenMailApp._isIOS ? Uri.encodeComponent(_subject) : _subject;
  final String _body;

  String get body => OpenMailApp._isIOS ? Uri.encodeComponent(_body) : _body;

  EmailContent({
    List<String>? to,
    List<String>? cc,
    List<String>? bcc,
    String? subject,
    String? body,
  })  : to = to ?? const [],
        cc = cc ?? const [],
        bcc = bcc ?? const [],
        _subject = subject ?? '',
        _body = body ?? '';

  String toJson() {
    final Map<String, dynamic> emailContent = {
      'to': to,
      'cc': cc,
      'bcc': bcc,
      'subject': subject,
      'body': body,
    };

    return json.encode(emailContent);
  }
}
