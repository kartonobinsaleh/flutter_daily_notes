import 'package:flutter/material.dart';

class CustomAccountText extends StatelessWidget {
  final String questionText;
  final String actionText;
  final VoidCallback onActionTap;

  const CustomAccountText({
    required this.questionText,
    required this.actionText,
    required this.onActionTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            questionText,
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 14,
            ),
          ),
          const SizedBox(width: 5),
          GestureDetector(
            onTap: onActionTap,
            child: Text(
              actionText,
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
