class CampaignsState {
  final List<dynamic> campaigns;
  final bool isLoading;
  final String? error;

  const CampaignsState({
    required this.campaigns,
    this.isLoading = false,
    this.error,
  });

  CampaignsState copyWith({
    List<dynamic>? campaigns,
    bool? isLoading,
    String? error,
  }) {
    return CampaignsState(
      campaigns: campaigns ?? this.campaigns,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}
