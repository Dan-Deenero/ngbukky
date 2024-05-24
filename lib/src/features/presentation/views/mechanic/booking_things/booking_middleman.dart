import 'package:flutter/material.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/Bookings/accepted-bookings/view_accepted_booking.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/Bookings/booking-rejected/inspection_details_br.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/Bookings/completed_booking/inspection_details.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/Bookings/new-booking-alert/inspection_booking.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/Bookings/payment_declined/inspection_details_pd.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/Bookings/payment_request/inspection_details_ppr.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/Bookings/payment_request/inspection_details_pr.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/Bookings/pending_quote_approval/Inspection_details_pqa.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/Bookings/rejected-bookings/view_rejected_booking.dart';

class BookingMiddleman extends StatefulWidget {
  final String id;
  final String status;

  const BookingMiddleman({super.key, required this.id, required this.status});

  @override
  State<BookingMiddleman> createState() => _BookingMiddlemanState();
}

class _BookingMiddlemanState extends State<BookingMiddleman> {

  @override
  Widget build(BuildContext context) {

        if(widget.status == 'pending'){
          return InspectionBooking(id: widget.id,);
        }else if(widget.status == 'accepted'){
          return ViewAcceptedBooking(id: widget.id,);
        }else if(widget.status == 'bargaining'){
          return PQAInspectionDetails(id: widget.id,);
        }else if(widget.status == 'approved'){
          return PPRInspectionDetails(id: widget.id,);
        }else if(widget.status == 'rejected'){
          return ViewRejectedBooking(id: widget.id,);
        }else if(widget.status == 'declined'){
          return PDInspectionDetails(id: widget.id,);
        }else if(widget.status == 'completed'){
          return CompletedInspectionDetails(id: widget.id,);
        }else if(widget.status == 'disapproved'){
          return BRInspectionDetails(id: widget.id,);
        }else if(widget.status == 'awaiting payment'){
          return PRInspectionDetails(id: widget.id,);
        }else{
          return const DefaultWidget();
        }
        
  }
}

class DefaultWidget extends StatelessWidget {
  const DefaultWidget({super.key, });
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Unknown status'),
      ),
    );
  }
}