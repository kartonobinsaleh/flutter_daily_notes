import 'package:flutter/material.dart';

class CustomIlustration extends StatelessWidget {
  final String imagePath;
  final double height;

  const CustomIlustration({
    required this.imagePath,
    this.height = 300,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        width: double.infinity,
        height: height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
