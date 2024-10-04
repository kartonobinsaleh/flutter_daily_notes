import 'package:flutter/material.dart';
import 'package:flutter_todo_list/widgets/custom_button.dart';
import 'package:flutter_todo_list/widgets/custom_textfield.dart';
import 'package:flutter_todo_list/widgets/image_item.dart';

class AddNotePage extends StatefulWidget {
  const AddNotePage({super.key});

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  final title = TextEditingController();
  final description = TextEditingController();
  int tapIndex = 0;

  final _focusNode1 = FocusNode();
  final _focusNode2 = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextfield(
              controller: title,
              focusNode: _focusNode1,
              hintText: "Title",
            ),
            const SizedBox(height: 10),
            CustomTextfield(
              controller: description,
              focusNode: _focusNode2,
              maxLines: 3,
              hintText: "Description",
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 160,
              child: ListView.builder(
                itemCount: 8,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return ImageItem(
                    index: index,
                    isSelected: tapIndex == index,
                    onTap: () {
                      setState(() {
                        tapIndex = index;
                      });
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      text: "Add Task",
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: CustomButton(
                      text: "Cancel",
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      backgroundColor: Colors.red,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
