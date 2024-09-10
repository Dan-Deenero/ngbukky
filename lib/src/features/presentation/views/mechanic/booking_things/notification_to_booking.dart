import 'package:flutter/material.dart';
import 'package:ngbuka/src/domain/data/inspection_booking_model.dart';
import 'package:ngbuka/src/domain/data/notification_model.dart';
import 'package:ngbuka/src/domain/repository/mechanic_repository.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/Bookings/accepted-bookings/view_accepted_booking.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/Bookings/booking-rejected/inspection_details_br.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/Bookings/completed_booking/inspection_details.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/Bookings/new-booking-alert/inspection_booking.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/Bookings/payment_declined/inspection_details_pd.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/Bookings/payment_request/inspection_details_ppr.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/Bookings/payment_request/inspection_details_pr.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/Bookings/pending_quote_approval/Inspection_details_pqa.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/Bookings/rejected-bookings/view_rejected_booking.dart';

class NotificationToBooking extends StatefulWidget {
  final String id;

  const NotificationToBooking({
    super.key,
    required this.id,
  });

  @override
  State<NotificationToBooking> createState() => _NotificationToBookingState();
}

class _NotificationToBookingState extends State<NotificationToBooking> {
  bool isLoading = true;
  final MechanicRepo _mechanicRepo = MechanicRepo();
  BookingModel? bookingModel;
  NotificationModel? notifyModel;
  String? id;
  String? status;

  @override
  void initState() {
    super.initState();
    _mechanicRepo.getOneNotification(widget.id).then((value) {
      setState(() {
        notifyModel = value;
      });
      return _mechanicRepo.getoneBooking(notifyModel!.notifiableId);
    }).then((value) {
      setState(() {
        bookingModel = value;
        isLoading = false;
        id = bookingModel!.id;
        status = bookingModel!.status;
      });
    }).catchError((error) {
      // Handle any errors here
      setState(() {
        isLoading = false;
        // Optionally handle the error state
      });
      print(error);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: SingleChildScrollView(),
      );
    } else {
      if (status == 'pending') {
        return InspectionBooking(
          id: id!,
        );
      } else if (status == 'accepted') {
        return ViewAcceptedBooking(
          id: id,
        );
      } else if (status == 'bargaining') {
        return PQAInspectionDetails(
          id: id!,
        );
      } else if (status == 'approved') {
        return PPRInspectionDetails(
          id: id!,
        );
      } else if (status == 'rejected') {
        return ViewRejectedBooking(
          id: id!,
        );
      } else if (status == 'declined') {
        return PDInspectionDetails(
          id: id!,
        );
      } else if (status == 'completed') {
        return CompletedInspectionDetails(
          id: id!,
        );
      } else if (status == 'disapproved') {
        return BRInspectionDetails(
          id: id!,
        );
      } else if (status == 'awaiting payment') {
        return PRInspectionDetails(
          id: id!,
        );
      } else {
        return const DefaultWidget();
      }
    }
  }
}

class DefaultWidget extends StatelessWidget {
  const DefaultWidget({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('No assosicaited inspection booking'),
      ),
    );
  }
}
