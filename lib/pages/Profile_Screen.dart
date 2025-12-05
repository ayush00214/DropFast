import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../models/UserModel.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Future<UserModel?>? Userdata;
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: const Color(0xFF007BFF),
        title: const Text("Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.white,
              child: Icon(Icons.person, size: 60, color: Colors.grey),
            ),
            const SizedBox(height: 15),

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
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(user.email, 
                    style: TextStyle(
                      color: Colors.grey
                      )
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 30),

            /// Storage bar
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 6,
                    color: Colors.black12.withOpacity(0.06),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Storage Used (Just Demo)", style: TextStyle(fontSize: 16)),
                  const SizedBox(height: 10),

                  /// Progress Bar
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: 0.65,
                      minHeight: 10,
                      color: const Color(0xFF007BFF),
                      backgroundColor: Colors.grey[200],
                    ),
                  ),

                  const SizedBox(height: 8),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text("4.5 GB Used"), Text("7 GB")],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
