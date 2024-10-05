import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_list/bloc/auth/auth_bloc.dart';
import 'package:flutter_todo_list/bloc/note/note_bloc.dart';
import 'package:flutter_todo_list/screens/add_note_page.dart';
import 'package:flutter_todo_list/screens/detail_note_page.dart';
import 'package:flutter_todo_list/screens/home_page.dart';
import 'package:flutter_todo_list/screens/login_page.dart';
import 'package:flutter_todo_list/screens/sign_up_page.dart';
import 'package:flutter_todo_list/widgets/task_item.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getTemporaryDirectory(),
  );
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (_) => NoteBloc()..add(const LoadNotes())),
      BlocProvider(create: (_) => AuthBloc()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFFA347),
          primary: const Color(0xFFFFA347),
        ),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
