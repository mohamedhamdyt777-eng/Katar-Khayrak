import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/custom_primary_button.dart';
import '../../../core/utils/app_assets.dart';
import '../../dashboard/screens/main_scaffold.dart';
import '../bloc/cart_cubit.dart';
import '../models/cart_item.dart';

class CartTab extends StatelessWidget {
  const CartTab({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return SafeArea(
      child: BlocBuilder<CartCubit, List<CartItem>>(
        builder: (context, cartItems) {
          if (cartItems.isEmpty) {
            return _buildEmptyState(context, l10n);
          }
          return _buildFilledState(context, cartItems, l10n);
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
          Image.asset(
            'assets/images/empty_cart.png',
            height: 250,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 32),
          Text(
            l10n.emptyCartText,
            textAlign: TextAlign.center,
            style: AppTextStyles.titleLarge.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 32),
          CustomPrimaryButton(
            text: l10n.browseProductsBtn,
            onPressed: () {
              // Navigate back to Home Tab
              context.findAncestorStateOfType<MainScaffoldState>()?.switchTab(0);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFilledState(BuildContext context, List<CartItem> items, AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: Text(
            l10n.tabCart,
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
            separatorBuilder: (context, index) => const SizedBox(height: 16),
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
                      'icon': Icons.volunteer_activism,
                      'color': item.imageColor,
                      'imagePath': AppAssets.getCampaignImage(item.title),
                    });
                  },
                  contentPadding: const EdgeInsets.all(12),
                  leading: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: AppAssets.getCampaignImage(item.title) != null ? Colors.white : item.imageColor,
                      borderRadius: BorderRadius.circular(8),
                      border: AppAssets.getCampaignImage(item.title) != null ? Border.all(color: Colors.grey.shade200) : null,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: AppAssets.getCampaignImage(item.title) != null
                          ? Image.asset(AppAssets.getCampaignImage(item.title)!, fit: BoxFit.contain)
                          : Icon(Icons.volunteer_activism, color: AppColors.primary.withValues(alpha: 0.3)),
                    ),
                  ),
                  title: Text(
                    item.title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                    onPressed: () {
                      final cartCubit = context.read<CartCubit>();
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.warning,
                        animType: AnimType.scale,
                        title: 'Remove Item',
                        desc: 'Are you sure you want to remove "${item.title}" from your cart?',
                        btnCancelText: 'Cancel',
                        btnOkText: 'Remove',
                        btnOkColor: Colors.redAccent,
                        btnCancelOnPress: () {},
                        btnOkOnPress: () {
                          cartCubit.removeItem(item);
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
