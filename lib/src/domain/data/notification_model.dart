import 'package:ngbuka/src/domain/data/inspection_booking_model.dart';
import 'package:ngbuka/src/domain/data/orders_model.dart';
import 'package:ngbuka/src/domain/data/quote_model.dart';

class NotificationModel {
  String? id;
  String? notifiableId;
  String? notifiableType;
  String? title;
  String? body;
  String? viewedAt;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? priority;
  User? user;
  BookingModel? booking;
  OrdersModel? order;
  String? ban;
  QuotesModel? quoteRequest;

  NotificationModel(
      {this.id,
      this.notifiableId,
      this.notifiableType,
      this.title,
      this.body,
      this.viewedAt,
      this.priority,
      this.user,
      this.booking,
      this.order,
      this.ban,
      this.quoteRequest,
      this.createdAt,
      this.deletedAt,
      this.updatedAt});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    notifiableId = json['notifiableId'];
    notifiableType = json['notifiableType'];
    title = json['title'];
    body = json['body'];
    viewedAt = json['viewedAt'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deletedAt = json['deletedAt'];
    priority = json['priority'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    booking =
        json['booking'] != null ? BookingModel.fromJson(json['booking']) : null;
    order = json['order'] != null ? OrdersModel.fromJson(json['order']) : null;
    ban = json['ban'];
    quoteRequest = json['quoteRequest'] != null
        ? QuotesModel.fromJson(json['quoteRequest'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['notifiableId'] = notifiableId;
    data['notifiableType'] = notifiableType;
    data['title'] = title;
    data['body'] = body;
    data['viewedAt'] = viewedAt;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['deletedAt'] = deletedAt;
    data['priority'] = priority;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (booking != null) {
      data['booking'] = booking!.toJson();
    }
    data['order'] = order;
    data['ban'] = ban;
    if (quoteRequest != null) {
      data['quoteRequest'] = quoteRequest!.toJson();
    }
    return data;
  }

  NotificationModel copyWith({
    String? id,
    String? notifiableId,
    String? notifiableType,
    String? title,
    String? body,
    String? viewedAt,
    String? createdAt,
    String? updatedAt,
    String? deletedAt,
    String? priority,
    User? user,
    BookingModel? booking,
    OrdersModel? order,
    String? ban,
    QuotesModel? quoteRequest,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      notifiableId: notifiableId ?? this.notifiableId,
      notifiableType: notifiableType ?? this.notifiableType,
      title: title ?? this.title,
      body: body ?? this.body,
      viewedAt: viewedAt ?? this.viewedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      priority: priority ?? this.priority,
      user: user ?? this.user,
      booking: booking ?? this.booking,
      order: order ?? this.order,
      ban: ban ?? this.ban,
      quoteRequest: quoteRequest ?? this.quoteRequest,
    );
  }
}

class User {
  String? id;
  String? firstname;
  String? lastname;

  User({this.id, this.firstname, this.lastname});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    return data;
  }
}
