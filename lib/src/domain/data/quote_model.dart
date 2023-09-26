class QuotesModel {
  String? id;
  String? status;
  String? description;
  String? brand;
  String? model;
  int? year;
  String? createdAt;
  List<Services>? services;
  List<String>? otherServices;
  Mechanic? mechanic;
  User? user;

  QuotesModel(
      {this.id,
      this.status,
      this.description,
      this.brand,
      this.model,
      this.year,
      this.createdAt,
      this.services,
      this.otherServices,
      this.mechanic,
      this.user});

  QuotesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    description = json['description'];
    brand = json['brand'];
    model = json['model'];
    year = json['year'];
    createdAt = json['createdAt'];
    if (json['Services'] != null) {
      services = <Services>[];
      json['Services'].forEach((v) {
        services!.add(Services.fromJson(v));
      });
    }
    otherServices = json['otherServices'].cast<String>();
    mechanic = json['mechanic'] != null
        ? Mechanic.fromJson(json['mechanic'])
        : null;
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['status'] = status;
    data['description'] = description;
    data['brand'] = brand;
    data['model'] = model;
    data['year'] = year;
    data['createdAt'] = createdAt;
    if (services != null) {
      data['Services'] = services!.map((v) => v.toJson()).toList();
    }
    data['OtherServices'] = otherServices;
    if (mechanic != null) {
      data['mechanic'] = mechanic!.toJson();
    }
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class Services {
  String? name;
  String? description;

  Services({this.name, this.description});

  Services.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['description'] = description;
    return data;
  }
}

class Mechanic {
  String? id;
  String? firstname;
  String? lastname;

  Mechanic({this.id, this.firstname, this.lastname});

  Mechanic.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['firstname'] = firstname;
    data['lastname'] = lastname;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    return data;
  }
}