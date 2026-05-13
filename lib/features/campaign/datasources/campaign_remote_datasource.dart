import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../models/campaign.dart';

@injectable
class CampaignRemoteDatasource {
  final FirebaseFirestore _firestore;

  CampaignRemoteDatasource() : _firestore = FirebaseFirestore.instance;

  CollectionReference get _campaigns => _firestore.collection('campaigns');

  Future<List<Campaign>> fetchCampaigns() async {
    final snapshot = await _campaigns
        .orderBy('createdAt', descending: true)
        .get();

    return snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return Campaign.fromFirestore(doc.id, data);
    }).toList();
  }

  Future<Campaign> addCampaign(Campaign campaign) async {
    final docRef = await _campaigns.add(campaign.toFirestore());
    return campaign.copyWith(id: docRef.id);
  }

  Future<void> updateCampaign(Campaign campaign) async {
    await _campaigns.doc(campaign.id).update(campaign.toFirestore());
  }

  Future<void> deleteCampaign(String id) async {
    await _campaigns.doc(id).delete();
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
