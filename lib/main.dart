import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_daily_notes/bloc/auth/auth_bloc.dart';
import 'package:flutter_daily_notes/bloc/note/note_bloc.dart';
import 'package:flutter_daily_notes/screens/home_page.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Alarm.init();

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getTemporaryDirectory(),
  );
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (_) => AuthBloc()),
      BlocProvider(create: (_) => NoteBloc()..add(const LoadNotes())),
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
      builder: (context, child) {
        return BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            final error = state.status == AuthStatus.error;

            if (error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          child: child,
        );
      },
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
