import 'package:go_router/go_router.dart';
import 'package:ngbuka/src/config/keys/app_routes.dart';
import 'package:ngbuka/src/presentation/views/onboarding/account_selection.dart';
import 'package:ngbuka/src/presentation/views/onboarding/onboarding.dart';
import 'package:ngbuka/src/presentation/views/onboarding/splashscreen.dart';

GoRouter router() => GoRouter(routes: <GoRoute>[
      GoRoute(
          path: AppRoutes.splashscreen,
          name: AppRoutes.splashscreen,
          builder: (_, state) => const Splashscreen()),
      GoRoute(
          path: AppRoutes.onboarding,
          name: AppRoutes.onboarding,
          builder: (_, state) => const OnboardingScreen()),
      GoRoute(
          path: AppRoutes.accountSelection,
          name: AppRoutes.accountSelection,
          builder: (_, state) => const AccountSelection())
    ]);
