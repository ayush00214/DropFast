import 'package:drop_fast/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../widgets/custom_button.dart';
import 'package:drop_fast/routes.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final AuthService authService = AuthService();

    
    void showProcessing() {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) =>
            Center(child: Lottie.asset('assets/processing.json', height: 180)),
      );
    }

    Future<void> loginUser() async {
      showProcessing();
      String? error = await authService.login(
        emailController.text,
        passwordController.text,
      );

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
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              const SizedBox(height: 80),

              /// LOGO
              Image.asset('assets/logo.png', height: 110),
              const SizedBox(height: 12),

              /// TITLE
              const Text(
                'DropFast',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF007BFF),
                ),
              ),

              /// SUBTITLE
              const Text(
                'Fast & Secure File Sharing',
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
              const SizedBox(height: 35),

              /// --------------------------
              /// EMAIL TEXT FIELD
              /// --------------------------
              _inputField(
                hint: "Email",
                icon: Icons.email,
                controller: emailController,
              ),

              const SizedBox(height: 20),

              /// --------------------------
              /// PASSWORD FIELD
              /// --------------------------
              _inputField(
                hint: "Password",
                icon: Icons.lock,
                obscure: true,
                controller: passwordController,
              ),

              const SizedBox(height: 15),

              /// SIGNUP REDIRECT
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don’t have an account? "),
                  GestureDetector(
                    onTap: () =>
                        Navigator.pushNamed(context, AppRoute.signuppage),
                    child: const Text(
                      "Sign up",
                      style: TextStyle(
                        color: Color(0xFF007BFF),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              /// LOGIN BUTTON
              CustomButton(
                text: "Login",
                onPressed: () async => await loginUser(),
              ),

              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  /// -----------------------------------------------
  /// CUSTOM INPUT FIELD (CLEAN + MODERN)
  /// -----------------------------------------------
  Widget _inputField({
    required String hint,
    required IconData icon,
    required TextEditingController controller,
    bool obscure = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            blurRadius: 8,
            offset: const Offset(0, 4),
            color: Colors.black12.withOpacity(0.06),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Color(0xFF007BFF)),
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }
}
