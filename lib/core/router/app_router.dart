import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:katar_khayrak/features/charity/screens/organizations_screen.dart';
import 'package:katar_khayrak/features/charity/screens/payment_screen.dart';

import '../../features/auth/screens/login_screen.dart';
import '../../features/auth/screens/register_screen.dart';
import '../../features/auth/screens/forget_password_screen.dart';
import '../../features/auth/screens/otp_screen.dart';
import '../../features/auth/screens/org_login_screen.dart';
import '../../features/auth/bloc/auth_cubit.dart';
import '../../features/cart/bloc/cart_cubit.dart';
import '../../features/favorites/bloc/favorites_cubit.dart';
import '../../features/dashboard/bloc/campaigns_cubit.dart';
import '../../features/dashboard/bloc/recommendations_cubit.dart';
import '../../features/dashboard/screens/main_scaffold.dart';
import '../../features/dashboard/screens/org_main_scaffold.dart';
import '../../features/dashboard/screens/add_campaign_screen.dart';
import '../../features/dashboard/screens/edit_campaign_screen.dart';
import '../../features/donation/screens/payment_details_screen.dart';
import '../../features/dashboard/screens/campaign_details_screen.dart';
import '../../features/dashboard/models/campaign.dart';
import '../../features/notifications/screens/notifications_screen.dart';
import '../../features/notifications/bloc/notifications_cubit.dart';
import '../di/injection.dart';

import '../../features/onboarding/screens/splash_screen.dart';
import '../../features/onboarding/screens/onboarding_screen.dart';
import '../../features/onboarding/screens/user_type_screen.dart';
import '../../features/onboarding/screens/intro_screen.dart';

// Global navigator key
final rootNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter appRouter = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: '/splash',
  // Provide the AuthCubit globally via a shell router or inject directly in main
  routes: [
    GoRoute(
      path: '/splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: '/user-type',
      builder: (context, state) => const UserTypeScreen(),
    ),
    GoRoute(
      path: '/intro',
      builder: (context, state) => const IntroScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => BlocProvider.value(
        value: getIt<AuthCubit>(),
        child: const LoginScreen(),
      ),
    ),
    GoRoute(
      path: '/org-login',
      builder: (context, state) => BlocProvider.value(
        value: getIt<AuthCubit>(),
        child: const OrgLoginScreen(),
      ),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) {
        final isOrg = state.uri.queryParameters['isOrg'] == 'true';
        return BlocProvider.value(
          value: getIt<AuthCubit>(),
          child: RegisterScreen(isOrg: isOrg),
        );
      },
    ),
    GoRoute(
      path: '/forget-password',
      builder: (context, state) => const ForgetPasswordScreen(),
    ),
    GoRoute(
      path: '/organizations',
      builder: (context, state) => const OrganizationsScreen(),
    ),
    GoRoute(
      path: '/payment',
      builder: (context, state) {
        final org = state.extra as Map<String, dynamic>;
        return PaymentScreen(organization: org);
      },
    ),
    GoRoute(
      path: '/otp',
      builder: (context, state) {
        final phone = state.extra as String? ?? '';
        return OtpScreen(phone: phone);
      },
    ),
    GoRoute(
      path: '/dashboard',
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider.value(value: getIt<AuthCubit>()),
          BlocProvider.value(value: getIt<CartCubit>()),
          BlocProvider.value(value: getIt<FavoritesCubit>()),
          BlocProvider.value(value: getIt<CampaignsCubit>()),
          BlocProvider.value(value: getIt<RecommendationsCubit>()),
          BlocProvider.value(value: getIt<NotificationsCubit>()),
        ],
        child: const MainScaffold(),
      ),
    ),
    GoRoute(
      path: '/org-dashboard',
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider.value(value: getIt<AuthCubit>()),
          BlocProvider.value(value: getIt<CampaignsCubit>()),
        ],
        child: const OrgMainScaffold(),
      ),
    ),
    GoRoute(
      path: '/add-campaign',
      builder: (context, state) => BlocProvider.value(
        value: getIt<CampaignsCubit>(),
        child: const AddCampaignScreen(),
      ),
    ),
    GoRoute(
      path: '/edit-campaign',
      builder: (context, state) {
        final campaign = state.extra as Campaign;
        return BlocProvider.value(
          value: getIt<CampaignsCubit>(),
          child: EditCampaignScreen(campaign: campaign),
        );
      },
    ),
    GoRoute(
      path: '/notifications',
      builder: (context, state) => BlocProvider.value(
        value: getIt<NotificationsCubit>(),
        child: const NotificationsScreen(),
      ),
    ),
    GoRoute(
      path: '/campaign-details',
      builder: (context, state) {
        final extra = state.extra;
        Campaign campaign;
        bool isOrganization = false;
        
        if (extra is Map<String, dynamic>) {
          campaign = extra['campaign'] as Campaign;
          isOrganization = extra['isOrganization'] as bool? ?? false;
        } else {
          campaign = extra as Campaign;
        }

        return MultiBlocProvider(
          providers: [
            BlocProvider.value(value: getIt<CartCubit>()),
            BlocProvider.value(value: getIt<FavoritesCubit>()),
          ],
          child: CampaignDetailsScreen(
            campaign: campaign,
            isOrganization: isOrganization,
          ),
        );
      },
    ),
    GoRoute(
      path: '/payment-details',
      builder: (context, state) {
        final campaign = state.extra as Campaign;
        return PaymentDetailsScreen(campaign: campaign);
      },
    ),
  ],
  redirect: (context, state) {
    // Basic redirect logic (for future expansion using AuthState stream)
    return null;
  },
);
