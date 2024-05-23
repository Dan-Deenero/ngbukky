import 'package:flutter/material.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/Quotes/accepted_quote/view_accepted_quotes.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/Quotes/completed_quote/inspection_details_cqr.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/Quotes/new_quote_request/quote_request.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/Quotes/payment_declined/inspection_details_pdq.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/Quotes/payment_request/inspection_details_pprq.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/Quotes/payment_request/inspection_details_prq.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/Quotes/pending_client_approval/inspection_details_pca.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/Quotes/quote_rejected/inspection_details_qr.dart';
import 'package:ngbuka/src/features/presentation/views/mechanic/Quotes/rejected_quote/inspection_detalis_rq.dart';

class QuoteMiddleman extends StatefulWidget {
  final String id;
  final String status;
  const QuoteMiddleman({super.key, required this.id, required this.status});

  @override
  State<QuoteMiddleman> createState() => _QuoteMiddlemanState();
}

class _QuoteMiddlemanState extends State<QuoteMiddleman> {
  @override
  Widget build(BuildContext context) {
    if(widget.status == 'booking'){
          return QuoteRequests(id: widget.id,);
        }else if(widget.status == 'accepted'){
          return ViewAcceptedQuote(id: widget.id,);
        }else if(widget.status == 'bargaining'){
          return PCAInspectionDetails(id: widget.id,);
        }else if(widget.status == 'approved'){
          return PPRQInspectionDetails(id: widget.id,);
        }else if(widget.status == 'rejected'){
          return RQInspectionDetails(id: widget.id,);
        }else if(widget.status == 'declined'){
          return PDQInspectionDetails(id: widget.id,);
        }else if(widget.status == 'completed'){
          return CQRInspectionDetails(id: widget.id,);
        }else if(widget.status == 'disapproved'){
          return QRInspectionDetails(id: widget.id,);
        }else if(widget.status == 'awaiting payment'){
          return PRQInspectionDetails(id: widget.id,);
        }else{
          return const DefaultWidget();
        }
  }
}

class DefaultWidget extends StatelessWidget {
  const DefaultWidget({super.key, });
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Unknown status'),
    );
  }
}