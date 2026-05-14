import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/bloc/app_cubit.dart';
import '../../../core/bloc/app_state.dart';
import '../../../core/l10n/app_localizations.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/custom_primary_button.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Top Logo
              Center(
                child: Text(
                  l10n.appName.toUpperCase(),
                  style: AppTextStyles.headlineMedium.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
              
              const Spacer(flex: 1),
              
              // Center Graphic
              Center(
                child: Image.asset(
                  'assets/images/donation_illustration.png',
                  height: 250,
                  fit: BoxFit.contain,
                ),
              ),
              
              const Spacer(flex: 2),
              
              // Title & Subtitle
              Text(
                l10n.onboardingTitle,
                style: AppTextStyles.headlineMedium.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                l10n.onboardingSubtitle,
                style: AppTextStyles.bodyLarge.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  height: 1.5,
                ),
              ),
              
              const SizedBox(height: 32),
              
              // Toggles using BlocBuilder
              BlocBuilder<AppCubit, AppState>(
                builder: (context, state) {
                  final isEn = state.locale.languageCode == 'en';
                  final isDark = state.themeMode == ThemeMode.dark;
                  
                  return Column(
                    children: [
                      // Language Toggle
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            l10n.language,
                            style: AppTextStyles.titleLarge.copyWith(
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                          Row(
                            children: [
                              _buildSegmentButton(
                                context: context,
                                text: l10n.english,
                                isSelected: isEn,
                                onTap: () {
                                  if (!isEn) context.read<AppCubit>().toggleLanguage();
                                },
                              ),
                              const SizedBox(width: 8),
                              _buildSegmentButton(
                                context: context,
                                text: l10n.arabic,
                                isSelected: !isEn,
                                onTap: () {
                                  if (isEn) context.read<AppCubit>().toggleLanguage();
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // Theme Toggle
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            l10n.theme,
                            style: AppTextStyles.titleLarge.copyWith(
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                          Row(
                            children: [
                              _buildSegmentButton(
                                context: context,
                                icon: Icons.wb_sunny_outlined,
                                isSelected: !isDark,
                                onTap: () {
                                  if (isDark) context.read<AppCubit>().toggleTheme();
                                },
                              ),
                              const SizedBox(width: 8),
                              _buildSegmentButton(
                                context: context,
                                icon: Icons.nightlight_round,
                                isSelected: isDark,
                                onTap: () {
                                  if (!isDark) context.read<AppCubit>().toggleTheme();
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
              
              const SizedBox(height: 40),
              
              // Let's Start Button
              CustomPrimaryButton(
                text: l10n.letsStart,
                onPressed: () async {
                  if (context.mounted) {
                    context.push('/intro');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSegmentButton({
    String? text,
    IconData? icon,
    required bool isSelected,
    required VoidCallback onTap,
    required BuildContext context,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = Theme.of(context).colorScheme.primary;
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor : Colors.transparent,
          border: Border.all(
            color: isSelected ? primaryColor : (isDark ? Colors.white24 : Colors.grey.shade300),
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: text != null
            ? Text(
                text,
                style: TextStyle(
                  color: isSelected ? Colors.white : (isDark ? Colors.white70 : primaryColor),
                  fontWeight: FontWeight.bold,
                ),
              )
            : Icon(
                icon,
                color: isSelected ? Colors.white : (isDark ? Colors.white70 : primaryColor),
                size: 20,
              ),
      ),
    );
  }
}
