import 'package:go_router/go_router.dart';
import 'package:ngbuka/src/config/keys/app_routes.dart';
import 'package:ngbuka/src/presentation/views/business_info/business_info.dart';
import 'package:ngbuka/src/presentation/views/main_auth/create_account.dart';
import 'package:ngbuka/src/presentation/views/main_auth/forgot_pass_phone.dart';
import 'package:ngbuka/src/presentation/views/main_auth/forgot_password.dart';
import 'package:ngbuka/src/presentation/views/main_auth/new_password.dart';
import 'package:ngbuka/src/presentation/views/main_auth/verify_account.dart';
import 'package:ngbuka/src/presentation/views/mechanic/bottom_nav.dart';
import 'package:ngbuka/src/presentation/views/onboarding/account_selection.dart';
import 'package:ngbuka/src/presentation/views/onboarding/onboarding.dart';
import 'package:ngbuka/src/presentation/views/onboarding/splashscreen.dart';
import 'package:ngbuka/src/presentation/views/personal_info/enterprise.dart';
import 'package:ngbuka/src/presentation/views/personal_info/setup.dart';

import '../../presentation/views/main_auth/login.dart';

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
          builder: (_, state) => const AccountSelection()),
      GoRoute(
          path: AppRoutes.createAccount,
          name: AppRoutes.createAccount,
          builder: (_, state) => const CreateAccount()),
      GoRoute(
          path: AppRoutes.verifyAccount,
          name: AppRoutes.verifyAccount,
          builder: (_, state) => const VerifyAccount()),
      GoRoute(
          path: AppRoutes.login,
          name: AppRoutes.login,
          builder: (_, state) => const LoginView()),
      GoRoute(
          path: AppRoutes.forgotPassword,
          name: AppRoutes.forgotPassword,
          builder: (_, state) => const ForgotPassword()),
      GoRoute(
          path: AppRoutes.forgotPasswordPhone,
          name: AppRoutes.forgotPasswordPhone,
          builder: (_, state) => const ForgotPasswordPhone()),
      GoRoute(
          path: AppRoutes.newPassword,
          name: AppRoutes.newPassword,
          builder: (_, state) => const NewPassword()),
      GoRoute(
          path: AppRoutes.setup,
          name: AppRoutes.setup,
          builder: (_, state) => const SetupPage()),
      GoRoute(
          path: AppRoutes.personalInfo,
          name: AppRoutes.personalInfo,
          builder: (_, state) => const PersonalInfoPage()),
      GoRoute(
          path: AppRoutes.businessInfo,
          name: AppRoutes.businessInfo,
          builder: (_, state) => const BusinessInfoPage()),
      GoRoute(
          path: AppRoutes.bottomNav,
          name: AppRoutes.bottomNav,
          builder: (_, state) => const BottomNavigationBarView()),
    ]);
