import '../models/campaign.dart';

class CampaignsState {
  final List<Campaign> campaigns;
  final bool isLoading;
  final String? error;

  const CampaignsState({
    required this.campaigns,
    this.isLoading = false,
    this.error,
  });

  CampaignsState copyWith({
    List<Campaign>? campaigns,
    bool? isLoading,
    String? error,
  }) {
    return CampaignsState(
      campaigns: campaigns ?? this.campaigns,
      isLoading: isLoading ?? this.isLoading,
      error: error, // null clears error intentionally
    );
  }
}
