import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_list/bloc/note/note_bloc.dart';
import 'package:flutter_todo_list/models/note.dart';
import 'package:flutter_todo_list/widgets/custom_button.dart';
import 'package:flutter_todo_list/widgets/custom_textfield.dart';
import 'package:flutter_todo_list/widgets/image_item.dart';

class AddNotePage extends StatefulWidget {
  final Note? note;

  const AddNotePage({this.note, super.key});

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  final titleController = TextEditingController();
  final descController = TextEditingController();
  int tapIndex = 0;

  final _focusNode1 = FocusNode();
  final _focusNode2 = FocusNode();

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      titleController.text = widget.note!.title;
      descController.text = widget.note!.description;
    }
  }

  @override
  Widget build(BuildContext context) {
    final noteBloc = BlocProvider.of<NoteBloc>(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextfield(
              controller: titleController,
              focusNode: _focusNode1,
              hintText: "Title",
            ),
            const SizedBox(height: 10),
            CustomTextfield(
              controller: descController,
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
                      text: widget.note == null ? "Add Task" : "Update Task",
                      onPressed: () {
                        if (widget.note == null) {
                          final newNote = Note(
                            title: titleController.text,
                            description: descController.text,
                          );
                          noteBloc.add(AddNote(newNote));
                        } else {
                          final updatedNote = widget.note!.copyWith(
                            title: titleController.text,
                            description: descController.text,
                          );
                          noteBloc.add(UpdateNote(
                            noteId: widget.note!.id,
                            updatedNote: updatedNote,
                          ));
                        }
                        titleController.clear();
                        descController.clear();
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
