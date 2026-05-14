import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../dashboard/screens/main_scaffold.dart';
import '../bloc/favorites_cubit.dart';
import '../models/favorite_item.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return SafeArea(
      child: BlocBuilder<FavoritesCubit, List<FavoriteItem>>(
        builder: (context, favorites) {
          if (favorites.isEmpty) {
            return _buildEmptyState(context, l10n);
          }
          return _buildFilledState(context, favorites, l10n);
        },
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.favorite_border_rounded,
            size: 120,
            color: AppColors.primary,
          ),
          const SizedBox(height: 32),
          Text(
            l10n.emptyFavoriteText,
            textAlign: TextAlign.center,
            style: AppTextStyles.titleLarge.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // Navigate back to Home Tab
                context.findAncestorStateOfType<MainScaffoldState>()?.switchTab(0);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: Text(
                l10n.browseCharities,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilledState(BuildContext context, List<FavoriteItem> items, AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: Text(
            l10n.tabFavorite,
            style: AppTextStyles.headlineMedium.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            itemCount: items.length,
            separatorBuilder: (_, _) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final item = items[index];
              return Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).shadowColor.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ListTile(
                  onTap: () {
                    context.push('/payment', extra: {
                      'name': item.title,
                      'icon': Icons.favorite,
                      'color': item.imageColor,
                      'imagePath': _getImagePathByTitle(item.title),
                    });
                  },
                  contentPadding: const EdgeInsets.all(12),
                  leading: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: _getImagePathByTitle(item.title) != null ? Colors.white : item.imageColor,
                      borderRadius: BorderRadius.circular(8),
                      border: _getImagePathByTitle(item.title) != null ? Border.all(color: Colors.grey.shade200) : null,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: _getImagePathByTitle(item.title) != null
                          ? Image.asset(_getImagePathByTitle(item.title)!, fit: BoxFit.contain)
                          : Icon(Icons.volunteer_activism, color: AppColors.primary.withValues(alpha: 0.3)),
                    ),
                  ),
                  title: Text(
                    item.title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(item.date),
                  trailing: IconButton(
                    icon: const Icon(Icons.favorite, color: AppColors.primary),
                    onPressed: () {
                      final favCubit = context.read<FavoritesCubit>();
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.question,
                        animType: AnimType.scale,
                        title: 'Remove Favorite',
                        desc: 'Remove "${item.title}" from your favorites?',
                        btnCancelText: 'Keep',
                        btnOkText: 'Remove',
                        btnOkColor: AppColors.primary,
                        btnCancelOnPress: () {},
                        btnOkOnPress: () {
                          favCubit.removeItem(item);
                        },
                      ).show();
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

String? _getImagePathByTitle(String title) {
  final Map<String, String> imageMap = {
    // Organizations
    'Misr El Kheir': 'assets/images/Misr El Kheir.png',
    'Bayt Al Zakat and Al Sadaqat': 'assets/images/bait_al_zakat.png',
    'Resala Charity Organization': 'assets/images/resala.png',
    'Al Orman Association': 'assets/images/orman.png',
    // Campaigns
    'Medical Camp in Aswan': 'assets/images/aswan_medical_camp.png',
    'School Supplies for Orphans': 'assets/images/orphan_school_bag.png',
    'Emergency Flood Relief': 'assets/images/flood_relief.png',
    'Clean Water for Rural Villages': 'assets/images/egypt_water_well.png',
    'Ramadan Food Baskets': 'assets/images/ramadan_food_box.png',
    'Sponsor an Orphan': 'assets/images/sponsor_orphan.png',
    'Winter Clothes for the Poor': 'assets/images/winter_clothes.png',
    'Care for People with Disabilities': 'assets/images/disabled_care.png',
    'Support for the Elderly': 'assets/images/elderly_support.png',
  };
  return imageMap[title];
}
