import 'package:drop_fast/routes.dart';
import 'package:drop_fast/services/auth_service.dart';
import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final AuthService _authService = AuthService();

  Future<void> signupUser() async {
    String? error = await _authService.signup(name.text, email.text, password.text);

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              const SizedBox(height: 70),

              /// LOGO
              Image.asset('assets/logo.png', height: 110),
              const SizedBox(height: 8),

              const Text(
                'DropFast',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF007BFF),
                ),
              ),
              const Text(
                'Fast & Secure File Sharing',
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),

              const SizedBox(height: 35),

              /// --------------------------
              ///  NAME FIELD
              /// --------------------------
              _inputField(
                hint: "Name",
                icon: Icons.person,
              ),
              const SizedBox(height: 18),

              /// --------------------------
              ///  EMAIL FIELD
              /// --------------------------
              _inputField(
                hint: "Email",
                icon: Icons.email,
              ),
              const SizedBox(height: 18),

              /// --------------------------
              ///  PASSWORD FIELD
              /// --------------------------
              _inputField(
                hint: "Password",
                icon: Icons.lock,
                obscure: true,
              ),

              const SizedBox(height: 15),

              /// LOGIN REDIRECT
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account? "),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, AppRoute.loginpage),
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        color: Color(0xFF007BFF),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              /// SIGN UP BUTTON
              CustomButton(
                text: "Sign Up",
                onPressed: () async => await signupUser(),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  /// -----------------------------------------------------
  ///  CUSTOM INPUT FIELD (ENHANCED UI)
  /// -----------------------------------------------------
  Widget _inputField({
    required String hint,
    required IconData icon,
    bool obscure = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
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
