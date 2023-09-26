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

	BookingModel({this.id, this.status, this.date, this.brand, this.model, this.year, this.mechanic, this.user, this.responses, this.quotes});

	BookingModel.fromJson(Map<String, dynamic> json) {
		id = json['id'];
		status = json['status'];
		date = json['date'];
		brand = json['brand'];
		model = json['model'];
		year = json['year'];
		mechanic = json['mechanic'] != null ? new Mechanic.fromJson(json['mechanic']) : null;
		user = json['user'] != null ? new User.fromJson(json['user']) : null;
		if (json['responses'] != null) {
			responses = <Responses>[];
			json['responses'].forEach((v) { responses!.add(new Responses.fromJson(v)); });
		}
		if (json['quotes'] != null) {
			quotes = <Quotes>[];
			json['quotes'].forEach((v) { quotes!.add(new Quotes.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = this.id;
		data['status'] = this.status;
		data['date'] = this.date;
		data['brand'] = this.brand;
		data['model'] = this.model;
		data['year'] = this.year;
		if (this.mechanic != null) {
      data['mechanic'] = this.mechanic!.toJson();
    }
		if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
		if (this.responses != null) {
      data['responses'] = this.responses!.map((v) => v.toJson()).toList();
    }
		if (this.quotes != null) {
      data['quotes'] = this.quotes!.map((v) => v.toJson()).toList();
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
		data['id'] = this.id;
		data['firstname'] = this.firstname;
		data['lastname'] = this.lastname;
		return data;
	}
}

class User {
	String? id;
	String? username;
	String? address;
	String? city;
	String? lga;
	String? state;
	String? longitude;
	String? latitude;

	User({this.id, this.username, this.address, this.city, this.lga, this.state, this.longitude, this.latitude});

	User.fromJson(Map<String, dynamic> json) {
		id = json['id'];
		username = json['username'];
		address = json['address'];
		city = json['city'];
		lga = json['lga'];
		state = json['state'];
		longitude = json['longitude'];
		latitude = json['latitude'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = this.id;
		data['username'] = this.username;
		data['address'] = this.address;
		data['city'] = this.city;
		data['lga'] = this.lga;
		data['state'] = this.state;
		data['longitude'] = this.longitude;
		data['latitude'] = this.latitude;
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
		data['previousResponse'] = this.previousResponse;
		data['response'] = this.response;
		data['owner'] = this.owner;
		return data;
	}
}

class Quotes {
	String? id;
	int? price;
	String? message;
	RequestedSystemService? requestedSystemService;
	RequestedPersonalisedService? requestedPersonalisedService;

	Quotes({this.id, this.price, this.message, this.requestedSystemService, this.requestedPersonalisedService});

	Quotes.fromJson(Map<String, dynamic> json) {
		id = json['id'];
		price = json['price'];
		message = json['message'];
		requestedSystemService = json['requestedSystemService'] != null ? new RequestedSystemService.fromJson(json['requestedSystemService']) : null;
		requestedPersonalisedService = json['requestedPersonalisedService'] != null ? new RequestedPersonalisedService.fromJson(json['requestedPersonalisedService']) : null;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = this.id;
		data['price'] = this.price;
		data['message'] = this.message;
		if (this.requestedSystemService != null) {
      data['requestedSystemService'] = this.requestedSystemService!.toJson();
    }
		if (this.requestedPersonalisedService != null) {
      data['requestedPersonalisedService'] = this.requestedPersonalisedService!.toJson();
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
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['name'] = this.name;
		data['description'] = this.description;
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
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['name'] = this.name;
		data['description'] = this.description;
		return data;
	}
}