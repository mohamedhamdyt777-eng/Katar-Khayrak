import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/custom_primary_button.dart';
import '../../../core/utils/app_snackbars.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: Theme.of(context).colorScheme.onSurface,
          onPressed: () => context.pop(),
        ),
        title: Text(
          l10n.resetPasswordTitle,
          style: AppTextStyles.titleLarge.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(flex: 1),
              
              // Illustration
              Center(
                child: Image.asset(
                  'assets/images/forget_password.png',
                  height: 300,
                  fit: BoxFit.contain,
                ),
              ),
              
              const Spacer(flex: 2),
              
              // Reset Button
              CustomPrimaryButton(
                text: l10n.resetPasswordBtn,
                onPressed: () {
                  AppSnackBars.show(context, 'Reset password clicked');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
