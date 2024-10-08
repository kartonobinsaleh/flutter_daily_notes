import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final String hintText;
  final IconData? icon;
  final int maxLines;
  final bool obscureText;

  const CustomTextfield({
    required this.controller,
    required this.focusNode,
    required this.hintText,
    this.icon,
    this.maxLines = 1,
    super.key,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: TextField(
          controller: controller,
          focusNode: focusNode,
          maxLines: maxLines,
          obscureText: obscureText,
          style: const TextStyle(fontSize: 16, color: Colors.black),
          decoration: InputDecoration(
              prefixIcon: icon != null
                  ? Icon(
                      icon,
                      color: focusNode.hasFocus ? Theme.of(context).colorScheme.primary : const Color(0xffc5c5c5),
                    )
                  : null,
              contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              hintText: hintText,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Color(0xffc5c5c5),
                  width: 2.0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.primary,
                  width: 2.0,
                ),
              )),
        ),
      ),
    );
  }
}
