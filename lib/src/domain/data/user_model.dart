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
  String? town;
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
      this.town,
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
    town = json['town'];
    city = json['city'];
    state = json['state'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    deviceToken = json['deviceToken'];
    mechanicType = json['mechanicType'];
    about = json['about'];
    cars = json['cars'].cast<String>();
    languages = json['languages'] != null
    ? (json['languages'] as List).cast<String>()
    : null;
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
    if (json['availability'] != null) {
      availability = <Availability>[];
      json['availability'].forEach((v) {
        availability!.add(Availability.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    data['email'] = email;
    data['phoneNumber'] = phoneNumber;
    data['username'] = username;
    data['isEmailVerified'] = isEmailVerified;
    data['verifiedEmailAt'] = verifiedEmailAt;
    data['profileImageUrl'] = profileImageUrl;
    data['role'] = role;
    data['status'] = status;
    data['ninImageUrl'] = ninImageUrl;
    data['isServiceProvider'] = isServiceProvider;
    data['businessName'] = businessName;
    data['cacNumber'] = cacNumber;
    data['address'] = address;
    data['town'] = town;
    data['cars'] = cars;
    data['city'] = city;
    data['state'] = state;
    data['longitude'] = longitude;
    data['latitude'] = latitude;
    data['deviceToken'] = deviceToken;
    data['mechanicType'] = mechanicType;
    data['about'] = about;
    data['languages'] = languages;
    data['isActive'] = isActive;
    if (services != null) {
      data['services'] = services!.map((v) => v.toJson()).toList();
    }
    if (otherServices != null) {
      data['otherServices'] =
          otherServices!.map((v) => v.toJson()).toList();
    }
    if (availability != null) {
      data['availability'] = availability!.map((v) => v.toJson()).toList();
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
    data['id'] = id;
    data['name'] = name;
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
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = id;
    data['day'] = day;
    data['from'] = from;
    data['to'] = to;
    return data;
  }
}
