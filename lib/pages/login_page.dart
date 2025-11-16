import 'package:drop_fast/services/auth_service.dart';
import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';
import 'package:drop_fast/routes.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final AuthService authService = AuthService();

    Future<void> loginUser() async {
      String? error = await authService.login(emailController.text, passwordController.text);

      if (error != null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(error)));
      } else {
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoute.homepage,
          (route) => false,
        );
      }
    }
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/logo.png', height: 100),
            const SizedBox(height: 10),
            const Text(
              'DropFast',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF007BFF),
              ),
            ),
            const Text(
              'Fast & Secure File Sharing',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 25),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                hintText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: 'Password',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.lock),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don’t have an account? "),
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, AppRoute.signuppage),
                  child: const Text(
                    "Sign up",
                    style: TextStyle(color: Color(0xFF007BFF)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            CustomButton(
              text: "Login",
              onPressed: () async => await loginUser(),
            ),
          ],
        ),
      ),
    );
  }
}
