import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:katar_khayrak/features/notifications/bloc/notifications_cubit.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/bloc/app_cubit.dart';
import '../../auth/bloc/auth_cubit.dart';
import '../../auth/bloc/auth_state.dart';
import '../../notifications/bloc/notifications_state.dart';
import '../../campaign/bloc/campaigns_cubit.dart';
import '../../campaign/bloc/campaigns_state.dart';
import '../bloc/recommendations_cubit.dart';
import '../../campaign/widgets/campaign_card.dart';
import '../../campaign/models/campaign.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int _selectedCategoryIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CampaignsCubit>().watchCampaigns();
      context.read<RecommendationsCubit>().loadRecommendations();
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final user = context.select((AuthCubit cubit) => 
      cubit.state.maybeWhen(
        authenticated: (user) => user,
        orElse: () => null,
      )
    );

    final categories = [
      {'label': l10n.categoryAll, 'icon': Icons.grid_view},
      {'label': l10n.categories_most_needed, 'icon': Icons.priority_high},
      {'label': l10n.categories_most_donated, 'icon': Icons.monetization_on},
      {'label': l10n.categories_health, 'icon': Icons.medical_services_outlined},
      {'label': l10n.categories_education, 'icon': Icons.school_outlined},
      {'label': l10n.categories_orphans, 'icon': Icons.child_care},
      {'label': l10n.categories_disaster, 'icon': Icons.warning_amber_rounded},
    ];

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
          // Custom AppBar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.welcomeBack,
                        style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                      ),
                      Text(
                        user?.name ?? '',
                        style: AppTextStyles.titleLarge.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontWeight: FontWeight.bold,
                        ),
                      ),


                    ],
                  ),
                ),
                BlocBuilder<NotificationsCubit, NotificationsState>(
                  builder: (context, state) {
                    final unreadCount = state.notifications.where((n) => !n.isRead).length;
                    return Stack(
                      children: [
                        IconButton(
                          icon: Icon(Icons.notifications_outlined, color: Theme.of(context).colorScheme.onSurface),
                          onPressed: () {
                            context.push('/notifications');
                          },
                        ),
                        if (unreadCount > 0)
                          Positioned(
                            right: 12,
                            top: 12,
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              constraints: const BoxConstraints(
                                minWidth: 12,
                                minHeight: 12,
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                ),
                IconButton(
                  icon: Icon(
                    Theme.of(context).brightness == Brightness.dark 
                        ? Icons.wb_sunny 
                        : Icons.nightlight_round,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  onPressed: () {
                    context.read<AppCubit>().toggleTheme();
                  },
                ),
                GestureDetector(
                  onTap: () {
                    context.read<AppCubit>().toggleLanguage();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      Localizations.localeOf(context).languageCode == 'en' ? 'AR' : 'EN',
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
          

          
          // Recommended Campaigns Section
          BlocBuilder<RecommendationsCubit, List<Campaign>>(
            builder: (context, recommendedCampaigns) {
              if (recommendedCampaigns.isEmpty) return const SizedBox.shrink();
              
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: OutlinedButton.icon(
                      onPressed: () => context.push('/organizations'),
                      icon: Icon(Icons.corporate_fare, size: 20, color: Theme.of(context).colorScheme.primary),
                      label: Text(
                        l10n.organizations,
                        style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Theme.of(context).colorScheme.primary, width: 1.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 200,
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      scrollDirection: Axis.horizontal,
                      itemCount: recommendedCampaigns.length,
                      separatorBuilder: (context, index) => const SizedBox(width: 16),
                      itemBuilder: (context, index) {
                        final campaign = recommendedCampaigns[index];
                        return SizedBox(
                          width: 280,
                          child: CampaignCard(
                            campaign: campaign,
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              );
            },
          ),
          
          // Category Chips
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final isSelected = _selectedCategoryIndex == index;
                final category = categories[index];
                
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ChoiceChip(
                    label: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          category['icon'] as IconData,
                          size: 18,
                          color: isSelected ? Colors.white : Theme.of(context).colorScheme.onSurface,
                        ),
                        const SizedBox(width: 8),
                        Text(category['label'] as String),
                      ],
                    ),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        _selectedCategoryIndex = index;
                      });
                    },
                    selectedColor: Theme.of(context).colorScheme.primary,
                    backgroundColor: Theme.of(context).cardColor,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Theme.of(context).colorScheme.onSurface,
                      fontWeight: FontWeight.w600,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                        color: isSelected ? Colors.transparent : Theme.of(context).dividerColor,
                      ),
                    ),
                    elevation: 0,
                  ),
                );
              },
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Campaigns List
          BlocBuilder<CampaignsCubit, CampaignsState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const Padding(
                  padding: EdgeInsets.all(48.0),
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              if (state.error != null) {
                return Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Center(
                    child: Text('Error: ${state.error}',
                        style: const TextStyle(color: Colors.red)),
                  ),
                );
              }
              final filteredCampaigns = _selectedCategoryIndex == 0
                  ? state.campaigns
                  : state.campaigns
                      .where((c) => c.categoryIndex == _selectedCategoryIndex)
                      .toList();

              if (filteredCampaigns.isEmpty) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Text(
                      'No campaigns found in this category',
                      style: TextStyle(color: Colors.grey.shade500),
                    ),
                  ),
                );
              }

              return ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                itemCount: filteredCampaigns.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  final campaign = filteredCampaigns[index];
                  return CampaignCard(campaign: campaign);
                },
              );
            },
          ),
          const SizedBox(height: 24),
        ],
      ),
      ),
    );
  }
}
