import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solosavour/NewOnboardings/onboarding_screen.dart';
import 'package:solosavour/SelectionPoints/SelectionPoints.dart';

class NewSplashScreen extends StatefulWidget {
  const NewSplashScreen({Key? key});

  @override
  _NewSplashScreenState createState() => _NewSplashScreenState();
}

class _NewSplashScreenState extends State<NewSplashScreen> {
  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    Timer(const Duration(seconds: 5), () {
      _checkUserStatus();
    });
  }

  void _checkUserStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedIn) {
      // If the user is logged in, navigate to the SelectionPoints screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const SelectionPoints()),
      );
    } else {
      // If the user is not logged in, navigate to the Onboarding screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const NewOnboardingScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.blue,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 250.0,
              child: TyperAnimatedTextKit(
                isRepeatingAnimation: true,
                speed: const Duration(milliseconds: 200),
                textStyle: const TextStyle(
                  fontSize: 32,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                text: const ['SoloSavour Journeys'],
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            LoadingAnimationWidget.staggeredDotsWave(
              color: Colors.white,
              size: 35,
            ),
          ],
        ),
      ),
    );
  }
}
