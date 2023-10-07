class QuotesModel {
  String? id;
  String? status;
  String? description;
  String? brand;
  String? model;
  int? year;
  String? createdAt;
  List<Services>? services;
  List<OtherServices>? otherServices;
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
      otherServices = <OtherServices>[];
      json['OtherServices'].forEach((v) {
        otherServices!.add(OtherServices.fromJson(v));
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
    mechanic = json['mechanic'] != null
        ? Mechanic.fromJson(json['mechanic'])
        : null;
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
      data['OtherServices'] =
          otherServices!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = name;
    data['description'] = description;
    return data;
  }
}

class OtherServices {
  String? name;
  String? description;

  OtherServices({this.name, this.description});

  OtherServices.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = name;
    data['description'] = description;
    return data;
  }
}

class Quotes {
  String? id;
  int? price;
  String? message;
  Services? requestedSystemService;
  OtherServices? requestedPersonalisedService;

  Quotes(
      {this.id,
      this.price,
      this.message,
      this.requestedSystemService,
      this.requestedPersonalisedService});

  Quotes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    message = json['message'];
    requestedSystemService = json['requestedSystemService'] != null
        ? Services.fromJson(json['requestedSystemService'])
        : null;
    requestedPersonalisedService = json['requestedPersonalisedService'] != null
        ? OtherServices.fromJson(json['requestedPersonalisedService'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['price'] = price;
    data['message'] = message;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['username'] = username;
    return data;
  }
}