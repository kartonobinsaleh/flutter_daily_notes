import 'dart:io';

import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_list/bloc/note/note_bloc.dart';
import 'package:flutter_todo_list/models/note.dart';
import 'package:flutter_todo_list/widgets/custom_button.dart';

class BottomNavbarAdd extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController descController;
  final int tapIndex;
  final DateTime? selectedDate;
  final TimeOfDay? selectedTime;
  final Note? note;
  const BottomNavbarAdd({
    required this.titleController,
    required this.descController,
    required this.tapIndex,
    required this.selectedDate,
    required this.selectedTime,
    required this.note,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final noteBloc = BlocProvider.of<NoteBloc>(context);
    return BottomAppBar(
      color: Colors.white,
      child: CustomButton(
        text: note == null ? "Add Note" : "Update Note",
        onPressed: () async {
          try {
            if (titleController.text.isEmpty) throw "Please enter a title";
            if (descController.text.isEmpty) throw "Please enter a description";
            if (selectedDate != null && selectedTime == null) throw "Please pick a time";

            final now = DateTime.now();

            if (selectedDate != null && (selectedDate?.isBefore(now) ?? false)) {
              throw "Please pick a date in the future";
            }

            if (note == null) {
              final newId = DateTime.now().hashCode.abs();
              await _setAlarm(newId);

              final newNote = Note(
                id: newId,
                title: titleController.text,
                description: descController.text,
                date: selectedDate,
                image: tapIndex,
              );

              noteBloc.add(AddNote(newNote));

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Note added successfully"),
                ),
              );
            } else {
              await Alarm.stop(note!.id);
              await _setAlarm(note!.id);

              final updatedNote = note!.copyWith(
                title: titleController.text,
                description: descController.text,
                date: selectedDate,
                image: note?.image,
              );
              noteBloc.add(UpdateNote(
                noteId: note!.id,
                updatedNote: updatedNote,
              ));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Note updated successfully"),
                ),
              );
            }
            titleController.clear();
            descController.clear();
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
    );
  }

  Future<void> _setAlarm(int id) async {
    if (selectedDate != null) {
      await Alarm.set(
        alarmSettings: AlarmSettings(
          id: id,
          dateTime: selectedDate!,
          assetAudioPath: 'assets/alarm.mp3',
          loopAudio: true,
          vibrate: true,
          volume: 1,
          fadeDuration: .0,
          warningNotificationOnKill: Platform.isIOS,
          notificationSettings: NotificationSettings(
            title: titleController.text,
            body: descController.text,
            stopButton: "Stop",
          ),
        ),
      );
    }
  }
}
