// ignore_for_file: unnecessary_this, prefer_collection_literals

class QuotesModel {
  String? id;
  String? status;
  String? description;
  String? brand;
  String? model;
  int? year;
  String? createdAt;
  List<Services>? services;
  List<Services>? otherServices;
  List<Quotes>? quotes;
  List<Responses>? responses;
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
      this.quotes,
      this.responses,
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
    if (json['OtherServices'] != null) {
      otherServices = <Services>[];
      json['OtherServices'].forEach((v) {
        otherServices!.add(Services.fromJson(v));
      });
    }
    if (json['quotes'] != null) {
      quotes = <Quotes>[];
      json['quotes'].forEach((v) {
        quotes!.add(Quotes.fromJson(v));
      });
    }
    if (json['responses'] != null) {
      responses = <Responses>[];
      json['responses'].forEach((v) {
        responses!.add(Responses.fromJson(v));
      });
    }
    mechanic =
        json['mechanic'] != null ? Mechanic.fromJson(json['mechanic']) : null;
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
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
    if (otherServices != null) {
      data['OtherServices'] = otherServices!.map((v) => v.toJson()).toList();
    }
    if (quotes != null) {
      data['quotes'] = quotes!.map((v) => v.toJson()).toList();
    }
    if (responses != null) {
      data['responses'] = responses!.map((v) => v.toJson()).toList();
    }
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
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = name;
    data['description'] = description;
    return data;
  }
}


class Quotes {
  String? id;
  int? price;
  String? message;
  int? commission;
  Services? requestedSystemService;
  Services? requestedPersonalisedService;

  Quotes({
    this.id,
    this.price,
    this.message,
    this.commission,
    this.requestedSystemService,
    this.requestedPersonalisedService,
  });

  Quotes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    message = json['message'];
    commission = json['commission'];
    requestedSystemService = json['requestedSystemService'] != null
        ? Services.fromJson(json['requestedSystemService'])
        : null;
    requestedPersonalisedService = json['requestedPersonalisedService'] != null
        ? Services.fromJson(json['requestedPersonalisedService'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['price'] = price;
    data['message'] = message;
    data['commission'] = commission;
    if (requestedSystemService != null) {
      data['requestedSystemService'] = requestedSystemService!.toJson();
    }
    if (requestedPersonalisedService != null) {
      data['requestedPersonalisedService'] =
          requestedPersonalisedService!.toJson();
    }
    return data;
  }
}

class Responses {
  String? previousResponse;
  String? response;
  String? owner;

  Responses({this.previousResponse, this.response, this.owner});

  Responses.fromJson(Map<String, dynamic> json) {
    previousResponse = json['previousResponse'];
    response = json['response'];
    owner = json['owner'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['previousResponse'] = previousResponse;
    data['response'] = response;
    data['owner'] = owner;
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
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    return data;
  }
}

class User {
  String? id;
  String? username;
  String? email;
  String? address;
  String? profileImageUrl;
  String? city;
  String? lga;
  String? state;
  String? longitude;
  String? latitude;

  User({
    this.id,
    this.username,
    this.email,
    this.address,
    this.city,
    this.lga,
    this.state,
    this.longitude,
    this.latitude,
    this.profileImageUrl,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    address = json['address'];
    city = json['city'];
    lga = json['lga'];
    state = json['state'];
    longitude = json['longitude'];
    profileImageUrl = json['profileImageUrl'];
    latitude = json['latitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['email'] = this.email;
    data['address'] = this.address;
    data['city'] = this.city;
    data['lga'] = this.lga;
    data['profileImageUrl'] = profileImageUrl;
    data['state'] = this.state;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    return data;
  }
}
