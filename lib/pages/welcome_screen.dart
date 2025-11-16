import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Welcome',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            const Text('Share your files securely and quickly',
                style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 30),
            CustomButton(
              text: "Get Started",
              onPressed: () => Navigator.pushNamed(context, '/login'),
            )
          ],
        ),
      ),
    );
  }
}
