import '../models/campaign.dart';

class CampaignsState {
  final List<Campaign> campaigns;

  const CampaignsState({this.campaigns = const []});

  CampaignsState copyWith({List<Campaign>? campaigns}) {
    return CampaignsState(
      campaigns: campaigns ?? this.campaigns,
    );
  }
}
