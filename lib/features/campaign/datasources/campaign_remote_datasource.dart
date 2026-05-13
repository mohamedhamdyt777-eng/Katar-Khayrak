import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../../../core/services/storage_service.dart';
import '../models/campaign.dart';

@injectable
class CampaignRemoteDatasource {
  final FirebaseFirestore _firestore;

  CampaignRemoteDatasource() : _firestore = FirebaseFirestore.instance;

  CollectionReference get _campaigns => _firestore.collection('campaigns');

  Future<List<Campaign>> fetchCampaigns() async {
    final snapshot =
        await _campaigns.orderBy('createdAt', descending: true).get();
    return snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return Campaign.fromFirestore(doc.id, data);
    }).toList();
  }

  /// Adds a campaign: uploads images to Firebase Storage first, then writes to Firestore.
  Future<Campaign> addCampaign(Campaign campaign) async {
    // 1. Pre-generate a Firestore document reference so we can use its ID as the storage path.
    final docRef = _campaigns.doc();
    final campaignId = docRef.id;

    // 2. Upload cover image if it's a local file path.
    String? coverUrl = campaign.coverImagePath;
    if (coverUrl != null && File(coverUrl).existsSync()) {
      coverUrl = await StorageService.uploadCoverImage(campaignId, coverUrl);
    }

    // 3. Upload gallery images that are local file paths.
    final localGallery = campaign.galleryImagePaths
        .where((p) => File(p).existsSync())
        .toList();
    List<String> galleryUrls = campaign.galleryImagePaths
        .where((p) => !File(p).existsSync())
        .toList(); // keep any that are already URLs

    if (localGallery.isNotEmpty) {
      final uploaded =
          await StorageService.uploadGalleryImages(campaignId, localGallery);
      galleryUrls = [...galleryUrls, ...uploaded];
    }

    // 4. Build the final campaign with Storage URLs and save to Firestore.
    final savedCampaign = campaign.copyWith(
      id: campaignId,
      coverImagePath: coverUrl,
      galleryImagePaths: galleryUrls,
    );

    await docRef.set(savedCampaign.toFirestore());
    return savedCampaign;
  }

  Future<void> updateCampaign(Campaign campaign) async {
    // Handle image updates: upload any new local paths.
    String? coverUrl = campaign.coverImagePath;
    if (coverUrl != null && File(coverUrl).existsSync()) {
      coverUrl =
          await StorageService.uploadCoverImage(campaign.id, coverUrl);
    }

    final localGallery =
        campaign.galleryImagePaths.where((p) => File(p).existsSync()).toList();
    List<String> galleryUrls = campaign.galleryImagePaths
        .where((p) => !File(p).existsSync())
        .toList();

    if (localGallery.isNotEmpty) {
      final uploaded = await StorageService.uploadGalleryImages(
          campaign.id, localGallery);
      galleryUrls = [...galleryUrls, ...uploaded];
    }

    final updatedCampaign = campaign.copyWith(
      coverImagePath: coverUrl,
      galleryImagePaths: galleryUrls,
    );

    await _campaigns.doc(campaign.id).update(updatedCampaign.toFirestore());
  }

  Future<void> deleteCampaign(String id) async {
    await _campaigns.doc(id).delete();
    await StorageService.deleteCampaignFiles(id);
  }

  Stream<List<Campaign>> watchCampaigns() {
    return _campaigns
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              final data = doc.data() as Map<String, dynamic>;
              return Campaign.fromFirestore(doc.id, data);
            }).toList());
  }
}
