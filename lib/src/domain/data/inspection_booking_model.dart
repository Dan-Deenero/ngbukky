
class BookingModel {
  String? id;
  String? status;
  String? date;
  String? brand;
  String? model;
  int? year;
  User? user;

  BookingModel(
      {this.id,
      this.status,
      this.date,
      this.brand,
      this.model,
      this.year,
      this.user});

  BookingModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    date = json['date'];
    brand = json['brand'];
    model = json['model'];
    year = json['year'];
    user = json['user'] != null ?  User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['status'] = status;
    data['date'] = date;
    data['brand'] = brand;
    data['model'] = model;
    data['year'] = year;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  String? id;
  String? username;

  User({this.id, this.username});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    return data;
  }
}