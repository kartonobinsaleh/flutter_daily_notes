import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_list/bloc/note/note_bloc.dart';
import 'package:flutter_todo_list/data/models/note.dart';
import 'package:flutter_todo_list/widgets/custom_button.dart';
import 'package:flutter_todo_list/widgets/custom_textfield.dart';
import 'package:flutter_todo_list/widgets/image_item.dart';
import 'package:intl/intl.dart';

class AddNotePage extends StatefulWidget {
  final Note? note;

  const AddNotePage({this.note, super.key});

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  int tapIndex = 0;

  final _titleFocusNode = FocusNode();
  final _descFocusNode = FocusNode();

  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      _titleController.text = widget.note!.title;
      _descController.text = widget.note!.description;

      selectedDate = widget.note!.date;
      final time = widget.note!.date;
      if (time == null) return;
      selectedTime = TimeOfDay.fromDateTime(time);
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
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
              controller: _titleController,
              focusNode: _titleFocusNode,
              hintText: "Title",
            ),
            const SizedBox(height: 10),
            CustomTextfield(
              controller: _descController,
              focusNode: _descFocusNode,
              maxLines: 3,
              hintText: "Description",
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => _selectDate(context),
                      child: Text(selectedDate == null ? 'Pick a Date' : DateFormat.yMMMd().format(selectedDate!)),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => _selectTime(context),
                      child: Text(selectedTime == null ? 'Pick a Time' : selectedTime!.format(context)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
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
                        try {
                          if (_titleController.text.isEmpty) throw "Please enter a title";
                          if (_descController.text.isEmpty) throw "Please enter a description";
                          if (selectedDate != null && selectedTime == null) throw "Please pick a time";
                          if (widget.note == null) {
                            final newNote = Note(
                              title: _titleController.text,
                              description: _descController.text,
                              date: selectedDate?.copyWith(hour: selectedTime?.hour, minute: selectedTime?.minute),
                              image: tapIndex,
                            );

                            noteBloc.add(AddNote(newNote));
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Task added successfully"),
                              ),
                            );
                          } else {
                            final updatedNote = widget.note!.copyWith(
                              title: _titleController.text,
                              description: _descController.text,
                              date: selectedDate?.copyWith(hour: selectedTime?.hour, minute: selectedTime?.minute),
                              image: widget.note?.image,
                            );
                            noteBloc.add(UpdateNote(
                              noteId: widget.note!.id,
                              updatedNote: updatedNote,
                            ));
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Task updated successfully"),
                              ),
                            );
                          }
                          _titleController.clear();
                          _descController.clear();
                          Navigator.pop(context);
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(e.toString()),
                            ),
                          );
                        }
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
