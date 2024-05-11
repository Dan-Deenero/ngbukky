import 'package:ngbuka/src/domain/data/inspection_booking_model.dart';
import 'package:ngbuka/src/domain/data/ordered_item_model.dart';
import 'package:ngbuka/src/domain/data/orders_model.dart';
import 'package:ngbuka/src/domain/data/quote_model.dart';

class TransactionModel {
  String? id;
  String? userId;
  String? transactableId;
  String? transactableType;
  String? transactionType;
  String? reference;
  int? amount;
  String? status;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  OrderedItem? orderedItem;
  OrdersModel? order;
  QuotesModel? quoteRequest;
  BookingModel? booking;

  TransactionModel(
      {this.id,
      this.userId,
      this.transactableId,
      this.transactableType,
      this.transactionType,
      this.reference,
      this.amount,
      this.status,
      this.deletedAt,
      this.createdAt,
      this.updatedAt,
      this.orderedItem,
      this.order,
      this.quoteRequest,
      this.booking});

  TransactionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    transactableId = json['transactableId'];
    transactableType = json['transactableType'];
    transactionType = json['transactionType'];
    reference = json['reference'];
    amount = json['amount'];
    status = json['status'];
    deletedAt = json['deletedAt'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    orderedItem = json['orderedItem'] != null ? OrderedItem.fromJson(json['orderedItem']) : null;
    order = json['order'] != null ? OrdersModel.fromJson(json['order']) : null;
    quoteRequest = json['quoteRequest'] != null ? QuotesModel.fromJson(json['quoteRequest']) : null;
    booking =
        json['booking'] != null ? BookingModel.fromJson(json['booking']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['userId'] = userId;
    data['transactableId'] = transactableId;
    data['transactableType'] = transactableType;
    data['transactionType'] = transactionType;
    data['reference'] = reference;
    data['amount'] = amount;
    data['status'] = status;
    data['deletedAt'] = deletedAt;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (orderedItem != null) {
      data['orderedItem'] = orderedItem!.toJson();
    }
    if (order != null) {
      data['order'] = order!.toJson();
    }
    if (quoteRequest != null) {
      data['quoteRequest'] = quoteRequest!.toJson();
    }
    if (booking != null) {
      data['booking'] = booking!.toJson();
    }
    return data;
  }
}