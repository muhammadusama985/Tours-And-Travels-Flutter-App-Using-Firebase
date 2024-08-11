import 'package:flutter/material.dart';

class AnimatedContainerWithDelay extends StatefulWidget {
  final Widget child;
  final Duration delay;

  const AnimatedContainerWithDelay(
      {super.key, required this.child, required this.delay});

  @override
  _AnimatedContainerWithDelayState createState() =>
      _AnimatedContainerWithDelayState();
}

class _AnimatedContainerWithDelayState
    extends State<AnimatedContainerWithDelay> {
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(widget.delay, () {
      if (mounted) {
        setState(() {
          _isVisible = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 1000),
      opacity: _isVisible ? 1.0 : 0.0,
      child: AnimatedPadding(
        duration: const Duration(milliseconds: 1000),
        padding: _isVisible
            ? EdgeInsets.zero
            : const EdgeInsets.symmetric(vertical: 100.0),
        child: widget.child,
      ),
    );
  }
}
