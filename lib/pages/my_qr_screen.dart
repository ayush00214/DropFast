import 'package:drop_fast/models/UserModel.dart';
import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class MyQrScreen extends StatelessWidget {
  const MyQrScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthService _authService = AuthService();
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: const Color(0xFF007BFF),
        elevation: 2,
        title: const Text("My QR"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            /// QR CODE
            Container(
              height: 230,
              width: 230,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                image: const DecorationImage(
                  image: AssetImage("assets/qr.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "DropFast",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            FutureBuilder<UserModel?>(
              future: _authService.getCurrentUser(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final user = snapshot.data!;

                return Column(
                  children: [
                    Text(
                      user.name,
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(user.email, style: TextStyle(color: Colors.grey)),
                  ],
                );
              },
            ),
            const SizedBox(height: 30),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [_actionButton("Download QR"), _actionButton("Scan")],
            ),
          ],
        ),
      ),
    );
  }

  Widget _actionButton(String text) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF007BFF),
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
      ),
      child: Text(text),
    );
  }
}
