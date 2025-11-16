import 'package:flutter/material.dart';
import 'package:drop_fast/routes.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushNamed(context, AppRoute.welcomepage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/logo.png', height: 120),
            const SizedBox(height: 20),
            const Text('DropFast',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Color(0xFF007BFF))),
            const SizedBox(height: 5),
            const Text('Fast & Secure File Sharing',
                style: TextStyle(color: Colors.grey, fontSize: 14)),
          ],
        ),
      ),
    );
  }
}
