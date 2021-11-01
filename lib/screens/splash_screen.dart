import 'package:Autobound/providers.dart';
import 'package:Autobound/screens/auth/login_screen.dart';
import 'package:Autobound/screens/suggested_campaigns/suggested_campaigns_screen.dart';
import 'package:Autobound/styles/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {

  @override
  initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 4), () async {
      final isLoggedIn = await context.read<AuthProvider>().autoLogin();
      Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.scale,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 1200),
          curve: const Cubic(1, 0.01, 0.39, 1.3),
          child: isLoggedIn ? const SuggestedCampaignsScreen() : const LoginScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Container(
        color: AppColors.white,
        child: const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
            strokeWidth: 2,
          ),
        ),
      ),
    );
  }
}
