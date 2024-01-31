import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/core/dependency_injection/di_container.dart';
import 'package:quiz_app/features/domain/bloc/auth/auth_bloc.dart';
import 'package:quiz_app/features/presentation/credential/login.dart';
// import 'package:quiz_app/features/presentation/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final DIContainer diContainer = DIContainer();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: primaryColor,
        canvasColor: canvasColor,
        scaffoldBackgroundColor: scaffoldBackgroundColor,
        textTheme: const TextTheme(
          headlineSmall: TextStyle(
            color: Colors.white,
            fontSize: 46,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      home: MultiBlocProvider(
          providers: [
            BlocProvider<AuthBloc>(
              create: (BuildContext context) => diContainer.authBloc,
            ),
          ],
        child: const LoginPage()
        ),
    );
  }
}

const textColor = Colors.brown;
const primaryColor = Colors.grey;
const canvasColor = Color.fromARGB(255, 33, 32, 75);
const scaffoldBackgroundColor = Colors.white38;
const accentCanvasColor = Color.fromRGBO(98, 114, 94, 1);
const white = Colors.white;
final actionColor = const Color(0xFF5F5FA7).withOpacity(0.6);
final divider = Divider(color: white.withOpacity(0.3), height: 1);
