import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ngbuka/src/config/keys/app_routes.dart';
import 'package:ngbuka/src/domain/data/notification_model.dart';

class Helpers{
  static routeToRespectiveNotificationScreens(NotificationModel? data, BuildContext context) {
   switch (data!.notifiableType) {
     case "booking":
       switch (data.booking!.status) {
         case "pending":
         context.push(AppRoutes.inspectionBooking, extra: data.booking!.id);
         break;
         case "accepted":
         context.push(AppRoutes.viewAcceptedBooking, extra: data.booking!.id);
         break;
         case "bargaining":
         context.push(AppRoutes.pendingQuoteApprovalDetails, extra: data.booking!.id);
         break;
         case "approved":
         context.push(AppRoutes.paymentRequestDetails, extra: data.booking!.id);
         break;
         case "rejected":
         context.push(AppRoutes.viewRejectedBooking, extra: data.booking!.id);
         break;
         case "declined":
         context.push(AppRoutes.paymentDeclinedDetails, extra: data.booking!.id);
         break;
         case "completed":
         context.push(AppRoutes.completedBookingDetails, extra: data.booking!.id);
         break;
         case "disapproved":
         context.push(AppRoutes.bookingRejectedDetails, extra: data.booking!.id);
         break;
         case "awaiting paymen":
         context.push(AppRoutes.pendingPaymentRequestDetails, extra: data.booking!.id);
         break;
     }
     case "quoteRequest":
       switch (data.quoteRequest!.status) {
         case "pending":
         context.push(AppRoutes.quoteRequest, extra: data.quoteRequest!.id);
         break;
         case "accepted":
         context.push(AppRoutes.viewAcceptedQuote, extra: data.quoteRequest!.id);
         break;
         case "bargaining":
         context.push(AppRoutes.pendingClientApprovalDetails, extra: data.quoteRequest!.id);
         break;
         case "approved":
         context.push(AppRoutes.quotePaymentRequestDetails, extra: data.quoteRequest!.id);
         break;
         case "rejected":
         context.push(AppRoutes.rejectedQuoteDetails, extra: data.quoteRequest!.id);
         break;
         case "declined":
         context.push(AppRoutes.quotePaymentDeclineDetails, extra: data.quoteRequest!.id);
         break;
         case "completed":
         context.push(AppRoutes.completedQuoteRequestDetails, extra: data.quoteRequest!.id);
         break;
         case "disapproved":
         context.push(AppRoutes.quoteRejectedDetails, extra: data.quoteRequest!.id);
         break;
         case "awaiting payment":
         context.push(AppRoutes.pendingQuotePaymentRequestDetails, extra: data.quoteRequest!.id);
         break;
     }
  }
}
}