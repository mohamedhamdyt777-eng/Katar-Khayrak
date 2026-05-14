import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/custom_primary_button.dart';
import '../../../core/utils/app_snackbars.dart';
import '../bloc/campaigns_cubit.dart';

class AddCampaignBottomSheet extends StatefulWidget {
  const AddCampaignBottomSheet({super.key});

  @override
  State<AddCampaignBottomSheet> createState() => _AddCampaignBottomSheetState();
}

class _AddCampaignBottomSheetState extends State<AddCampaignBottomSheet> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            l10n.addCampaign,
            style: AppTextStyles.headlineMedium.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),

          TextField(
            controller: _titleController,
            decoration: InputDecoration(
              hintText: l10n.enterCampaignTitle,
              labelText: l10n.campaignTitle,
              filled: true,
              fillColor: Theme.of(context).cardColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: Colors.grey.shade200),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: Colors.grey.shade200),
              ),
            ),
          ),
          const SizedBox(height: 16),

          TextField(
            controller: _dateController,
            decoration: InputDecoration(
              hintText: 'e.g. 24 Jan',
              labelText: l10n.campaignDate,
              filled: true,
              fillColor: Theme.of(context).cardColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: Colors.grey.shade200),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: Colors.grey.shade200),
              ),
            ),
          ),
          const SizedBox(height: 32),

          CustomPrimaryButton(
            text: l10n.createCampaignBtn,
            onPressed: () {
              if (_titleController.text.isNotEmpty && _dateController.text.isNotEmpty) {
                context.read<CampaignsCubit>().addCampaign(
                  _titleController.text,
                  _dateController.text,
                  AppColors.primary.withValues(alpha: 0.2),
                );
                AppSnackBars.showSuccess(context, 'Campaign added successfully!');
                context.pop();
              }
            },
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
