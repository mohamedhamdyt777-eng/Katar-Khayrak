import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/bloc/app_cubit.dart';
import '../../auth/bloc/auth_cubit.dart';
import '../../auth/bloc/auth_state.dart';
import '../../campaign/bloc/campaigns_cubit.dart';
import '../../campaign/bloc/campaigns_state.dart';
import '../../campaign/widgets/org_campaign_card.dart';

class OrgHomeTab extends StatefulWidget {
  const OrgHomeTab({super.key});

  @override
  State<OrgHomeTab> createState() => _OrgHomeTabState();
}

class _OrgHomeTabState extends State<OrgHomeTab> {

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final user = context.select((AuthCubit cubit) =>
      cubit.state.maybeWhen(
        authenticated: (user) => user,
        orElse: () => null,
      )
    );

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
                          user?.name ?? 'Organization',
                          style: AppTextStyles.titleLarge.copyWith(
                            color: Theme.of(context).colorScheme.onSurface,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Theme.of(context).brightness == Brightness.dark
                          ? Icons.wb_sunny
                          : Icons.nightlight_round,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    onPressed: () => context.read<AppCubit>().toggleTheme(),
                  ),
                  GestureDetector(
                    onTap: () => context.read<AppCubit>().toggleLanguage(),
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

            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                l10n.yourCampaigns,
                style: AppTextStyles.titleLarge.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Campaigns List
            BlocBuilder<CampaignsCubit, CampaignsState>(
              builder: (context, state) {
                if (state.campaigns.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Text(
                        'No campaigns yet',
                        style: TextStyle(color: Colors.grey.shade500),
                      ),
                    ),
                  );
                }

                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  itemCount: state.campaigns.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    final campaign = state.campaigns[index];
                    return OrgCampaignCard(campaign: campaign);
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
