class NotificationModel {
  String? id;
  String? userId;
  String? notifiableId;
  String? notifiableType;
  String? title;
  String? body;
  String? viewedAt;
  String? priority;

  NotificationModel(
      {this.id,
      this.userId,
      this.notifiableId,
      this.notifiableType,
      this.title,
      this.body,
      this.viewedAt,
      this.priority});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    notifiableId = json['notifiableId'];
    notifiableType = json['notifiableType'];
    title = json['title'];
    body = json['body'];
    viewedAt = json['viewedAt'];
    priority = json['priority'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['userId'] = userId;
    data['notifiableId'] = notifiableId;
    data['notifiableType'] = notifiableType;
    data['title'] = title;
    data['body'] = body;
    data['viewedAt'] = viewedAt;
    data['priority'] = priority;
    return data;
  }
}