import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_list/bloc/auth/auth_bloc.dart';
import 'package:flutter_todo_list/bloc/note/note_bloc.dart';
import 'package:flutter_todo_list/data/models/note.dart';
import 'package:flutter_todo_list/extensions/router.dart';
import 'package:flutter_todo_list/screens/add_note_page.dart';
import 'package:flutter_todo_list/screens/login_page.dart';
import 'package:flutter_todo_list/widgets/custom_ilustration.dart';
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
  void initState() {
    userCheck();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print(context.read<NoteBloc>().state.notes.length);
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Notes'),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.logout,
                color: Colors.red,
              ),
              onPressed: () async {
                final confirm = await showDialog(
                  context: context,
                  builder: (context) => AlertDialog(title: const Text('Logout'), content: const Text('Are you sure you want to logout?'), actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: const Text('No'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: const Text('Yes'),
                    ),
                  ]),
                );

                if (confirm == true) context.read<AuthBloc>().add(AuthLogout());
              },
            ),
          ],
        ),
        body: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state.status == AuthStatus.success && state.user.username.isEmpty) {
              context.offAll(const LoginPage());
            }
          },
          child: BlocBuilder<NoteBloc, NoteState>(
            builder: (context, state) {
              if (state.status == NoteStatus.initial) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state.status == NoteStatus.success) {
                if (state.notes.isEmpty) {
                  return const Center(
                    child: CustomIlustration(imagePath: 'images/empty.png', width: 300, height: 300),
                  );
                }
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
      ),
    );
  }

  void userCheck() async {
    await onload();
    if (!mounted) return;
    if (context.read<AuthBloc>().state.user.username.isEmpty) {
      context.offAll(const LoginPage());
    }
  }

  Future onload() async {
    await Future.delayed(Duration.zero);
  }
}
