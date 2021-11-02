import 'package:Autobound/providers.dart';
import 'package:Autobound/screens/auth/login_screen.dart';
import 'package:Autobound/screens/suggested_campaigns/suggested_campaigns_screen.dart';
import 'package:Autobound/styles/colors.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class SessionScreen extends StatefulWidget {
  const SessionScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SessionScreen> with TickerProviderStateMixin {
  goToLoginScreen () {
    Navigator.pushReplacement(
        context,
        PageTransition(
          type: PageTransitionType.scale,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 1200),
          curve: const Cubic(1, 0.01, 0.39, 1.3),
          child: const LoginScreen(),
        ));
  }
  getUserProfile() async {
    final isLoggedIn = await context.read<AuthProvider>().autoLogin();
    if (isLoggedIn) {
      try {
        await context.read<AuthProvider>().getUserProfile();
        Navigator.pushReplacementNamed(context, SuggestedCampaignsScreen.routeName);
      } on DioError catch (_) {
        goToLoginScreen();
      } catch (err) {
        print(err);
      }
    } else {
      goToLoginScreen();
    }
  }

  @override
  initState() {
    super.initState();
    getUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Container(
        decoration: const BoxDecoration(
            color: AppColors.white,
          image: DecorationImage(
            image: AssetImage('lib/assets/images/bg.png'),
            fit: BoxFit.cover
          )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 260,
              margin: const EdgeInsets.only(bottom: 20),
              child: const Image(image: AssetImage('lib/assets/images/logo.png')),
            ),
            const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
                strokeWidth: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
