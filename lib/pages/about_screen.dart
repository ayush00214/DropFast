import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: const Color(0xFF007BFF),
        centerTitle: true,
        elevation: 3,
        title: const Text(
          "About DropFast",
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // ===== LOGO =====
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Center(
                child: Icon(
                  Icons.cloud_upload_rounded, // Replace with your logo if available
                  size: 50,
                  color: Color(0xFF007BFF),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // ===== WELCOME TITLE =====
            const Text(
              "Welcome to DropFast",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 15),

            // ===== WHAT IS DROPFAST =====
            const Text(
              "DropFast is a file-sharing application that allows you to easily upload files, generate QR codes, share download links, and manage your storage efficiently. Designed for simplicity and modern UI.",
              style: TextStyle(fontSize: 15, color: Colors.black87, height: 1.5),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 25),

            // ===== APP INFO SECTION =====
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "App Information",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(height: 12),
            _infoTile("Version", "1.0.0"),
            _infoTile("Last Updated", "February 2025"),
            const SizedBox(height: 25),

            // ===== DEVELOPER CONTACT =====
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Developer Contact",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(height: 12),
            _contactTile(
              icon: Icons.person_rounded,
              title: "Ayush Raj Khadka",
              subtitle: "Software Engineering Student",
            ),
            const SizedBox(height: 10),
            _contactTile(
              icon: Icons.email_rounded,
              title: "Email",
              subtitle: "ayushrajkhadka30@gmail.com",
            ),
            const SizedBox(height: 30),

            // ===== COPYRIGHT =====
            const Center(
              child: Text(
                "© 2025 DropFast. All rights reserved.",
                style: TextStyle(fontSize: 13, color: Colors.black54),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===== INFO TILE WIDGET =====
  Widget _infoTile(String title, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          Text(value, style: const TextStyle(fontSize: 16, color: Colors.black54)),
        ],
      ),
    );
  }

  // ===== CONTACT TILE WIDGET =====
  Widget _contactTile({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, size: 30, color: const Color(0xFF007BFF)),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                Text(subtitle,
                    style: const TextStyle(fontSize: 14, color: Colors.black54)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
