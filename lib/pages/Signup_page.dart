import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/logo.png', height: 100),
            const Text('DropFast',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF007BFF))),
            const Text('Fast & Secure File Sharing',
                style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 25),
            const TextField(decoration: InputDecoration(hintText: 'Name', border: OutlineInputBorder())),
            const SizedBox(height: 15),
            const TextField(decoration: InputDecoration(hintText: 'Email', border: OutlineInputBorder())),
            const SizedBox(height: 15),
            const TextField(
                obscureText: true,
                decoration: InputDecoration(hintText: 'Password', border: OutlineInputBorder(), suffixIcon: Icon(Icons.lock))),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account? "),
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/login'),
                  child: const Text("Login", style: TextStyle(color: Color(0xFF007BFF))),
                ),
              ],
            ),
            const SizedBox(height: 20),
            CustomButton(
              text: "Sign Up",
              onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
            )
          ],
        ),
      ),
    );
  }
}
