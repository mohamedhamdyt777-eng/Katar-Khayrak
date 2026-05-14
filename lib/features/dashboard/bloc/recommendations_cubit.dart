import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../campaign/models/campaign.dart';

@lazySingleton
class RecommendationsCubit extends Cubit<List<Campaign>> {
  RecommendationsCubit() : super([]);

  void loadRecommendations() {
    // Mocking recommendation logic
    final mockRecommendations = [
      const Campaign(
        id: 'org1',
        title: 'Misr El Kheir',
        date: '',
        imageColor: Colors.purple,
        location: 'Egypt',
        coverImagePath: 'assets/images/Misr El Kheir.png',
        description: 'Misr El Kheir Foundation is a non-profit development institution aiming to develop the Egyptian individual in comprehensive ways.',
      ),
      const Campaign(
        id: 'org2',
        title: 'Bayt Al Zakat and Al Sadaqat',
        date: '',
        imageColor: Colors.blue,
        location: 'Egypt',
        coverImagePath: 'assets/images/bait_al_zakat.png',
        description: 'Bayt Al Zakat and Al Sadaqat aims to channel Zakat and charity funds to those who deserve them.',
      ),
      const Campaign(
        id: 'org3',
        title: 'Resala Charity Organization',
        date: '',
        imageColor: Colors.indigo,
        location: 'Egypt',
        coverImagePath: 'assets/images/resala.png',
        description: 'Resala is one of the most widespread charities in Egypt, operating across many volunteering sectors.',
      ),
      const Campaign(
        id: 'org4',
        title: 'Al Orman Association',
        date: '',
        imageColor: Colors.teal,
        location: 'Egypt',
        coverImagePath: 'assets/images/orman.png',
        description: 'Al Orman Association provides various services to support the poor and orphans across all Egyptian governorates.',
      ),
    ];
    emit(mockRecommendations);
  }
}
