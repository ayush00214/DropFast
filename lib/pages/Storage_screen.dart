import 'package:flutter/material.dart';

class StorageScreen extends StatelessWidget {
  const StorageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          backgroundColor: const Color(0xFF007BFF),
          title: const Text("Storage"),
          bottom: const TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: "Images"),
              Tab(text: "Video"),
              Tab(text: "Docs"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _gridView(),
            _gridView(),
            _gridView(),
          ],
        ),
      ),
    );
  }

  Widget _gridView() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: GridView.builder(
        itemCount: 6,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
        ),
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  blurRadius: 6,
                  color: Colors.black12.withOpacity(0.05),
                )
              ],
            ),
            child: const Icon(
              Icons.insert_drive_file,
              size: 40,
              color: Color(0xFF007BFF),
            ),
          );
        },
      ),
    );
  }
}
