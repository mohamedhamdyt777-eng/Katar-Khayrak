import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../models/campaign.dart';
import 'campaigns_state.dart';

@lazySingleton
class CampaignsCubit extends Cubit<CampaignsState> {
  CampaignsCubit() : super(CampaignsState(campaigns: _initialCampaigns));

  static final List<Campaign> _initialCampaigns = [
    Campaign(
      id: '1',
      date: '21 Jan',
      title: 'Medical Camp in Aswan',
      imageColor: Colors.teal.shade100,
      location: 'Aswan, Egypt',
      categoryIndex: 3, // Health
      description:
          'Join us for our upcoming medical camp in Aswan. We will be providing free health checkups, medicine, and specialized consultations to over 500 residents in need. Your contribution helps us cover the cost of supplies and travel for our volunteer doctors.',
    ),
    Campaign(
      id: '2',
      date: '22 Jan',
      title: 'School Supplies for Orphans',
      imageColor: Colors.blue.shade100,
      location: 'Cairo, Egypt',
      categoryIndex: 4, // Education
      description:
          'Help us equip 200 orphaned children with the essential school supplies they need for the new academic year. Backpacks, notebooks, and stationery will be distributed at the local community center.',
    ),
    Campaign(
      id: '3',
      date: '23 Jan',
      title: 'Emergency Flood Relief',
      imageColor: Colors.orange.shade100,
      location: 'Alexandria, Egypt',
      categoryIndex: 6, // Disaster Relief
      description:
          'Recent severe weather has displaced many families. We are collecting funds to provide emergency shelter, warm blankets, and hot meals. Act now to provide immediate assistance to those affected.',
    ),
  ];

  void addCampaign(
    String title,
    String date,
    Color color, {
    String description = '',
    double? targetAmount,
    String? coverImagePath,
    List<String> galleryImagePaths = const [],
    int categoryIndex = 0,
  }) {
    final newCampaign = Campaign(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      date: date,
      imageColor: color,
      description: description,
      targetAmount: targetAmount,
      coverImagePath: coverImagePath,
      galleryImagePaths: galleryImagePaths,
      categoryIndex: categoryIndex,
    );

    final updatedList = [newCampaign, ...state.campaigns];
    emit(state.copyWith(campaigns: updatedList));
  }

  void updateCampaign(Campaign updatedCampaign) {
    final updatedList = state.campaigns.map((campaign) {
      return campaign.id == updatedCampaign.id ? updatedCampaign : campaign;
    }).toList();
    emit(state.copyWith(campaigns: updatedList));
  }

  void removeCampaign(String id) {
    final updatedList = state.campaigns
        .where((campaign) => campaign.id != id)
        .toList();
    emit(state.copyWith(campaigns: updatedList));
  }
}
