import 'package:flutter/material.dart';
import 'package:flutter_todo_list/constants/colors.dart';

class CustomTextfield extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final String hintText;
  final IconData icon;

  const CustomTextfield({
    required this.controller,
    required this.focusNode,
    required this.hintText,
    required this.icon,
    super.key,
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
          style: const TextStyle(fontSize: 16, color: Colors.black),
          decoration: InputDecoration(
              prefixIcon: Icon(
                icon,
                color: focusNode.hasFocus ? primaryColor : const Color(0xffc5c5c5),
              ),
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
                  color: primaryColor,
                  width: 2.0,
                ),
              )),
        ),
      ),
    );
  }
}
