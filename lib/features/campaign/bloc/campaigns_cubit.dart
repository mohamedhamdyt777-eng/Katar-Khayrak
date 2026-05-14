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
      coverImagePath: 'assets/images/aswan_medical_camp.png',
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
      coverImagePath: 'assets/images/orphan_school_bag.png',
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
      coverImagePath: 'assets/images/flood_relief.png',
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
      coverImagePath: 'assets/images/egypt_water_well.png',
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
      coverImagePath: 'assets/images/ramadan_food_box.png',
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
      coverImagePath: 'assets/images/sponsor_orphan.png',
      description:
          'Make a lasting impact by sponsoring a child. Your monthly or one-time donation covers living expenses, clothing, and access to extracurricular activities for orphans in our care facilities.',
    ),
    Campaign(
      id: '7',
      date: '15 Feb',
      title: 'Winter Clothes for the Poor',
      imageColor: Colors.indigo.shade100,
      location: 'Cairo, Egypt',
      categoryIndex: 1, // Most Needed
      coverImagePath: 'assets/images/winter_clothes.png',
      description:
          'As temperatures drop, thousands of Egyptians face bitter cold without adequate clothing. Help us distribute warm jackets, blankets, and winter essentials to vulnerable families in the streets of Cairo.',
    ),
    Campaign(
      id: '8',
      date: '20 Feb',
      title: 'Care for People with Disabilities',
      imageColor: Colors.amber.shade100,
      location: 'Alexandria, Egypt',
      categoryIndex: 3, // Health
      targetAmount: 40000,
      coverImagePath: 'assets/images/disabled_care.png',
      description:
          'We fund physiotherapy sessions, assistive devices, and specialized care for children and adults living with disabilities across Egypt. Your support gives them mobility, independence, and hope.',
    ),
    Campaign(
      id: '9',
      date: '1 Mar',
      title: 'Support for the Elderly',
      imageColor: Colors.brown.shade100,
      location: 'Nationwide',
      categoryIndex: 2, // Most Donated
      targetAmount: 20000,
      coverImagePath: 'assets/images/elderly_support.png',
      description:
          'Thousands of elderly Egyptians spend their final years alone and forgotten. Our volunteers visit nursing homes and homes across Egypt to provide companionship, meals, and medical support to those who need it most.',
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
