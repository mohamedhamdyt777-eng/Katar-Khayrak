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
    Campaign(
      id: '4',
      date: '25 Jan',
      title: 'Clean Water for Rural Villages',
      imageColor: Colors.cyan.shade100,
      location: 'Fayoum, Egypt',
      categoryIndex: 1, // Most Needed
      targetAmount: 50000,
      raisedAmount: 12000,
      description:
          'Access to clean drinking water is a fundamental human right. We are building 10 new water wells in remote villages in Fayoum to provide safe water for hundreds of families. This is currently our most urgent and needed campaign.',
    ),
    Campaign(
      id: '5',
      date: '28 Jan',
      title: 'Ramadan Food Baskets',
      imageColor: Colors.green.shade100,
      location: 'Nationwide',
      categoryIndex: 2, // Most Donated
      targetAmount: 100000,
      raisedAmount: 85000,
      description:
          'Our annual Ramadan Food Basket drive is our most popular community initiative. Each basket contains enough essential food items (rice, oil, lentils, dates) to sustain a family of 5 for an entire month.',
    ),
    Campaign(
      id: '6',
      date: '10 Feb',
      title: 'Sponsor an Orphan',
      imageColor: Colors.purple.shade100,
      location: 'Giza, Egypt',
      categoryIndex: 5, // Orphans
      targetAmount: 30000,
      raisedAmount: 5000,
      description:
          'Make a lasting impact by sponsoring a child. Your monthly or one-time donation covers living expenses, clothing, and access to extracurricular activities for orphans in our care facilities.',
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
