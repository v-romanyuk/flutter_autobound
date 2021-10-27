import 'dart:core';
import 'package:Autobound/styles/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:Autobound/services/services.dart';

class ContactSale extends StatelessWidget {
  const ContactSale({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    showNoMailAppsDialog(BuildContext context) {
      CupertinoAlertDialog alert = CupertinoAlertDialog(
        title: const Text('Open Mail App'),
        content: const Text('No mail apps installed'),
        actions: [
          CupertinoDialogAction(
            child: const Text('OK'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      );

      return showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }

    Future<void> openMailClientAndPopulateEmailData() async {
      var apps = await OpenMailApp.getMailApps();
      if (apps.isEmpty) {
        showNoMailAppsDialog(context);
      } else {
        showCupertinoModalPopup(
          context: context,
          builder: (context) {
            return MailAppPickerDialog(
              mailApps: apps,
              emailContent: EmailContent(
                to: [
                  'sales@autobound.ai',
                ],
                subject: 'Subscribe',
                body: 'I would like to use your App!',
                // cc: ['sales@autobound.ai'],
                // bcc: ['sales@autobound.ai'],
              ),
            );
          },
        );
      }
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Don\'t have an account?',
          style: TextStyle(fontSize: 16.0),
        ),
        const SizedBox(width: 6.0,),
        GestureDetector(
          onTap: openMailClientAndPopulateEmailData,
          child: const Text(
            'Contact Sale.',
            style: TextStyle(
                decoration: TextDecoration.underline,
                fontSize: 16.0,
                fontWeight: FontWeight.w400,
                color: AppColors.primary
            ),
          ),
        ),
      ],
    );
  }
}
