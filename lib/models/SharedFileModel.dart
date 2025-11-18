class SharedFileModel {
  final String id;
  final String userId;
  final String token;
  final DateTime createdAt;
  final DateTime expiresAt;
  final List<FileInfo> files;

  SharedFileModel({
    required this.id,
    required this.userId,
    required this.token,
    required this.createdAt,
    required this.expiresAt,
    required this.files,
  });

  factory SharedFileModel.fromJson(Map<String, dynamic> json) {
    return SharedFileModel(
      id: json["_id"],
      userId: json["userId"],
      token: json["token"],
      createdAt: DateTime.parse(json["createdAt"]),
      expiresAt: DateTime.parse(json["expiresAt"]), // FIXED
      files: (json["files"] as List).map((e) => FileInfo.fromJson(e)).toList(),
    );
  }
}

class FileInfo {
  final String originalName;
  final String filename;
  final int size;
  final String path;

  FileInfo({
    required this.originalName,
    required this.filename,
    required this.size,
    required this.path,
  });

  factory FileInfo.fromJson(Map<String, dynamic> json) {
    return FileInfo(
      originalName: json["originalName"],
      filename: json["filename"],
      size: json["size"],
      path: json["path"],
    );
  }
}
