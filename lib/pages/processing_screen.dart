import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ProcessingScreen extends StatefulWidget {
  final String nextRoute;

  const ProcessingScreen({super.key, required this.nextRoute});

  @override
  State<ProcessingScreen> createState() => _ProcessingScreenState();
}

class _ProcessingScreenState extends State<ProcessingScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, widget.nextRoute);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset(
          'assets/processing.json',
          height: 180,
        ),
      ),
    );
  }
}
