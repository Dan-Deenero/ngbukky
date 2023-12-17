class BookingModel {
  String? id;
  String? status;
  String? date;
  String? brand;
  String? model;
  int? year;
  Mechanic? mechanic;
  User? user;
  List<Responses>? responses;
  List<Quotes>? quotes;

  BookingModel(
      {this.id,
      this.status,
      this.date,
      this.brand,
      this.model,
      this.year,
      this.mechanic,
      this.user,
      this.responses,
      this.quotes});

  BookingModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    date = json['date'];
    brand = json['brand'];
    model = json['model'];
    year = json['year'];
    mechanic =
        json['mechanic'] != null ? Mechanic.fromJson(json['mechanic']) : null;
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    if (json['responses'] != null) {
      responses = <Responses>[];
      json['responses'].forEach((v) {
        responses!.add(Responses.fromJson(v));
      });
    }
    if (json['quotes'] != null) {
      quotes = <Quotes>[];
      json['quotes'].forEach((v) {
        quotes!.add(Quotes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['status'] = status;
    data['date'] = date;
    data['brand'] = brand;
    data['model'] = model;
    data['year'] = year;
    if (mechanic != null) {
      data['mechanic'] = mechanic!.toJson();
    }
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (responses != null) {
      data['responses'] = responses!.map((v) => v.toJson()).toList();
    }
    if (quotes != null) {
      data['quotes'] = quotes!.map((v) => v.toJson()).toList();
    }
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
  String? address;
  String? city;
  String? profileImageUrl;
  String? lga;
  String? state;
  String? longitude;
  String? latitude;

  User({
    this.id,
    this.username,
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
    address = json['address'];
    city = json['city'];
    lga = json['lga'];
    profileImageUrl = json['profileImageUrl'];
    state = json['state'];
    longitude = json['longitude'];
    latitude = json['latitude'];
  }

  Map<String, dynamic> toJson() {
    // ignore: prefer_collection_literals
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['username'] = username;
    data['address'] = address;
    data['city'] = city;
    data['lga'] = lga;
    data['profileImageUrl'] = profileImageUrl;
    data['state'] = state;
    data['longitude'] = longitude;
    data['latitude'] = latitude;
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

class Quotes {
  String? id;
  int? price;
  String? message;
  RequestedSystemService? requestedSystemService;
  RequestedPersonalisedService? requestedPersonalisedService;

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
        ? RequestedSystemService.fromJson(json['requestedSystemService'])
        : null;
    requestedPersonalisedService = json['requestedPersonalisedService'] != null
        ? RequestedPersonalisedService.fromJson(
            json['requestedPersonalisedService'])
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

class RequestedSystemService {
  String? name;
  String? description;

  RequestedSystemService({this.name, this.description});

  RequestedSystemService.fromJson(Map<String, dynamic> json) {
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

class RequestedPersonalisedService {
  String? name;
  String? description;

  RequestedPersonalisedService({this.name, this.description});

  RequestedPersonalisedService.fromJson(Map<String, dynamic> json) {
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
