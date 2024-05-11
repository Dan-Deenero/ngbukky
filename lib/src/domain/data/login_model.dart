// ignore_for_file: unnecessary_this, prefer_collection_literals

class   LoginModel {
  String? token;
  String? refreshToken;
  User? user;

  LoginModel({this.token, this.refreshToken, this.user});

  LoginModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    refreshToken = json['refreshToken'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['token'] = this.token;
    data['refreshToken'] = this.refreshToken;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  bool? isEmailVerified;
  String? role;
  String? businessName;
  String? mechanicType;
  String? address;
  String? lga;
  String? city;
  String? state;
  String? longitude;
  String? latitude;

  User(
      {this.isEmailVerified,
      this.role,
      this.businessName,
      this.mechanicType,
      this.address,
      this.lga,
      this.city,
      this.state,
      this.longitude,
      this.latitude});

  User.fromJson(Map<String, dynamic> json) {
    isEmailVerified = json['isEmailVerified'];
    role = json['role'];
    businessName = json['businessName'];
    mechanicType = json['mechanicType'];
    address = json['address'];
    lga = json['lga'];
    city = json['city'];
    state = json['state'];
    longitude = json['longitude'];
    latitude = json['latitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['isEmailVerified'] = this.isEmailVerified;
    data['role'] = this.role;
    data['businessName'] = this.businessName;
    data['mechanicType'] = this.mechanicType;
    data['address'] = this.address;
    data['lga'] = this.lga;
    data['city'] = this.city;
    data['state'] = this.state;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    return data;
  }
}
