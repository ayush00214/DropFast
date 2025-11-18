import 'dart:io';
import 'package:drop_fast/pages/QRScreen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:drop_fast/routes.dart';
import 'package:drop_fast/services/file_service.dart';
import 'package:drop_fast/models/SharedFileModel.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  final FileService _fileService = FileService();
  bool isUploading = false;
  List<File>? files;
  Future<List<SharedFileModel>>? file_service;

  @override
  void initState() {
    super.initState();
    file_service = _fileService.getMyFiles();
  }

  Future<void> pickFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'doc'],
    );
    if (result == null) return;

    setState(() {
      files = result.paths.map((path) => File(path!)).toList();
    });
  }

  /// Upload file
  Future<void> uploadFile() async {
    if (files == null) return;

    setState(() => isUploading = true);

    try {
      final url = await _fileService.uploadFiles(files!, context);

      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => QRScreen(url: url)),
      );
    } catch (e) {
      print("Upload failed: $e");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Upload failed: $e")));
    }

    setState(() => isUploading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Share Files"),
        backgroundColor: const Color(0xFF007BFF),
        centerTitle: true,
      ),

      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Upload File",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),

                /// PICK FILE BOX
                GestureDetector(
                  onTap: pickFiles,
                  child: Container(
                    height: 160,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: (files == null || files!.isEmpty)
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.cloud_upload,
                                size: 45,
                                color: Colors.grey,
                              ),
                              Text(
                                "Tap to select files",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          )
                        : Padding(
                            padding: const EdgeInsets.all(10),
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: files!.length,
                              itemBuilder: (context, index) {
                                final file = files![index];
                                return Row(
                                  children: [
                                    const Icon(
                                      Icons.insert_drive_file,
                                      color: Colors.blue,
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        file.path.split('/').last,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        setState(() => files!.removeAt(index));
                                      },
                                      icon: const Icon(
                                        Icons.close,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                  ),
                ),

                const SizedBox(height: 15),

                /// UPLOAD BUTTON
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      print("Upload pressed");
                      isUploading ? null : uploadFile();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF007BFF),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: isUploading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text("Upload File"),
                  ),
                ),

                const SizedBox(height: 30),

                const Text(
                  "Recent Files",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 10),

                /// 📌 RECENT FILES LIST (NON-SCROLLABLE)
                Expanded(
                  child: NotificationListener<OverscrollIndicatorNotification>(
                    onNotification: (notification) {
                      notification.disallowIndicator(); // remove glow overlay
                      return true;
                    },
                    child: FutureBuilder<List<SharedFileModel>>(
                      future: file_service,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return const Center(child: Text("No recent files."));
                        }

                        final files = snapshot.data!;

                        return ListView.builder(
                          itemCount: files.length,
                          itemBuilder: (context, index) {
                            final file = files[index];
                            return _fileItem(
                              file.files.first.originalName,
                              createdAt: file.createdAt,
                              expiresAt: file.expiresAt,
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 60),
              ],
            ),
          ),

          /// FLOATING QR BUTTON
          Positioned(
            right: 20,
            top: 10,
            child: GestureDetector(
              onTap: () => Navigator.pushNamed(context, AppRoute.myqrpage),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF007BFF),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(Icons.qr_code, color: Colors.white, size: 28),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Recent file item widget
  Widget _fileItem(
    String name, {
    required DateTime createdAt,
    required DateTime expiresAt,
  }) {
    return ListTile(
      leading: const Icon(Icons.insert_drive_file),
      title: Text(name),
      subtitle: Text(
        "Created: ${createdAt.toLocal()}\nExpires: ${expiresAt.toLocal()}",
      ),
    );
  }
}
