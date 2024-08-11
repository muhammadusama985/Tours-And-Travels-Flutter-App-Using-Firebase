import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  final int rating;
  final Color color;
  final double size;

  const StarRating({
    super.key,
    required this.rating,
    this.color = Colors.yellow,
    this.size = 24.0,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        5,
        (index) => Icon(
          index < rating ? Icons.star : Icons.star_border,
          color: color,
          size: size,
        ),
      ),
    );
  }
}
