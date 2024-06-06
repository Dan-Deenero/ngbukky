import 'package:flutter/material.dart';
import 'package:ngbuka/src/domain/data/notification_model.dart';
import 'package:ngbuka/src/domain/data/quote_model.dart';
import 'package:ngbuka/src/domain/repository/mechanic_repository.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/Quotes/accepted_quote/view_accepted_quotes.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/Quotes/completed_quote/inspection_details_cqr.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/Quotes/new_quote_request/quote_request.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/Quotes/payment_declined/inspection_details_pdq.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/Quotes/payment_request/inspection_details_pprq.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/Quotes/payment_request/inspection_details_prq.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/Quotes/pending_client_approval/inspection_details_pca.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/Quotes/quote_rejected/inspection_details_qr.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/Quotes/rejected_quote/inspection_detalis_rq.dart';

class NotificationToQuote extends StatefulWidget {
  final String id;

  const NotificationToQuote({
    super.key,
    required this.id,
  });

  @override
  State<NotificationToQuote> createState() => _NotificationToQuoteState();
}

class _NotificationToQuoteState extends State<NotificationToQuote> {
  bool isLoading = true;
  final MechanicRepo _mechanicRepo = MechanicRepo();
  QuotesModel? quoteModel;
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
      return _mechanicRepo.getoneQuote(notifyModel!.notifiableId);
    }).then((value) {
      setState(() {
        quoteModel = value;
        isLoading = false;
        id = quoteModel!.id;
        status = quoteModel!.status;
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
        return QuoteRequests(
          id: id!,
        );
      } else if (status == 'accepted') {
        return ViewAcceptedQuote(
          id: id!,
        );
      } else if (status == 'bargaining') {
        return PCAInspectionDetails(
          id: id!,
        );
      } else if (status == 'approved') {
        return PPRQInspectionDetails(
          id: id!,
        );
      } else if (status == 'rejected') {
        return RQInspectionDetails(
          id: id!,
        );
      } else if (status == 'declined') {
        return PDQInspectionDetails(
          id: id!,
        );
      } else if (status == 'completed') {
        return CQRInspectionDetails(
          id: id!,
        );
      } else if (status == 'disapproved') {
        return QRInspectionDetails(
          id: id!,
        );
      } else if (status == 'awaiting payment') {
        return PRQInspectionDetails(
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
        child: Text('No assoiciated quote '),
      ),
    );
  }
}
