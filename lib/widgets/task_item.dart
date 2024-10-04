import 'package:flutter/material.dart';
import 'package:flutter_todo_list/constants/colors.dart';
import 'package:flutter_todo_list/widgets/custom_ilustration.dart';

class TaskItem extends StatefulWidget {
  const TaskItem({super.key});

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  bool isDone = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      child: Container(
        width: double.infinity,
        height: 130,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 2),
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              const CustomIlustration(
                imagePath: 'images/schedule_meeting.png',
                width: 130,
                height: 100,
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Title",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Checkbox(
                            value: isDone,
                            onChanged: (value) {
                              setState(() {
                                isDone = !isDone;
                              });
                            })
                      ],
                    ),
                    Text(
                      "deskripsi",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[500],
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Row(
                        children: [
                          actionButton('images/icon_time.png', "time", primaryColor, () {}),
                          const SizedBox(width: 10),
                          actionButton('images/icon_edit.png', "edit", const Color(0xffc5c5c5), () {}),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget actionButton(String imagePath, String label, Color backgroundColor, Function() onPressed) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 90,
        height: 28,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 4,
          ),
          child: Row(
            children: [
              Image.asset(imagePath),
              const SizedBox(width: 10),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
