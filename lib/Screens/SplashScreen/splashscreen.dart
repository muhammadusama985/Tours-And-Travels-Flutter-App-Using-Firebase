import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:solosavour/Screens/OnboardingScreens/onboardingscren.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Navigate to a new screen after 5 seconds
    void navigateToNewScreen() {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const BoardingPageView()),
      );
    }

    // Delayed navigation
    Timer(const Duration(seconds: 5), navigateToNewScreen);

    return Scaffold(
      backgroundColor:
          Colors.white, // Change background color as per your preference
      body: Center(
        child: Stack(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/Travel.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: ScreenUtil().setHeight(40),
              right: ScreenUtil().setWidth(137),
              child: SizedBox(
                width: ScreenUtil().setWidth(80),
                height: ScreenUtil().setHeight(80),
                child: LoadingAnimationWidget.inkDrop(
                  color: Colors.white,
                  size: 40,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
