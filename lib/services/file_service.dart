import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import '../models/SharedFileModel.dart';

class FileService {
  final String baseUrl =
      "http://google-discussing.gl.at.ply.gg:16557/api/files";

  Future<String> uploadFiles(List<File> files, BuildContext context) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception("User not logged in");

    final token = await user.getIdToken();

    var req = http.MultipartRequest('POST', Uri.parse("$baseUrl/upload"));

    /// Add headers BEFORE sending
    req.headers['Authorization'] = 'Bearer $token';

    /// Add all selected files
    for (var file in files) {
      req.files.add(await http.MultipartFile.fromPath("files", file.path));
    }

    /// Send the request
    var resp = await req.send();
    var body = await http.Response.fromStream(resp);

    if (resp.statusCode != 200) {
      throw Exception("Upload failed: ${body.body}");
    }
    final data = jsonDecode(body.body);

    return data["url"];
  }

  Future<List<SharedFileModel>> getMyFiles() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception("User not logged in");

    final token = await user.getIdToken();

    final url = Uri.parse("$baseUrl/my-files");

    final response = await http.get(
      url,
      headers: {
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to fetch files: ${response.body}");
    }

    final List data = jsonDecode(response.body);

    return data
        .map((json) => SharedFileModel.fromJson(json))
        .toList();
  }
}
