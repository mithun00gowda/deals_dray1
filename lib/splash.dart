import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:deals_dray/home.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        children: [
          Center(
            child: LottieBuilder.asset(
                'assets/Lottie/Animation - 1723400052821.json'),
          )
        ],
      ),
      nextScreen: Home(),
      duration: 3500,
      splashIconSize: 400,
      backgroundColor: Colors.white,
    );
  }
}
