import 'package:Autobound/screens/auth/login_screen.dart';
import 'package:flutter/cupertino.dart';

class SuggestedCampaignsScreen extends StatefulWidget {
  const SuggestedCampaignsScreen({Key? key}) : super(key: key);
  static const routeName = '/suggested-campaigns';

  @override
  _SuggestedCampaignsScreenState createState() => _SuggestedCampaignsScreenState();
}

class _SuggestedCampaignsScreenState extends State<SuggestedCampaignsScreen> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Suggested Campaigns'),
      ),
      child: Center(
        child: CupertinoButton(
          child: const Text('logout'),
          onPressed: () {
            Navigator.of(context).pushNamedAndRemoveUntil(LoginScreen.routeName, (Route<dynamic> route) => false);
          },
        ),
      ),
    );
  }
}
