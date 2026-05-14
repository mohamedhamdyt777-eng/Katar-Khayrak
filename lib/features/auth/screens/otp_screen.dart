import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/widgets/custom_primary_button.dart';

class OtpScreen extends StatelessWidget {
  final String phone;

  const OtpScreen({super.key, required this.phone});

  FormGroup buildForm() => fb.group({
        'otp': FormControl<String>(value: '1234', validators: [Validators.required, Validators.minLength(4)]),
      });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: const Text('Verify OTP')),
      body: ReactiveFormBuilder(
        form: buildForm,
        builder: (context, form, child) {
          return Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(l10n.otpSent(phone), textAlign: TextAlign.center),
                const SizedBox(height: 32),
                ReactiveTextField(
                  formControlName: 'otp',
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(labelText: 'Enter OTP'),
                ),
                const SizedBox(height: 32),
                CustomPrimaryButton(
                  text: 'Verify & Continue',
                  onPressed: form.valid
                      ? () {
                          // Mock successful OTP & bypass to dashboard
                          context.go('/dashboard');
                        }
                      : null,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
