import 'package:flutter/material.dart';

class CustomIlustration extends StatelessWidget {
  final String imagePath;
  final double width;
  final double height;

  const CustomIlustration({
    required this.imagePath,
    this.width = double.infinity,
    this.height = 300,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
