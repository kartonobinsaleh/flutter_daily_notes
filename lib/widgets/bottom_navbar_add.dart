import 'dart:io';

import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_daily_notes/bloc/note/note_bloc.dart';
import 'package:flutter_daily_notes/models/note.dart';
import 'package:flutter_daily_notes/widgets/custom_button.dart';

class BottomNavbarAdd extends StatefulWidget {
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
  State<BottomNavbarAdd> createState() => _BottomNavbarAddState();
}

class _BottomNavbarAddState extends State<BottomNavbarAdd> {
  @override
  Widget build(BuildContext context) {
    final noteBloc = BlocProvider.of<NoteBloc>(context);
    return BottomAppBar(
      color: Colors.white,
      child: CustomButton(
        text: widget.note == null ? "Add Note" : "Update Note",
        onPressed: () async {
          try {
            if (widget.titleController.text.isEmpty) throw "Please enter a title";
            if (widget.descController.text.isEmpty) throw "Please enter a description";
            if (widget.selectedDate != null && widget.selectedTime == null) throw "Please pick a time";

            final now = DateTime.now();

            if (widget.selectedDate != null && (widget.selectedDate?.isBefore(now) ?? false)) {
              throw "Please pick a date in the future";
            }

            if (widget.note == null) {
              final newId = DateTime.now().hashCode.abs();
              await _setAlarm(newId);

              final newNote = Note(
                id: newId,
                title: widget.titleController.text,
                description: widget.descController.text,
                date: widget.selectedDate,
                image: widget.tapIndex,
              );

              noteBloc.add(AddNote(newNote));

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Note added successfully"),
                ),
              );
            } else {
              await Alarm.stop(widget.note!.id);
              await _setAlarm(widget.note!.id);

              final updatedNote = widget.note!.copyWith(
                title: widget.titleController.text,
                description: widget.descController.text,
                date: widget.selectedDate,
                image: widget.tapIndex,
              );
              // throw updatedNote;
              noteBloc.add(UpdateNote(
                noteId: widget.note!.id,
                updatedNote: updatedNote,
              ));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Note updated successfully"),
                ),
              );
            }
            widget.titleController.clear();
            widget.descController.clear();
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
    if (widget.selectedDate != null) {
      await Alarm.set(
        alarmSettings: AlarmSettings(
          id: id,
          dateTime: widget.selectedDate!,
          assetAudioPath: 'assets/alarm.mp3',
          loopAudio: true,
          vibrate: true,
          volume: 1,
          fadeDuration: .0,
          warningNotificationOnKill: Platform.isIOS,
          notificationSettings: NotificationSettings(
            title: widget.titleController.text,
            body: widget.descController.text,
            stopButton: "Stop",
          ),
        ),
      );
    }
  }
}
