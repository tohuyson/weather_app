import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:weather_app/common/colors.dart';
import 'package:weather_app/common/widgets/images.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key, this.nextScreen});

  final Widget? nextScreen;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: AnimatedSplashScreen(
          duration: nextScreen == null ? 1000000 : 0,
          splashIconSize: double.infinity,
          splash: Container(
            width: double.infinity,
            height: double.infinity,
            color: UIColors.white,
            child: const Column(
              children: [
                Spacer(flex: 306),
                AppImage.asset(asset: 'weather_app_splash_logo', width: 120, height: 104, fit: BoxFit.contain),
                Spacer(flex: 402),
              ],
            ),
          ),
          nextScreen: nextScreen ?? const SizedBox(),
          splashTransition: SplashTransition.fadeTransition,
          pageTransitionType: PageTransitionType.fade,
          animationDuration: const Duration(milliseconds: 0),
        ),
      ),
    );
  }
}
