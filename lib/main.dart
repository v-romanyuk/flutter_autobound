import 'package:Autobound/providers.dart';
import 'package:Autobound/screens/session_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import './screens/auth/login_screen.dart';
import './screens/suggested_campaigns/suggested_campaigns_screen.dart';
import './styles/colors.dart';

void main() {
  // debugPaintSizeEnabled = true;
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  void showLayoutGuidelines() {
    debugPaintSizeEnabled = true;
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthProvider()),
          ChangeNotifierProvider(create: (_) => SuggestedCampaignsProvider()),
        ],
        child: Consumer<AuthProvider>(
          builder: (ctx, authProvider, _) => GetCupertinoApp(
            debugShowCheckedModeBanner: false,
            theme: CupertinoThemeData(
              primaryColor: AppColors.primary,
              primaryContrastingColor: AppColors.white,
              scaffoldBackgroundColor: AppColors.greyLight,
              barBackgroundColor: AppColors.white,
              textTheme: const CupertinoTextThemeData().copyWith(
                textStyle: const TextStyle(
                  fontFamily: 'Roboto',
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            routes: {
              '/': (ctx) => const SessionScreen(),
              LoginScreen.routeName: (ctx) => const LoginScreen(),
              SuggestedCampaignsScreen.routeName: (ctx) => SuggestedCampaignsScreen(),
            },
          ),
        ));
  }
}
