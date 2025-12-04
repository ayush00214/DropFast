import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';
import 'package:drop_fast/routes.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF007BFF),
              Color(0xFF5AA9FF),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /// WELCOME TITLE
                const Text(
                  'Welcome',
                  style: TextStyle(
                    fontSize: 34,
                    letterSpacing: 0.8,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 12),

                /// SUBTITLE
                const Text(
                  'Share your files securely and quickly',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 45),

                /// GET STARTED BUTTON
                CustomButton(
                  text: "Get Started",
                  onPressed: () => {
                    if(auth.currentUser == null)
                      {
                        Navigator.popAndPushNamed(context, AppRoute.loginpage)
                      }
                    else
                      {
                        Navigator.popAndPushNamed(context, AppRoute.homepage)
                      }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
