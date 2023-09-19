class UserModel {
  String? id;
  String? firstname;
  String? lastname;
  String? email;
  String? phoneNumber;
  String? username;
  bool? isEmailVerified;
  String? verifiedEmailAt;
  String? profileImageUrl;
  String? role;
  String? status;
  String? ninImageUrl;
  bool? isServiceProvider;
  String? businessName;
  String? cacNumber;
  String? address;
  String? lga;
  String? city;
  String? state;
  String? longitude;
  String? latitude;
  String? deviceToken;
  String? mechanicType;
  String? about;
  List<String>? languages;
  bool? isActive;
  List<Services>? services;
  List<Services>? otherServices;
  List<String>? cars;
  List<Availability>? availability;

  UserModel(
      {this.id,
      this.firstname,
      this.lastname,
      this.email,
      this.phoneNumber,
      this.username,
      this.isEmailVerified,
      this.verifiedEmailAt,
      this.profileImageUrl,
      this.role,
      this.status,
      this.ninImageUrl,
      this.isServiceProvider,
      this.businessName,
      this.cacNumber,
      this.address,
      this.lga,
      this.city,
      this.state,
      this.longitude,
      this.latitude,
      this.deviceToken,
      this.mechanicType,
      this.about,
      this.languages,
      this.isActive,
      this.services,
      this.otherServices,
      this.cars,
      this.availability});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    username = json['username'];
    isEmailVerified = json['isEmailVerified'];
    verifiedEmailAt = json['verifiedEmailAt'];
    profileImageUrl = json['profileImageUrl'];
    role = json['role'];
    status = json['status'];
    ninImageUrl = json['ninImageUrl'];
    isServiceProvider = json['isServiceProvider'];
    businessName = json['businessName'];
    cacNumber = json['cacNumber'];
    address = json['address'];
    lga = json['lga'];
    city = json['city'];
    state = json['state'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    deviceToken = json['deviceToken'];
    mechanicType = json['mechanicType'];
    about = json['about'];
    languages = json['languages'].cast<String>();
    isActive = json['isActive'];
    if (json['services'] != null) {
      services = <Services>[];
      json['services'].forEach((v) {
        services!.add(Services.fromJson(v));
      });
    }
    if (json['otherServices'] != null) {
      otherServices = <Services>[];
      json['otherServices'].forEach((v) {
        otherServices!.add(Services.fromJson(v));
      });
    }
    cars = json['cars'].cast<String>();
    if (json['availability'] != null) {
      availability = <Availability>[];
      json['availability'].forEach((v) {
        availability!.add(new Availability.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    data['username'] = this.username;
    data['isEmailVerified'] = this.isEmailVerified;
    data['verifiedEmailAt'] = this.verifiedEmailAt;
    data['profileImageUrl'] = this.profileImageUrl;
    data['role'] = this.role;
    data['status'] = this.status;
    data['ninImageUrl'] = this.ninImageUrl;
    data['isServiceProvider'] = this.isServiceProvider;
    data['businessName'] = this.businessName;
    data['cacNumber'] = this.cacNumber;
    data['address'] = this.address;
    data['lga'] = this.lga;
    data['city'] = this.city;
    data['state'] = this.state;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['deviceToken'] = this.deviceToken;
    data['mechanicType'] = this.mechanicType;
    data['about'] = this.about;
    data['languages'] = this.languages;
    data['isActive'] = this.isActive;
    if (this.services != null) {
      data['services'] = this.services!.map((v) => v.toJson()).toList();
    }
    if (this.otherServices != null) {
      data['otherServices'] =
          this.otherServices!.map((v) => v.toJson()).toList();
    }
    // data['cars'] = this.cars;
    if (this.availability != null) {
      data['availability'] = this.availability!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Services {
  String? id;
  String? name;

  Services({this.id, this.name});

  Services.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class Availability {
  String? id;
  String? day;
  String? from;
  String? to;

  Availability({this.id, this.day, this.from, this.to});

  Availability.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    day = json['day'];
    from = json['from'];
    to = json['to'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['day'] = this.day;
    data['from'] = this.from;
    data['to'] = this.to;
    return data;
  }
}
