import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

class MarqueePackage extends StatefulWidget {
  const MarqueePackage({
    super.key,
  });

  @override
  State<MarqueePackage> createState() => _MarqueePackageState();
}

class _MarqueePackageState extends State<MarqueePackage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 200, left: 20, right: 20),
          child: SizedBox(
            height: 50,
            child: Marquee(
              text: 'Some sample text that takes some space.',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              scrollAxis: Axis.horizontal,
              crossAxisAlignment: CrossAxisAlignment.start,
              blankSpace: 20.0,
              velocity: 100.0,
              pauseAfterRound: const Duration(seconds: 1),
              startPadding: 10.0,
              accelerationDuration: const Duration(seconds: 1),
              accelerationCurve: Curves.linear,
              decelerationDuration: const Duration(milliseconds: 500),
              decelerationCurve: Curves.easeOut,
            ),
          ),
        )
      ],
    ));
  }
}
