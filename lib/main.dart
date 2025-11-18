import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:drop_fast/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await  Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  print("APP STARTED");
  runApp(const DropFast());
}

class DropFast extends StatelessWidget {
  const DropFast({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DropFast',
      theme: ThemeData(
        primaryColor: const Color(0xFF007BFF),
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Poppins',
      ),
      initialRoute: AppRoute.initialpage,
      routes: AppRoute.getAppRoutes(),
    );
  }
}
