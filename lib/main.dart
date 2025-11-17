import 'package:flutter/material.dart';
import 'pages/splash_screen.dart';
import 'pages/welcome_screen.dart';
import 'pages/login_page.dart';
import 'pages/Signup_page.dart';
import 'pages/home_screen.dart';
import 'pages/upload_screen.dart';
import 'pages/FilePreviewScreen.dart';
import 'pages/my_qr_screen.dart';
import 'pages/Storage_screen.dart';
import 'pages/SettingsScreen.dart';
import 'pages/Profile_screen.dart';

void main() {
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
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/welcome': (context) => const WelcomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignupScreen(),
        '/home': (context) => const HomeScreen(),
        '/upload': (context) => const UploadScreen(),
        '/filePreview': (context) => const FilePreviewScreen(),
        '/myQr': (context) => const MyQrScreen(),
        '/storage': (context) => const StorageScreen(),
        '/settings': (context) => const SettingsScreen(),
        '/profile': (context) => const ProfileScreen(),
      },
    );
  }
}
