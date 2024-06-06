import 'package:go_router/go_router.dart';
import 'package:ngbuka/src/config/keys/app_routes.dart';
import 'package:ngbuka/src/domain/data/otp_model.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/Bookings/accepted-bookings/accepted_booking.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/Bookings/accepted-bookings/view_accepted_booking.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/Bookings/booking-rejected/booking_rejected.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/Bookings/booking-rejected/inspection_details_br.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/Bookings/completed_booking/completed_booking.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/Bookings/completed_booking/inspection_details.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/Bookings/new-booking-alert/inspection_booking.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/Bookings/new-booking-alert/new_booking_alerts.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/Bookings/payment_declined/inspection_details_pd.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/Bookings/payment_declined/payment_declined.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/Bookings/payment_request/inspection_details_ppr.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/Bookings/payment_request/inspection_details_pr.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/Bookings/payment_request/payment_request.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/Bookings/pending_quote_approval/Inspection_details_pqa.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/Bookings/pending_quote_approval/pending_quote_aproval.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/Bookings/rejected-bookings/rejected_booking.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/Bookings/rejected-bookings/view_rejected_booking.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/Bookings/send-quotes/quote_send.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/Quotes/send_quote.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/booking_things/booking_middleman.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/booking_things/notification_to_booking.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/booking_things/notification_to_quote.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/booking_things/quote_middleman.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/business_info/business_info.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/profile_settings/business_info_settings.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/business_info/business_location.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/main_auth/create_account.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/main_auth/forgot_pass_phone.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/main_auth/forgot_password.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/main_auth/login.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/main_auth/new_password.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/main_auth/select_account_type.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/main_auth/verify_account.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/Quotes/accepted_quote/accepted_quotes.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/Quotes/completed_quote/completed_quote_request.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/Quotes/completed_quote/inspection_details_cqr.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/Quotes/pending_client_approval/inspection_details_pca.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/Quotes/payment_declined/inspection_details_pdq.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/Quotes/payment_request/inspection_details_pprq.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/Quotes/payment_request/inspection_details_prq.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/Quotes/quote_rejected/inspection_details_qr.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/Quotes/rejected_quote/inspection_detalis_rq.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/Quotes/new_quote_request/new_quote_alert.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/Quotes/payment_declined/payment_declined_q.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/Quotes/payment_request/payment_request_q.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/Quotes/pending_client_approval/pending_client_approval.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/Quotes/quote_rejected/quote_rejected.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/Quotes/new_quote_request/quote_request.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/Quotes/rejected_quote/rejected_quote.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/Quotes/accepted_quote/view_accepted_quotes.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/booking_things/booking.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/bottom_nav.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/wallet/history_detail.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/wallet/local_account_setup.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/wallet/wallet_history.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/wallet/withdraw_funds.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/wallet/withdrawal_detail.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/notifications/booking_details_nt.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/notifications/notification.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/onboarding/account_selection.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/onboarding/onboarding.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/onboarding/onboarding2.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/onboarding/splashscreen.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/personal_info/enterprise.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/profile_settings/personal_info.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/personal_info/setup.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/profile_settings/add_wallet_page.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/profile_settings/contact_page.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/profile_settings/profile_page.dart';
import 'package:ngbuka/src/features/presentation/views/spare_part/auth/spare_create_account.dart';
import 'package:ngbuka/src/features/presentation/views/spare_part/auth/spare_forgot_pass_phone.dart';
import 'package:ngbuka/src/features/presentation/views/spare_part/auth/spare_forgot_password.dart';
import 'package:ngbuka/src/features/presentation/views/spare_part/auth/spare_login.dart';
import 'package:ngbuka/src/features/presentation/views/spare_part/auth/spare_new_password.dart';
import 'package:ngbuka/src/features/presentation/views/spare_part/auth/spare_verify_account.dart';
import 'package:ngbuka/src/features/presentation/views/spare_part/dealer_info/spare_business_info.dart';
import 'package:ngbuka/src/features/presentation/views/spare_part/inventory/add_inventory.dart';
import 'package:ngbuka/src/features/presentation/views/spare_part/inventory/edit_inventory.dart';
import 'package:ngbuka/src/features/presentation/views/spare_part/inventory/inventory.dart';
import 'package:ngbuka/src/features/presentation/views/spare_part/inventory/view_inventory_details.dart';
import 'package:ngbuka/src/features/presentation/views/spare_part/notification/notification_to_orders.dart';
import 'package:ngbuka/src/features/presentation/views/spare_part/notification/spare_notification.dart';
import 'package:ngbuka/src/features/presentation/views/spare_part/orders/orders.dart';
import 'package:ngbuka/src/features/presentation/views/spare_part/orders/orders_info.dart';
import 'package:ngbuka/src/features/presentation/views/spare_part/orders/process_order.dart';
import 'package:ngbuka/src/features/presentation/views/spare_part/orders/send_to_center.dart';
import 'package:ngbuka/src/features/presentation/views/spare_part/profile_settings/spare_add_wallet_page.dart';
import 'package:ngbuka/src/features/presentation/views/spare_part/profile_settings/spare_business_profile.dart';
import 'package:ngbuka/src/features/presentation/views/spare_part/profile_settings/spare_contact_page.dart';
import 'package:ngbuka/src/features/presentation/views/spare_part/profile_settings/spare_personal_info.dart';
import 'package:ngbuka/src/features/presentation/views/spare_part/dealer_info/spear_part_setup.dart';
import 'package:ngbuka/src/features/presentation/views/spare_part/dealer_info/store_info.dart';
import 'package:ngbuka/src/features/presentation/views/spare_part/profile_settings/spare_profile_page.dart';
import 'package:ngbuka/src/features/presentation/views/spare_part/spare_bottom_nav.dart';
import 'package:ngbuka/src/features/presentation/views/spare_part/wallet/spare_history_detail.dart';
import 'package:ngbuka/src/features/presentation/views/spare_part/wallet/spare_local_account_setup.dart';
import 'package:ngbuka/src/features/presentation/views/spare_part/wallet/spare_wallet_history.dart';
import 'package:ngbuka/src/features/presentation/views/spare_part/wallet/spare_withdraw_funds.dart';
import 'package:ngbuka/src/features/presentation/views/spare_part/wallet/spare_withdrawal_detail.dart';

