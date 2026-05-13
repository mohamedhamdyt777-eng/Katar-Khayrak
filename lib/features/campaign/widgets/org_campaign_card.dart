import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/l10n/app_localizations.dart';
import '../models/campaign.dart';
import '../bloc/campaigns_cubit.dart';

class OrgCampaignCard extends StatelessWidget {
  final Campaign campaign;

  const OrgCampaignCard({super.key, required this.campaign});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shadowColor: Theme.of(context).shadowColor.withValues(alpha: 0.05),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          context.push('/campaign-details', extra: {
            'campaign': campaign,
            'isOrganization': true,
          });
        },
        child: SizedBox(
          height: 200,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: 140,
                child: Hero(
                  tag: 'campaign_image_${campaign.id}',
                  child: _buildCoverImage(campaign),
                ),
              ),

              Positioned(
                top: 16,
                left: 16,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    campaign.date,
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),

              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                height: 60,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          campaign.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.edit_outlined, color: AppColors.primary),
                        onPressed: () {
                          context.push('/edit-campaign', extra: campaign);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete_outline, color: Colors.red),
                        onPressed: () async {
                          final l10n = AppLocalizations.of(context)!;
                          final confirm = await showDialog<bool>(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text(l10n.deleteCampaign),
                              content: Text(l10n.confirmDelete),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context, false),
                                  child: Text(l10n.cancel),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.pop(context, true),
                                  child: Text(
                                    l10n.delete,
                                    style: const TextStyle(color: Colors.red),
                                  ),
                                ),
                              ],
                            ),
                          );

                          if (confirm == true && context.mounted) {
                            try {
                              await context
                                  .read<CampaignsCubit>()
                                  .removeCampaign(campaign.id);
                            } catch (e) {
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text('Error: ${e.toString()}')),
                                );
                              }
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _buildCoverImage(Campaign campaign) {
    final url = campaign.coverImagePath;
    if (url != null && url.startsWith('http')) {
      return Image.network(
        url,
        fit: BoxFit.cover,
        width: double.infinity,
        errorBuilder: (ctx, err, stack) => _placeholder(campaign),
        loadingBuilder: (ctx, child, progress) =>
            progress == null ? child : _placeholder(campaign),
      );
    }
    return _placeholder(campaign);
  }

  static Widget _placeholder(Campaign campaign) {
    return Container(
      color: campaign.imageColor,
      child: Center(
        child: Icon(
          Icons.volunteer_activism,
          size: 64,
          color: campaign.imageColor.computeLuminance() > 0.5
              ? Colors.black26
              : Colors.white30,
        ),
      ),
    );
  }
}
