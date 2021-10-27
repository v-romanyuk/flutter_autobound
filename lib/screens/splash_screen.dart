import 'package:Autobound/providers.dart';
import 'package:Autobound/screens/auth/login_screen.dart';
import 'package:Autobound/screens/suggested_campaigns/suggested_campaigns_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
      value: 0.1,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.decelerate);
    _controller.forward();
    Future.delayed(const Duration(seconds: 3), () async {
      final isLoggedIn = await context.read<AuthProvider>().autoLogin();
      Navigator.pushReplacementNamed(
        context,
        isLoggedIn ? SuggestedCampaignsScreen.routeName : LoginScreen.routeName,
      );
    });
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Center(
        child: ScaleTransition(
          scale: _animation,
          key: UniqueKey(),
          alignment: Alignment.center,
          child: Image.asset(
            'lib/assets/images/logo.png',
            width: 220,
            height: 50.0,
          ),
        ),
      ),
    );
  }
}
