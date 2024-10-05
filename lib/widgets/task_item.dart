import 'package:flutter/material.dart';
import 'package:flutter_todo_list/data/models/note.dart';
import 'package:flutter_todo_list/screens/add_note_page.dart';
import 'package:flutter_todo_list/widgets/custom_ilustration.dart';

class TaskItem extends StatefulWidget {
  final Note note;

  const TaskItem({required this.note, super.key});

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
              CustomIlustration(
                imagePath: 'images/${widget.note.image}.png',
                width: 130,
                height: 100,
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.note.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      widget.note.description,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[500],
                      ),
                    ),
                    Builder(builder: (context) {
                      final date = widget.note.date;
                      if (date == null) return const SizedBox();
                      final time = TimeOfDay.fromDateTime(date);
                      return Text(
                        date.day.toString() + '/' + date.month.toString() + '/' + date.year.toString() + ' ' + time.hour.toString() + ':' + time.minute.toString(),
                      );
                      //  actionButton('images/icon_time.png', widget.note.date?.toIso8601String() ?? '', Theme.of(context).colorScheme.primary, () {});
                    })
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
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
      ),
      child: Row(
        children: [
          Image.asset(imagePath),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
