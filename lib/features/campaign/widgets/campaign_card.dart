import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/l10n/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import '../../cart/bloc/cart_cubit.dart';
import '../../cart/models/cart_item.dart';
import '../../favorites/bloc/favorites_cubit.dart';
import '../../favorites/models/favorite_item.dart';
import '../models/campaign.dart';

class CampaignCard extends StatelessWidget {
  final Campaign campaign;

  const CampaignCard({super.key, required this.campaign});

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
            'isOrganization': false,
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
                  child: Container(
                    decoration: BoxDecoration(color: campaign.imageColor),
                    child: Center(
                      child: Icon(
                        Icons.volunteer_activism,
                        size: 64,
                        color: AppColors.primary.withValues(alpha: 0.3),
                      ),
                    ),
                  ),
                ),
              ),

              if (campaign.date.isNotEmpty)
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
                      BlocBuilder<FavoritesCubit, List<FavoriteItem>>(
                        builder: (context, favorites) {
                          final isFavorite = favorites.any(
                            (f) => f.title == campaign.title && f.date == campaign.date,
                          );
                          return IconButton(
                            icon: Icon(
                              isFavorite ? Icons.favorite : Icons.favorite_border,
                              color: AppColors.primary,
                            ),
                            onPressed: () {
                              context.read<FavoritesCubit>().toggleFavorite(
                                FavoriteItem(
                                  title: campaign.title,
                                  date: campaign.date,
                                  imageColor: campaign.imageColor,
                                ),
                              );
                            },
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.add_shopping_cart, color: AppColors.primary),
                        onPressed: () {
                          final item = CartItem(
                            title: campaign.title,
                            imageColor: campaign.imageColor,
                          );
                          context.read<CartCubit>().addItem(item);

                          final l10n = AppLocalizations.of(context);
                          if (l10n != null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(l10n.addedToCartMsg)),
                            );
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
}
