import 'package:flutter/material.dart';

class ImageItem extends StatelessWidget {
  final int index;
  final bool isSelected;
  final Function() onTap;

  const ImageItem({
    required this.index,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 140,
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 2,
            color: isSelected ? Theme.of(context).colorScheme.primary : const Color(0xffc5c5c5),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/$index.png',
              fit: BoxFit.cover,
              height: 100,
              width: double.infinity,
            ),
          ],
        ),
      ),
    );
  }
}
