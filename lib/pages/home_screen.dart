import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      appBar: AppBar(
        elevation: 3,
        backgroundColor: const Color(0xFF007BFF),
        centerTitle: true,
        title: const Text(
          "DropFast",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// TITLE
            const Text(
              "Quick Access",
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w800,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 25),

            /// MENU ITEMS
            _menuItem(
              Icons.cloud_upload_rounded,
              "Upload File",
              () => Navigator.pushNamed(context, '/upload'),
            ),

            _menuItem(
              Icons.folder_rounded,
              "Storage",
              () => Navigator.pushNamed(context, '/storage'),
            ),

            _menuItem(
              Icons.settings_rounded,
              "Settings",
              () => Navigator.pushNamed(context, '/settings'),
            ),

            const Spacer(),

            /// FOOTER STORAGE INFO
            _infoBox(),
          ],
        ),
      ),
    );
  }

  // ------------------------------------------------------------
  //   MENU ITEM
  // ------------------------------------------------------------
  Widget _menuItem(IconData icon, String label, VoidCallback onTap) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        splashColor: const Color(0xFF007BFF).withOpacity(0.12),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.black12.withOpacity(0.07),
                blurRadius: 14,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 22),
            child: Row(
              children: [

                /// ICON CONTAINER
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF007BFF).withOpacity(0.12),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(icon, size: 30, color: const Color(0xFF007BFF)),
                ),

                const SizedBox(width: 22),

                /// TEXT LABEL
                Expanded(
                  child: Text(
                    label,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ),

                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 18,
                  color: Colors.black45,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ------------------------------------------------------------
  //   STORAGE INFO BOX
  // ------------------------------------------------------------
  Widget _infoBox() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 18),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.blue.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: const Text(
        "Clean Up: 14.4KB   |   Used: 5.0MB",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 15.5,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
    );
  }
}
