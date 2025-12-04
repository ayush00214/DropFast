import 'dart:io';
import 'dart:typed_data';

import 'package:drop_fast/routes.dart';
import 'package:drop_fast/services/file_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

class StorageController extends ChangeNotifier {
  // Storage controller code here
  List<AssetEntity> images = [];
  List<AssetEntity> videos = [];
  List<PlatformFile> docs = [];
  Map<AssetEntity, Uint8List?> thumbnailCache = {};

  bool isUploading = false;
  List<File>? files;
  final FileService _fileService = FileService();

  AssetPathEntity? imageAlbum;
  AssetPathEntity? videoAlbum;

  int imagePage = 0;
  int videoPage = 0;

  final Set<dynamic> selectedFiles = <dynamic>{};

  Future<void> uploadFile(BuildContext context, List<File>? files) async {
    if (files == null) return;
    isUploading = true;
    notifyListeners();

    try {
      Navigator.pushNamed(context, AppRoute.uploadpage, arguments: files);
    } catch (e) {
      print("Upload failed: $e");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Upload failed: $e")));
    } finally {
      isUploading = false;
      notifyListeners();
    }
  }

  // LOAD IMAGES + VIDEOS
  // -------------------------------------------
  Future<void> loadMedia() async {
    final ps = await PhotoManager.requestPermissionExtend();
    if (!ps.isAuth) return;

    // IMAGES ONLY
    final imgAlbums = await PhotoManager.getAssetPathList(
      type: RequestType.image,
    );
    if (imgAlbums.isNotEmpty) {
      imageAlbum = imgAlbums.first;
      final rawImages = await imageAlbum!.getAssetListPaged(page: 0, size: 80);

      // Strictly filter AssetType.image
      images = rawImages.where((a) => a.type == AssetType.image).toList();
      print("Loaded ${images.length} images");

      await _cacheThumbnails(images);
    }

    // VIDEOS ONLY
    final vidAlbums = await PhotoManager.getAssetPathList(
      type: RequestType.video,
    );
    if (vidAlbums.isNotEmpty) {
      videoAlbum = vidAlbums.first;
      final rawVideos = await videoAlbum!.getAssetListPaged(page: 0, size: 80);

      // Strictly filter AssetType.video
      videos = rawVideos.where((a) => a.type == AssetType.video).toList();
      print("Loaded ${videos.length} videos");

      await _cacheThumbnails(videos);
    }

    notifyListeners();
  }

  Future<void> _cacheThumbnails(List<AssetEntity> list) async {
    for (var asset in list) {
      if (!thumbnailCache.containsKey(asset)) {
        final thumb = await asset.thumbnailDataWithSize(
          const ThumbnailSize(200, 200),
        );
        if (thumb != null) {
          thumbnailCache[asset] = thumb;
        }
      }
    }
  }

  Future<void> loadMoreMedia(
    List<AssetEntity> list,
    AssetPathEntity album,
    bool isImage,
  ) async {
    final nextPage = isImage ? ++imagePage : ++videoPage;
    final more = await album.getAssetListPaged(page: nextPage, size: 80);
    if (more.isNotEmpty) {
      list.addAll(more);
      await _cacheThumbnails(more); // cache new items
      notifyListeners();
    }
  }

  void toggleSelection(dynamic item) {
    selectedFiles.contains(item)
        ? selectedFiles.remove(item)
        : selectedFiles.add(item);
    notifyListeners();
  }

  // -------------------------------------------
  // PICK DOCUMENTS
  // -------------------------------------------
  Future<void> pickDocuments() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.any,
    );

    if (result != null) {
      files = result.paths.map((path) => File(path!)).toList();
      notifyListeners();
    }
  }
}
