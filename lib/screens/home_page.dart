import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_list/bloc/note/note_bloc.dart';
import 'package:flutter_todo_list/data/note.dart';
import 'package:flutter_todo_list/screens/add_note_page.dart';
import 'package:flutter_todo_list/widgets/task_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool show = true;

  removeNote(Note note) {
    context.read<NoteBloc>().add(RemoveNote(note));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<NoteBloc, NoteState>(
        builder: (context, state) {
          if (state.status == NoteStatus.initial) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.status == NoteStatus.success) {
            return SafeArea(
              child: NotificationListener<UserScrollNotification>(
                onNotification: (notification) {
                  if (notification.direction == ScrollDirection.forward) {
                    setState(
                      () {
                        show = true;
                      },
                    );
                  }
                  if (notification.direction == ScrollDirection.reverse) {
                    setState(
                      () {
                        show = false;
                      },
                    );
                  }
                  return true;
                },
                child: ListView.builder(
                  itemCount: state.notes.length,
                  itemBuilder: (context, index) {
                    final note = state.notes[index];
                    return TaskItem(note: note);
                  },
                ),
              ),
            );
          } else {
            return Container();
          }
        },
      ),
      floatingActionButton: Visibility(
        visible: show,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const AddNotePage(),
              ),
            );
          },
          backgroundColor: Theme.of(context).colorScheme.primary,
          shape: const CircleBorder(),
          child: const Icon(
            Icons.add,
            size: 32,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
