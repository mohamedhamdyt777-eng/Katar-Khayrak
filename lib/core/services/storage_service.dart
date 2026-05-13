import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

/// Handles file uploads to Firebase Storage and returns download URLs.
class StorageService {
  static final _storage = FirebaseStorage.instance;

  /// Uploads a cover image for a campaign and returns its download URL.
  static Future<String> uploadCoverImage(String campaignId, String localPath) async {
    final file = File(localPath);
    final ext = localPath.split('.').last;
    final ref = _storage.ref('campaigns/$campaignId/cover.$ext');
    await ref.putFile(file);
    return ref.getDownloadURL();
  }

  /// Uploads multiple gallery images and returns their download URLs.
  static Future<List<String>> uploadGalleryImages(
    String campaignId,
    List<String> localPaths,
  ) async {
    final urls = <String>[];
    for (var i = 0; i < localPaths.length; i++) {
      final file = File(localPaths[i]);
      final ext = localPaths[i].split('.').last;
      final ref = _storage.ref('campaigns/$campaignId/gallery_$i.$ext');
      await ref.putFile(file);
      urls.add(await ref.getDownloadURL());
    }
    return urls;
  }

  /// Deletes all files stored under a campaign's storage path.
  static Future<void> deleteCampaignFiles(String campaignId) async {
    try {
      final listResult =
          await _storage.ref('campaigns/$campaignId').listAll();
      for (final item in listResult.items) {
        await item.delete();
      }
    } catch (_) {
      // Ignore if folder doesn't exist
    }
  }
}
