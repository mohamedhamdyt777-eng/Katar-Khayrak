import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_input_styles.dart';
import '../../../core/widgets/custom_primary_button.dart';
import '../../../core/widgets/loading_overlay.dart';
import '../../../core/utils/app_snackbars.dart';
import '../bloc/auth_cubit.dart';
import '../bloc/auth_state.dart';

class OrgLoginScreen extends StatefulWidget {
  const OrgLoginScreen({super.key});

  @override
  State<OrgLoginScreen> createState() => _OrgLoginScreenState();
}

class _OrgLoginScreenState extends State<OrgLoginScreen> {
  bool _obscurePassword = true;

  FormGroup buildForm() => fb.group({
        'email': FormControl<String>(value: 'org@katarkhayrak.com', validators: [Validators.required, Validators.email]),
        'password': FormControl<String>(value: 'Password123', validators: [Validators.required]),
      });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Theme.of(context).colorScheme.onSurface, size: 20),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/user-type');
            }
          },
        ),
      ),
      body: SafeArea(
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            state.maybeWhen(
              authenticated: (_) => context.go('/org-dashboard'),
              error: (msg) => AppSnackBars.showError(context, msg),
              orElse: () {},
            );
          },
          builder: (context, state) {
            return LoadingOverlay(
              isLoading: state.maybeWhen(loading: () => true, orElse: () => false),
              message: 'Loading...',
              child: ReactiveFormBuilder(
                form: buildForm,
                builder: (context, form, child) {
                  return SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Logo / Illustration Placeholder
                        Center(
                          child: Icon(
                            Icons.business_center,
                            size: 80,
                            color: AppColors.primary.withValues(alpha: 0.8),
                          ),
                        ),
                        const SizedBox(height: 32),
                        // Heading
                        Text(
                          l10n.orgLoginTitle, // "Organization Login"
                          style: AppTextStyles.headlineMedium.copyWith(
                            color: AppColors.primaryDark,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 40),
                        
                        // Email Field
                        ReactiveTextField(
                          formControlName: 'email',
                          decoration: AppInputStyles.defaultDecoration(
                            context: context,
                            hint: l10n.orgEmailHint,
                            prefixIcon: Icons.business,
                          ),
                        ),
                        const SizedBox(height: 20),
                        
                        // Password Field
                        ReactiveTextField(
                          formControlName: 'password',
                          obscureText: _obscurePassword,
                          decoration: AppInputStyles.defaultDecoration(
                            context: context,
                            hint: l10n.enterYourPassword,
                            prefixIcon: Icons.lock_outline,
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                                color: Colors.grey.shade400,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            ),
                          ),
                        ),
                        
                        // Forget Password
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () => context.push('/forget-password'),
                            child: Text(
                              l10n.forgetPassword,
                              style: const TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        
                        // Login Button
                        CustomPrimaryButton(
                          text: l10n.loginTitle,
                          onPressed: form.valid
                              ? () {
                                  context.read<AuthCubit>().login(
                                    form.control('email').value,
                                    form.control('password').value,
                                  );
                                }
                              : null,
                          isLoading: state.maybeWhen(loading: () => true, orElse: () => false),
                        ),
                        const SizedBox(height: 24),
                        
                        // Signup Text
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              l10n.dontHaveAccount,
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                            GestureDetector(
                              onTap: () => context.push('/register?isOrg=true'),
                              child: Text(
                                l10n.signup,
                                style: const TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
