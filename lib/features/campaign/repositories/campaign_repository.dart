import 'package:injectable/injectable.dart';

import '../datasources/campaign_remote_datasource.dart';
import '../models/campaign.dart';

@injectable
class CampaignRepository {
  final CampaignRemoteDatasource _remote;

  CampaignRepository(this._remote);

  Future<List<Campaign>> fetchCampaigns() => _remote.fetchCampaigns();

  Future<Campaign> addCampaign(Campaign campaign) =>
      _remote.addCampaign(campaign);

  Future<void> updateCampaign(Campaign campaign) =>
      _remote.updateCampaign(campaign);

  Future<void> deleteCampaign(String id) => _remote.deleteCampaign(id);

  Stream<List<Campaign>> watchCampaigns() => _remote.watchCampaigns();
}
