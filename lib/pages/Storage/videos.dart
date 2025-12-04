import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

import '../../controllers/storage_controllers.dart';

class VideosTab extends StatefulWidget {
  const VideosTab({super.key});

  @override
  State<VideosTab> createState() => _VideosTabState();
}

class _VideosTabState extends State<VideosTab> {
  List<AssetEntity> videos = [];
  final Set<AssetEntity> selectedVideos = {};
  final Map<AssetEntity, Uint8List?> thumbnailCache = {};
  StorageController storageController = StorageController();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadVideos();
  }

  Future<void> loadVideos() async {
    final permission = await PhotoManager.requestPermissionExtend();
    if (!permission.isAuth) {
      setState(() => isLoading = false);
      return;
    }

    List<AssetPathEntity> albums = await PhotoManager.getAssetPathList(
      type: RequestType.video,
    );

    List<AssetEntity> allVideos = [];
    for (var album in albums) {
      int count = await album.assetCountAsync;
      List<AssetEntity> media = await album.getAssetListPaged(
        page: 0,
        size: count,
      );
      media = media.where((e) => e.type == AssetType.video).toList();
      allVideos.addAll(media);
    }

    if (!mounted) return;
    setState(() {
      videos = allVideos;
      isLoading = false;
    });
  }

  /// Safe thumbnail generator
  Future<Uint8List?> safeThumbnail(AssetEntity asset) async {
    if (asset.type != AssetType.video) return null;
    try {
      return await asset.thumbnailDataWithSize(const ThumbnailSize(200, 200));
    } catch (e) {
      print("Thumbnail error for ${asset.id}: $e");
      return null;
    }
  }

  Future<void> uploadSelectedVideos() async {
    List<File> filesToUpload = [];
    for (var asset in selectedVideos) {
      try {
        final file = await asset.file;
        if (file != null) filesToUpload.add(file);
        storageController.uploadFile(context, filesToUpload);
      } catch (e) {
        print("Error getting file for ${asset.id}: $e");
      }
    }

    if (filesToUpload.isEmpty) return;

    // Replace this with your actual upload logic
    print("Uploading ${filesToUpload.length} videos...");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Uploading ${filesToUpload.length} videos")),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (videos.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.videocam, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            const Text(
              "No videos found",
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: loadVideos,
              icon: const Icon(Icons.refresh),
              label: const Text("Refresh"),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: GridView.builder(
        padding: const EdgeInsets.all(4),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
        ),
        itemCount: videos.length,
        itemBuilder: (context, index) {
          final asset = videos[index];
          final selected = selectedVideos.contains(asset);

          Widget thumbnail;
          if (thumbnailCache.containsKey(asset)) {
            thumbnail = Image.memory(thumbnailCache[asset]!, fit: BoxFit.cover);
          } else {
            thumbnail = FutureBuilder<Uint8List?>(
              future: safeThumbnail(asset),
              builder: (_, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(color: Colors.grey[300]);
                }
                if (snapshot.hasData) {
                  thumbnailCache[asset] = snapshot.data!;
                  return Image.memory(snapshot.data!, fit: BoxFit.cover);
                }
                return Container(color: Colors.grey[300]);
              },
            );
          }

          return GestureDetector(
            onTap: () {
              setState(() {
                selected
                    ? selectedVideos.remove(asset)
                    : selectedVideos.add(asset);
              });
            },
            child: Stack(
              fit: StackFit.expand,
              children: [
                thumbnail,
                const Center(
                  child: Icon(
                    Icons.play_circle_fill,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
                if (selected)
                  Container(
                    color: Colors.black38,
                    child: const Center(
                      child: Icon(
                        Icons.check_circle,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: selectedVideos.isNotEmpty
          ? FloatingActionButton.extended(
              onPressed: uploadSelectedVideos,
              icon: const Icon(Icons.cloud_upload),
              label: Text("Upload (${selectedVideos.length})"),
            )
          : null,
    );
  }
}
