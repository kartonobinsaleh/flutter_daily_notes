import 'package:flutter/material.dart';
import 'package:flutter_todo_list/models/note.dart';
import 'package:flutter_todo_list/widgets/bottom_navbar_add.dart';
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
      tapIndex = widget.note!.image;

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
    final newMinute = DateTime.now().add(const Duration(minutes: 1)).minute;

    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now().replacing(minute: newMinute),
    );

    if (picked != null) {
      setState(() {
        selectedTime = picked;
        selectedDate = selectedDate?.copyWith(
          hour: picked.hour,
          minute: picked.minute,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.black87,
        centerTitle: true,
        title: Text(widget.note == null ? 'Add Note' : 'Update Note'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
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
                        child: Text(dateText),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => _selectTime(context),
                        child: Text(timeText),
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
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavbarAdd(
        titleController: _titleController,
        descController: _descController,
        tapIndex: tapIndex,
        selectedDate: selectedDate,
        selectedTime: selectedTime,
        note: widget.note,
      ),
    );
  }

  String get dateText {
    if (selectedDate == null) return 'Pick a Date';
    return DateFormat.yMMMd().format(selectedDate!);
  }

  String get timeText {
    if (selectedTime == null) return 'Pick a Time';
    return DateFormat.Hm().format(selectedDate!);
  }
}
