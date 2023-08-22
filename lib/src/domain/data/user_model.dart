class UserModel {
  String? id;
  String? firstname;
  String? lastname;
  String? email;
  String? phoneNumber;
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
  List<String>? services;
  List<String>? otherServices;
  List<String>? availability;

  UserModel(
      {this.id,
      this.firstname,
      this.lastname,
      this.email,
      this.phoneNumber,
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
      this.availability});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
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
    if (json['languages'] != null) {
      languages = <String>[];
      json['languages'].forEach((v) {
        languages!.add((v));
      });
    }
    isActive = json['isActive'];
    if (json['services'] != null) {
      services = <String>[];
      json['services'].forEach((v) {
        services!.add((v));
      });
    }
    if (json['otherServices'] != null) {
      otherServices = <String>[];
      json['otherServices'].forEach((v) {
        otherServices!.add((v));
      });
    }
    if (json['availability'] != null) {
      availability = <String>[];
      json['availability'].forEach((v) {
        availability!.add((v));
      });
    }
  }
}
