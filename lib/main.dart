import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/l10n/app_localizations.dart';
import 'core/theme/app_theme.dart';
import 'core/router/app_router.dart';

import 'core/di/injection.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/bloc/app_cubit.dart';
import 'core/bloc/app_state.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'core/services/firestore_seeder.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirestoreSeeder.seedCampaignsIfEmpty();
  configureDependencies();
  runApp(
    BlocProvider(
      create: (_) => getIt<AppCubit>(),
      child: const KatarKhayrakApp(),
    ),
  );
}

class KatarKhayrakApp extends StatelessWidget {
  const KatarKhayrakApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Katar Khayrak',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: state.themeMode,
          locale: state.locale,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en'),
            Locale('ar'),
          ],
          routerConfig: appRouter,
        );
      },
    );
  }
}
