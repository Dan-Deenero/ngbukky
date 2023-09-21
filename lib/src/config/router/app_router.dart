import 'package:go_router/go_router.dart';
import 'package:ngbuka/src/config/keys/app_routes.dart';
import 'package:ngbuka/src/domain/data/inspection_booking_model.dart';
import 'package:ngbuka/src/domain/data/otp_model.dart';
import 'package:ngbuka/src/features/presentation/views/business_info/business_info.dart';
import 'package:ngbuka/src/features/presentation/views/business_info/business_info_settings.dart';
import 'package:ngbuka/src/features/presentation/views/business_info/business_location.dart';
import 'package:ngbuka/src/features/presentation/views/main_auth/create_account.dart';
import 'package:ngbuka/src/features/presentation/views/main_auth/forgot_pass_phone.dart';
import 'package:ngbuka/src/features/presentation/views/main_auth/forgot_password.dart';
import 'package:ngbuka/src/features/presentation/views/main_auth/login.dart';
import 'package:ngbuka/src/features/presentation/views/main_auth/new_password.dart';
import 'package:ngbuka/src/features/presentation/views/main_auth/select_account_type.dart';
import 'package:ngbuka/src/features/presentation/views/main_auth/verify_account.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/accepted-bookings/accepted_booking.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/accepted-bookings/view_accepted_booking.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/booking-rejected/booking_rejected.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/booking-rejected/inspection_details_br.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/booking.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/bottom_nav.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/completed_booking/completed_booking.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/completed_booking/inspection_details.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/new-booking-alert/inspection_booking.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/new-booking-alert/new_booking_alerts.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/payment_declined/inspection_details_pd.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/payment_declined/payment_declined.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/payment_request/inspection_details_pr.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/payment_request/payment_request.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/pending_quote_approval/Inspection_details_pqa.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/pending_quote_approval/pending_quote_aproval.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/quote_request.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/quote_send.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/rejected-bookings/rejected_booking.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/rejected-bookings/view_rejected_booking.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/send-quotes/send_quote.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/wallet/history_detail.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/wallet/wallet_history.dart';
import 'package:ngbuka/src/features/presentation/views/notifications/notification.dart';
import 'package:ngbuka/src/features/presentation/views/onboarding/account_selection.dart';
import 'package:ngbuka/src/features/presentation/views/onboarding/onboarding.dart';
import 'package:ngbuka/src/features/presentation/views/onboarding/onboarding2.dart';
import 'package:ngbuka/src/features/presentation/views/onboarding/splashscreen.dart';
import 'package:ngbuka/src/features/presentation/views/personal_info/enterprise.dart';
import 'package:ngbuka/src/features/presentation/views/personal_info/personal_info.dart';
import 'package:ngbuka/src/features/presentation/views/personal_info/setup.dart';
import 'package:ngbuka/src/features/presentation/views/profile_settings/add_wallet_page.dart';
import 'package:ngbuka/src/features/presentation/views/profile_settings/contact_page.dart';
import 'package:ngbuka/src/features/presentation/views/profile_settings/profile_page.dart';
import 'package:ngbuka/src/features/presentation/views/spare_part/auth/spare_login.dart';
import 'package:ngbuka/src/features/presentation/views/spare_part/dealer_info/part_business_info.dart';
import 'package:ngbuka/src/features/presentation/views/spare_part/dealer_info/spare_personal_info.dart';
import 'package:ngbuka/src/features/presentation/views/spare_part/dealer_info/spear_part_setup.dart';
import 'package:ngbuka/src/features/presentation/views/spare_part/dealer_info/store_info.dart';
import 'package:ngbuka/src/features/presentation/views/spare_part/spare_bottom_nav.dart';

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
          builder: (_, state) =>
              VerifyAccount(otpModel: state.extra as OTPModel)),
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
          path: AppRoutes.profileSettings,
          name: AppRoutes.profileSettings,
          builder: (_, state) => const ProfileSettings()),
      GoRoute(
          path: AppRoutes.personalInfoSettings,
          name: AppRoutes.personalInfoSettings,
          builder: (_, state) => const PersonalInfoSettings()),
      GoRoute(
          path: AppRoutes.businessInfo,
          name: AppRoutes.businessInfo,
          builder: (_, state) => const BusinessInfoPage()),
      GoRoute(
          path: AppRoutes.businessInfoSettings,
          name: AppRoutes.businessInfoSettings,
          builder: (_, state) => const BusinessInfoSettings()),
      GoRoute(
          path: AppRoutes.contactPage,
          name: AppRoutes.contactPage,
          builder: (_, state) => const ContactPage()),
      GoRoute(
          path: AppRoutes.bottomNav,
          name: AppRoutes.bottomNav,
          builder: (_, state) => const BottomNavigationBarView()),
      GoRoute(
          path: AppRoutes.bookings,
          name: AppRoutes.bookings,
          builder: (_, state) => Bookings()),
      GoRoute(
          path: AppRoutes.businessLocation,
          name: AppRoutes.businessLocation,
          builder: (_, state) => const BusinessLocation()),
      GoRoute(
          path: AppRoutes.inspectionBooking,
          name: AppRoutes.inspectionBooking,
          builder: (_, state) => InspectionBooking(id: state.extra as String,)),
      GoRoute(
          path: AppRoutes.viewAcceptedBooking,
          name: AppRoutes.viewAcceptedBooking,
          builder: (_, state) => ViewAcceptedBooking(id: state.extra as String,)),
      GoRoute(
          path: AppRoutes.viewRejectedBooking,
          name: AppRoutes.viewRejectedBooking,
          builder: (_, state) => ViewRejectedBooking(id: state.extra as String,)),
      GoRoute(
          path: AppRoutes.bookingRejectedDetails,
          name: AppRoutes.bookingRejectedDetails,
          builder: (_, state) => BRInspectionDetails(id: state.extra as String,)),
      GoRoute(
          path: AppRoutes.paymentRequestDetails,
          name: AppRoutes.paymentRequestDetails,
          builder: (_, state) => PRInspectionDetails(id: state.extra as String,)),
      GoRoute(
          path: AppRoutes.paymentDeclinedDetails,
          name: AppRoutes.paymentDeclinedDetails,
          builder: (_, state) => PDInspectionDetails(id: state.extra as String,)),
      GoRoute(
          path: AppRoutes.completedBookingDetails,
          name: AppRoutes.completedBookingDetails,
          builder: (_, state) => CompletedInspectionDetails(id: state.extra as String,)),
      GoRoute(
          path: AppRoutes.pendingQuoteApprovalDetails,
          name: AppRoutes.pendingQuoteApprovalDetails,
          builder: (_, state) => PQAInspectionDetails(id: state.extra as String,)),
      GoRoute(
          path: AppRoutes.sendQuotes,
          name: AppRoutes.sendQuotes,
          builder: (_, state) =>  SendQuote(id: state.extra as String,)),
      GoRoute(
          path: AppRoutes.quotesSend,
          name: AppRoutes.quotesSend,
          builder: (_, state) =>  QuoteSend(id: state.extra as String,)),
      GoRoute(
          path: AppRoutes.quotesRequest,
          name: AppRoutes.quotesRequest,
          builder: (_, state) => const QuoteRequest()),
      GoRoute(
          path: AppRoutes.bookingAlert,
          name: AppRoutes.bookingAlert,
          builder: (_, state) => const BookingAlert()),
      GoRoute(
          path: AppRoutes.paymentRequest,
          name: AppRoutes.paymentRequest,
          builder: (_, state) => const PaymentRequest()),
      GoRoute(
          path: AppRoutes.completedBooking,
          name: AppRoutes.completedBooking,
          builder: (_, state) => const CompletedBooking()),
      GoRoute(
          path: AppRoutes.acceptedBooking,
          name: AppRoutes.acceptedBooking,
          builder: (_, state) => const AcceptedBooking()),
      GoRoute(
          path: AppRoutes.rejectedBooking,
          name: AppRoutes.rejectedBooking,
          builder: (_, state) => const RejectedBooking()),
      GoRoute(
          path: AppRoutes.bookingRejected,
          name: AppRoutes.bookingRejected,
          builder: (_, state) => const BookingRejected()),
      GoRoute(
          path: AppRoutes.paymentDeclined,
          name: AppRoutes.paymentDeclined,
          builder: (_, state) => const PaymentDeclined()),
      GoRoute(
          path: AppRoutes.pendingQuoteApproval,
          name: AppRoutes.pendingQuoteApproval,
          builder: (_, state) => const PendingQuoteApproval()),
      GoRoute(
          path: AppRoutes.notification,
          name: AppRoutes.notification,
          builder: (_, state) => const Notification()),
      GoRoute(
          path: AppRoutes.walletHistory,
          name: AppRoutes.walletHistory,
          builder: (_, state) => const WalletHistory()),
      GoRoute(
          path: AppRoutes.historyDetail,
          name: AppRoutes.historyDetail,
          builder: (_, state) => const HistoryDetail()),
      GoRoute(
          path: AppRoutes.selectAccount,
          name: AppRoutes.selectAccount,
          builder: (_, state) => const SelectAccount()),
      GoRoute(
          path: AppRoutes.boarding1,
          name: AppRoutes.boarding1,
          builder: (_, state) => const Boarding1()),
      GoRoute(
          path: AppRoutes.boarding2,
          name: AppRoutes.boarding2,
          builder: (_, state) => const Boarding2()),
      GoRoute(
          path: AppRoutes.spareLogin,
          name: AppRoutes.spareLogin,
          builder: (_, state) => const SpareLoginView()),
      GoRoute(
          path: AppRoutes.spareBottomNav,
          name: AppRoutes.spareBottomNav,
          builder: (_, state) => const BottomNavBarView()),
      GoRoute(
          path: AppRoutes.spareSetup,
          name: AppRoutes.spareSetup,
          builder: (_, state) => const SpearSetupPage()),
      GoRoute(
          path: AppRoutes.spareStoreInfo,
          name: AppRoutes.spareStoreInfo,
          builder: (_, state) => const SpareStoreInfo()),
      GoRoute(
          path: AppRoutes.sparePersonalInfo,
          name: AppRoutes.sparePersonalInfo,
          builder: (_, state) => const SparePersonalInfo()),
      GoRoute(
          path: AppRoutes.spareBusinessInfo,
          name: AppRoutes.spareBusinessInfo,
          builder: (_, state) => const SpareBusinessInfo()),
      GoRoute(
          path: AppRoutes.addWallet,
          name: AppRoutes.addWallet,
          builder: (_, state) =>  AddWalletPage()),
    ]);