GoRouter router() => GoRouter(
      routes: <GoRoute>[
        GoRoute(
          path: AppRoutes.splashscreen,
          name: AppRoutes.splashscreen,
          builder: (_, state) => const Splashscreen(),
        ),
        GoRoute(
          path: AppRoutes.onboarding,
          name: AppRoutes.onboarding,
          builder: (_, state) => const OnboardingScreen(),
        ),
        GoRoute(
          path: AppRoutes.accountSelection,
          name: AppRoutes.accountSelection,
          builder: (_, state) => const AccountSelection(),
        ),
        GoRoute(
          path: AppRoutes.createAccount,
          name: AppRoutes.createAccount,
          builder: (_, state) => const CreateAccount(),
        ),
        GoRoute(
          path: AppRoutes.verifyAccount,
          name: AppRoutes.verifyAccount,
          builder: (_, state) =>
              VerifyAccount(otpModel: state.extra as OTPModel),
        ),
        GoRoute(
          path: AppRoutes.login,
          name: AppRoutes.login,
          builder: (_, state) => const LoginView(),
        ),
        GoRoute(
          path: AppRoutes.forgotPassword,
          name: AppRoutes.forgotPassword,
          builder: (_, state) => const ForgotPassword(),
        ),
        GoRoute(
          path: AppRoutes.forgotPasswordPhone,
          name: AppRoutes.forgotPasswordPhone,
          builder: (_, state) => const ForgotPasswordPhone(),
        ),
        GoRoute(
          path: AppRoutes.newPassword,
          name: AppRoutes.newPassword,
          builder: (_, state) => const NewPassword(),
        ),
        GoRoute(
          path: AppRoutes.setup,
          name: AppRoutes.setup,
          builder: (_, state) => const SetupPage(),
        ),
        GoRoute(
          path: AppRoutes.personalInfo,
          name: AppRoutes.personalInfo,
          builder: (_, state) => const PersonalInfoPage(),
        ),
        GoRoute(
          path: AppRoutes.profileSettings,
          name: AppRoutes.profileSettings,
          builder: (_, state) => const ProfileSettings(),
        ),
        GoRoute(
          path: AppRoutes.personalInfoSettings,
          name: AppRoutes.personalInfoSettings,
          builder: (_, state) => const PersonalInfoSettings(),
        ),
        GoRoute(
          path: AppRoutes.businessInfo,
          name: AppRoutes.businessInfo,
          builder: (_, state) => const BusinessInfoPage(),
        ),
        GoRoute(
          path: AppRoutes.businessInfoSettings,
          name: AppRoutes.businessInfoSettings,
          builder: (_, state) => const BusinessInfoSettings(),
        ),
        GoRoute(
          path: AppRoutes.contactPage,
          name: AppRoutes.contactPage,
          builder: (_, state) => const ContactPage(),
        ),
        GoRoute(
          path: AppRoutes.bottomNav,
          name: AppRoutes.bottomNav,
          builder: (_, state) => const BottomNavigationBarView(),
        ),
        GoRoute(
          path: AppRoutes.bookings,
          name: AppRoutes.bookings,
          builder: (_, state) => Bookings(),
        ),
        GoRoute(
            path: AppRoutes.quoteMiddlemen,
            name: AppRoutes.quoteMiddlemen,
            builder: (context, state) {
              final data = state.extra! as Map<String, dynamic>;
              return QuoteMiddleman(
                id: data['id'],
                status: data['status'],
              );
            }),
        GoRoute(
          path: AppRoutes.bookingMiddleman,
          name: AppRoutes.bookingMiddleman,
          builder: (context, state) {
            final data = state.extra! as Map<String, dynamic>;
            return BookingMiddleman(
              id: data['id'],
              status: data['status'],
            );
          },
        ),
        GoRoute(
          path: AppRoutes.notificationToBooking,
          name: AppRoutes.notificationToBooking,
          builder: (_, state) => NotificationToBooking(
            id: state.extra as String,
          ),
        ),
        GoRoute(
          path: AppRoutes.notificationToQuote,
          name: AppRoutes.notificationToQuote,
          builder: (_, state) => NotificationToQuote(
            id: state.extra as String,
          ),
        ),
        GoRoute(
          path: AppRoutes.notificationToOrders,
          name: AppRoutes.notificationToOrders,
          builder: (_, state) => NotificationToOrders(
            id: state.extra as String,
          ),
        ),
        GoRoute(
          path: AppRoutes.businessLocation,
          name: AppRoutes.businessLocation,
          builder: (_, state) => const BusinessLocation(),
        ),
        GoRoute(
            path: AppRoutes.inspectionBooking,
            name: AppRoutes.inspectionBooking,
            builder: (_, state) => InspectionBooking(
                  id: state.extra as String,
                )),
        GoRoute(
          path: AppRoutes.viewAcceptedBooking,
          name: AppRoutes.viewAcceptedBooking,
          builder: (_, state) => ViewAcceptedBooking(
            id: state.extra as String,
          ),
        ),
        GoRoute(
            path: AppRoutes.viewRejectedBooking,
            name: AppRoutes.viewRejectedBooking,
            builder: (_, state) => ViewRejectedBooking(
                  id: state.extra as String,
                )),
        GoRoute(
            path: AppRoutes.bookingRejectedDetails,
            name: AppRoutes.bookingRejectedDetails,
            builder: (_, state) => BRInspectionDetails(
                  id: state.extra as String,
                )),
        GoRoute(
            path: AppRoutes.pendingPaymentRequestDetails,
            name: AppRoutes.pendingPaymentRequestDetails,
            builder: (_, state) => PPRInspectionDetails(
                  id: state.extra as String,
                )),
        GoRoute(
            path: AppRoutes.paymentRequestDetails,
            name: AppRoutes.paymentRequestDetails,
            builder: (_, state) => PRInspectionDetails(
                  id: state.extra as String,
                )),
        GoRoute(
            path: AppRoutes.paymentDeclinedDetails,
            name: AppRoutes.paymentDeclinedDetails,
            builder: (_, state) => PDInspectionDetails(
                  id: state.extra as String,
                )),
        GoRoute(
            path: AppRoutes.completedBookingDetails,
            name: AppRoutes.completedBookingDetails,
            builder: (_, state) => CompletedInspectionDetails(
                  id: state.extra as String,
                )),
        GoRoute(
            path: AppRoutes.pendingQuoteApprovalDetails,
            name: AppRoutes.pendingQuoteApprovalDetails,
            builder: (_, state) => PQAInspectionDetails(
                  id: state.extra as String,
                )),
        GoRoute(
            path: AppRoutes.quotesSend,
            name: AppRoutes.quotesSend,
            builder: (_, state) => QuoteSend(
                  id: state.extra as String,
                )),
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
          builder: (_, state) => Notification(),
        ),
        GoRoute(
            path: AppRoutes.newBookingNotification,
            name: AppRoutes.newBookingNotification,
            builder: (_, state) => NTInspectionBooking(
                  id: state.extra as String,
                )),
        GoRoute(
          path: AppRoutes.walletHistory,
          name: AppRoutes.walletHistory,
          builder: (_, state) => const WalletHistory(),
        ),
        GoRoute(
          path: AppRoutes.historyDetail,
          name: AppRoutes.historyDetail,
          builder: (_, state) => HistoryDetail(
            id: state.extra as String,
          ),
        ),
        GoRoute(
          path: AppRoutes.withdrawalDetail,
          name: AppRoutes.withdrawalDetail,
          builder: (_, state) => WithdrawalDetail(
            id: state.extra as String,
          ),
        ),
        GoRoute(
          path: AppRoutes.withdrawFunds,
          name: AppRoutes.withdrawFunds,
          builder: (_, state) => WithdrawFunds(),
        ),
        GoRoute(
          path: AppRoutes.localAccountSetup,
          name: AppRoutes.localAccountSetup,
          builder: (_, state) => const LocalAccountSetup(),
        ),
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
            path: AppRoutes.addWallet,
            name: AppRoutes.addWallet,
            builder: (_, state) => const AddWalletPage()),
        GoRoute(
            path: AppRoutes.newQuoteAlert,
            name: AppRoutes.newQuoteAlert,
            builder: (_, state) => const NewQuoteAlert()),
        GoRoute(
            path: AppRoutes.quoteRequest,
            name: AppRoutes.quoteRequest,
            builder: (_, state) => QuoteRequests(
                  id: state.extra as String,
                )),
        GoRoute(
            path: AppRoutes.acceptedQuotes,
            name: AppRoutes.acceptedQuotes,
            builder: (_, state) => const AcceptedQuotes()),
        GoRoute(
          path: AppRoutes.viewAcceptedQuote,
          name: AppRoutes.viewAcceptedQuote,
          builder: (_, state) => ViewAcceptedQuote(
            id: state.extra as String,
          ),
        ),
        GoRoute(
          path: AppRoutes.sendQuotes,
          name: AppRoutes.sendQuotes,
          builder: (_, state) => SendQuote(
            id: state.extra as String,
          ),
        ),
        GoRoute(
            path: AppRoutes.rejectedQuote,
            name: AppRoutes.rejectedQuote,
            builder: (_, state) => const RejectedQuote()),
        GoRoute(
            path: AppRoutes.rejectedQuoteDetails,
            name: AppRoutes.rejectedQuoteDetails,
            builder: (_, state) => RQInspectionDetails(
                  id: state.extra as String,
                )),
        GoRoute(
            path: AppRoutes.pendingClientApproval,
            name: AppRoutes.pendingClientApproval,
            builder: (_, state) => const PendingClientApproval()),
        GoRoute(
            path: AppRoutes.pendingClientApprovalDetails,
            name: AppRoutes.pendingClientApprovalDetails,
            builder: (_, state) => PCAInspectionDetails(
                  id: state.extra as String,
                )),
        GoRoute(
            path: AppRoutes.quotePaymentRequest,
            name: AppRoutes.quotePaymentRequest,
            builder: (_, state) => const QPaymentRequest()),
        GoRoute(
            path: AppRoutes.quotePaymentRequestDetails,
            name: AppRoutes.quotePaymentRequestDetails,
            builder: (_, state) => PRQInspectionDetails(
                  id: state.extra as String,
                )),
        GoRoute(
            path: AppRoutes.pendingQuotePaymentRequestDetails,
            name: AppRoutes.pendingQuotePaymentRequestDetails,
            builder: (_, state) => PPRQInspectionDetails(
                  id: state.extra as String,
                )),
        GoRoute(
            path: AppRoutes.quotePaymentDecline,
            name: AppRoutes.quotePaymentDecline,
            builder: (_, state) => const QPaymentDeclined()),
        GoRoute(
            path: AppRoutes.quotePaymentDeclineDetails,
            name: AppRoutes.quotePaymentDeclineDetails,
            builder: (_, state) => PDQInspectionDetails(
                  id: state.extra as String,
                )),
        GoRoute(
            path: AppRoutes.completedQuoteRequest,
            name: AppRoutes.completedQuoteRequest,
            builder: (_, state) => const CompletedQuoteRequest()),
        GoRoute(
          path: AppRoutes.completedQuoteRequestDetails,
          name: AppRoutes.completedQuoteRequestDetails,
          builder: (_, state) => CQRInspectionDetails(
            id: state.extra as String,
          ),
        ),
        GoRoute(
          path: AppRoutes.quoteRejected,
          name: AppRoutes.quoteRejected,
          builder: (_, state) => const QuoteRejected(),
        ),
        GoRoute(
          path: AppRoutes.quoteRejectedDetails,
          name: AppRoutes.quoteRejectedDetails,
          builder: (_, state) => QRInspectionDetails(
            id: state.extra as String,
          ),
        ),

        // Dealer

        GoRoute(
          path: AppRoutes.dealerCreateAccount,
          name: AppRoutes.dealerCreateAccount,
          builder: (_, state) => const DealerCreateAccount(),
        ),
        GoRoute(
          path: AppRoutes.dealerLogin,
          name: AppRoutes.dealerLogin,
          builder: (_, state) => const DealerLoginView(),
        ),
        GoRoute(
          path: AppRoutes.spareForgotPassword,
          name: AppRoutes.spareForgotPassword,
          builder: (_, state) => const SpareForgotPassword(),
        ),
        GoRoute(
          path: AppRoutes.spareForgotPasswordPhone,
          name: AppRoutes.spareForgotPasswordPhone,
          builder: (_, state) => const SpareForgotPasswordPhone(),
        ),
        GoRoute(
          path: AppRoutes.spareNewPassword,
          name: AppRoutes.spareNewPassword,
          builder: (_, state) => const SpareNewPassword(),
        ),
        GoRoute(
          path: AppRoutes.spareVerifyAccount,
          name: AppRoutes.spareVerifyAccount,
          builder: (_, state) => SpareVerifyAccount(
            otpModel: state.extra as OTPModel,
          ),
        ),
        GoRoute(
          path: AppRoutes.spareBottomNav,
          name: AppRoutes.spareBottomNav,
          builder: (_, state) => const BottomNavBarView(),
        ),
        GoRoute(
          path: AppRoutes.spareSetup,
          name: AppRoutes.spareSetup,
          builder: (_, state) => const SpearSetupPage(),
        ),
        GoRoute(
          path: AppRoutes.spareStoreInfo,
          name: AppRoutes.spareStoreInfo,
          builder: (_, state) => const SpareStoreInfo(),
        ),
        GoRoute(
          path: AppRoutes.spareBusinessInfo,
          name: AppRoutes.spareBusinessInfo,
          builder: (_, state) => const SpareBusinessInfo(),
        ),
        GoRoute(
          path: AppRoutes.spareLocalAccountSetup,
          name: AppRoutes.spareLocalAccountSetup,
          builder: (_, state) => const SpareLocalAccountSetup(),
        ),
        GoRoute(
          path: AppRoutes.spareWithdrawFunds,
          name: AppRoutes.spareWithdrawFunds,
          builder: (_, state) => SpareWithdrawFunds(),
        ),
        GoRoute(
          path: AppRoutes.spareWithdrawalDetail,
          name: AppRoutes.spareWithdrawalDetail,
          builder: (_, state) => SpareWithdrawalDetail(
            id: state.extra as String,
          ),
        ),
        GoRoute(
          path: AppRoutes.spareWalletHistory,
          name: AppRoutes.spareWalletHistory,
          builder: (_, state) => const SpareWalletHistory(),
        ),
        GoRoute(
          path: AppRoutes.spareHistoryDetail,
          name: AppRoutes.spareHistoryDetail,
          builder: (_, state) => SpareHistoryDetail(
            id: state.extra as String,
          ),
        ),
        GoRoute(
          path: AppRoutes.sparePersonalInfo,
          name: AppRoutes.sparePersonalInfo,
          builder: (_, state) => const SparePersonalInfo(),
        ),
        GoRoute(
          path: AppRoutes.spareProfileSettings,
          name: AppRoutes.spareProfileSettings,
          builder: (_, state) => const SpareProfileSettings(),
        ),
        GoRoute(
          path: AppRoutes.spareBusinessProfile,
          name: AppRoutes.spareBusinessProfile,
          builder: (_, state) => const SpareBusinessProfile(),
        ),
        GoRoute(
          path: AppRoutes.spareContactPage,
          name: AppRoutes.spareContactPage,
          builder: (_, state) => const SpareContactPage(),
        ),
        GoRoute(
          path: AppRoutes.spareAddWallet,
          name: AppRoutes.spareAddWallet,
          builder: (_, state) => const SpareAddWalletPage(),
        ),
        GoRoute(
          path: AppRoutes.inventory,
          name: AppRoutes.inventory,
          builder: (_, state) => const Inventory(),
        ),
        GoRoute(
          path: AppRoutes.addInventory,
          name: AppRoutes.addInventory,
          builder: (_, state) => const AddInventory(),
        ),
        GoRoute(
          path: AppRoutes.editInventory,
          name: AppRoutes.editInventory,
          builder: (_, state) => EditInventory(
            id: state.extra as String,
          ),
        ),
        GoRoute(
          path: AppRoutes.viewInventoryDetails,
          name: AppRoutes.viewInventoryDetails,
          builder: (_, state) => ViewInventoryDetails(
            id: state.extra as dynamic,
          ),
        ),
        GoRoute(
          path: AppRoutes.orders,
          name: AppRoutes.orders,
          builder: (_, state) => const Orders(),
        ),
        GoRoute(
          path: AppRoutes.ordersInfo,
          name: AppRoutes.ordersInfo,
          builder: (_, state) => OrdersInfo(
            id: state.extra as String,
          ),
        ),
        GoRoute(
          path: AppRoutes.processOrder,
          name: AppRoutes.processOrder,
          builder: (_, state) => ProcessOrder(
            id: state.extra as String,
          ),
        ),
        GoRoute(
          path: AppRoutes.sendToCenter,
          name: AppRoutes.sendToCenter,
          builder: (_, state) => const SendToCenter(),
        ),
        GoRoute(
          path: AppRoutes.spareNotification,
          name: AppRoutes.spareNotification,
          builder: (_, state) => SpareNotification(),
        ),
      ],
    );
