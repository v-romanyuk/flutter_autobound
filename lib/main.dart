import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import './styles/colors.dart';

import './screens/auth/login_screen.dart';
import './screens/suggested_campaigns/suggested_campaigns_screen.dart';

void main() {
  // debugPaintSizeEnabled = true;
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp
  ]);
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);


  void showLayoutGuidelines() {
    debugPaintSizeEnabled = true;
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      theme: CupertinoThemeData(
          primaryColor: AppColors.primary,
          primaryContrastingColor: AppColors.white,
          scaffoldBackgroundColor: AppColors.greyLight,
          barBackgroundColor: AppColors.white,
        textTheme: const CupertinoTextThemeData().copyWith(
          textStyle: const TextStyle(
              fontFamily: 'Rubik',
              color: AppColors.textPrimary
          )
        )
      ),
      routes: {
        '/': (ctx) => const LoginScreen(),
        LoginScreen.routeName: (ctx) => const LoginScreen(),
        SuggestedCampaignsScreen.routeName: (ctx) => const SuggestedCampaignsScreen(),
      },
    );
  }
}
