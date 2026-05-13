import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../models/campaign.dart';
import '../repositories/campaign_repository.dart';
import 'campaigns_state.dart';

@lazySingleton
class CampaignsCubit extends Cubit<CampaignsState> {
  final CampaignRepository _repository;
  StreamSubscription<List<Campaign>>? _subscription;

  CampaignsCubit(this._repository)
      : super(const CampaignsState(campaigns: [], isLoading: true));

  /// Loads all campaigns from Firestore once.
  Future<void> loadCampaigns() async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      final campaigns = await _repository.fetchCampaigns();
      emit(state.copyWith(campaigns: campaigns, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  /// Subscribes to real-time Firestore updates.
  /// Cancels any previous subscription before starting a new one.
  void watchCampaigns() {
    _subscription?.cancel();
    emit(state.copyWith(isLoading: true, error: null));
    _subscription = _repository.watchCampaigns().listen(
      (campaigns) {
        emit(state.copyWith(campaigns: campaigns, isLoading: false));
      },
      onError: (e) {
        emit(state.copyWith(isLoading: false, error: e.toString()));
      },
    );
  }

  Future<void> addCampaign(
    String title,
    String date,
    Color color, {
    String description = '',
    String location = '',
    double? targetAmount,
    String? coverImagePath,
    List<String> galleryImagePaths = const [],
    int categoryIndex = 0,
    String? organizationId,
  }) async {
    final newCampaign = Campaign(
      id: '', // Firestore will assign the real ID
      title: title,
      date: date,
      imageColor: color,
      description: description,
      location: location,
      targetAmount: targetAmount,
      coverImagePath: coverImagePath,
      galleryImagePaths: galleryImagePaths,
      categoryIndex: categoryIndex,
      organizationId: organizationId,
    );

    // Let the error propagate to the caller (AddCampaignScreen) for UI handling.
    final saved = await _repository.addCampaign(newCampaign);
    final updatedList = [saved, ...state.campaigns];
    emit(state.copyWith(campaigns: updatedList));
  }

  Future<void> updateCampaign(Campaign updatedCampaign) async {
    await _repository.updateCampaign(updatedCampaign);
    final updatedList = state.campaigns.map((c) {
      return c.id == updatedCampaign.id ? updatedCampaign : c;
    }).toList();
    emit(state.copyWith(campaigns: updatedList));
  }

  Future<void> removeCampaign(String id) async {
    await _repository.deleteCampaign(id);
    final updatedList = state.campaigns.where((c) => c.id != id).toList();
    emit(state.copyWith(campaigns: updatedList));
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
