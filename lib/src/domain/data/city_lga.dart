// ignore_for_file: prefer_collection_literals

class CityLGA {
	Data? data;
	MetaData? metaData;

	CityLGA({this.data, this.metaData});

	CityLGA.fromJson(Map<String, dynamic> json) {
		data = json['data'] != null ? Data.fromJson(json['data']) : null;
		metaData = json['metaData'] != null ? MetaData.fromJson(json['metaData']) : null;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = Map<String, dynamic>();
		if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
		if (metaData != null) {
      data['metaData'] = metaData!.toJson();
    }
		return data;
	}
}

class Data {
	List<Cities>? cities;
	List<Towns>? towns;

	Data({this.cities, this.towns});

	Data.fromJson(Map<String, dynamic> json) {
		if (json['cities'] != null) {
			cities = <Cities>[];
			json['cities'].forEach((v) { cities!.add(Cities.fromJson(v)); });
		}
		if (json['towns'] != null) {
			towns = <Towns>[];
			json['towns'].forEach((v) { towns!.add(Towns.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = Map<String, dynamic>();
		if (cities != null) {
      data['cities'] = cities!.map((v) => v.toJson()).toList();
    }
		if (towns != null) {
      data['towns'] = towns!.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class Cities {
	String? name;
	String? code;
	int? type;
	RegionMetadata? regionMetadata;
	String? slug;

	Cities({this.name, this.code, this.type, this.regionMetadata, this.slug});

	Cities.fromJson(Map<String, dynamic> json) {
		name = json['name'];
		code = json['code'];
		type = json['type'];
		regionMetadata = json['regionMetadata'] != null ? RegionMetadata.fromJson(json['regionMetadata']) : null;
		slug = json['slug'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = Map<String, dynamic>();
		data['name'] = name;
		data['code'] = code;
		data['type'] = type;
		if (regionMetadata != null) {
      data['regionMetadata'] = regionMetadata!.toJson();
    }
		data['slug'] = slug;
		return data;
	}
}

class RegionMetadata {
	String? regionCode;
	String? regionName;
	String? regionSlug;

	RegionMetadata({this.regionCode, this.regionName, this.regionSlug});

	RegionMetadata.fromJson(Map<String, dynamic> json) {
		regionCode = json['regionCode'];
		regionName = json['regionName'];
		regionSlug = json['regionSlug'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = Map<String, dynamic>();
		data['regionCode'] = regionCode;
		data['regionName'] = regionName;
		data['regionSlug'] = regionSlug;
		return data;
	}
}

class Towns {
	String? name;
	String? slug;
	String? code;
	CityMetadata? cityMetadata;
	RegionMetadata? regionMetadata;
	int? type;

	Towns({this.name, this.slug, this.code, this.cityMetadata, this.regionMetadata, this.type});

	Towns.fromJson(Map<String, dynamic> json) {
		name = json['name'];
		slug = json['slug'];
		code = json['code'];
		cityMetadata = json['cityMetadata'] != null ? CityMetadata.fromJson(json['cityMetadata']) : null;
		regionMetadata = json['regionMetadata'] != null ? RegionMetadata.fromJson(json['regionMetadata']) : null;
		type = json['type'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = Map<String, dynamic>();
		data['name'] = name;
		data['slug'] = slug;
		data['code'] = code;
		if (cityMetadata != null) {
      data['cityMetadata'] = cityMetadata!.toJson();
    }
		if (regionMetadata != null) {
      data['regionMetadata'] = regionMetadata!.toJson();
    }
		data['type'] = type;
		return data;
	}
}

class CityMetadata {
	String? cityCode;
	String? cityName;
	String? citySlug;

	CityMetadata({this.cityCode, this.cityName, this.citySlug});

	CityMetadata.fromJson(Map<String, dynamic> json) {
		cityCode = json['cityCode'];
		cityName = json['cityName'];
		citySlug = json['citySlug'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = Map<String, dynamic>();
		data['cityCode'] = cityCode;
		data['cityName'] = cityName;
		data['citySlug'] = citySlug;
		return data;
	}
}

class MetaData {
	States? state;
	int? townCount;
	int? cityCount;

	MetaData({this.state, this.townCount, this.cityCount});

	MetaData.fromJson(Map<String, dynamic> json) {
		state = json['state'] != null ? States.fromJson(json['state']) : null;
		townCount = json['townCount'];
		cityCount = json['cityCount'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = Map<String, dynamic>();
		if (state != null) {
      data['state'] = state!.toJson();
    }
		data['townCount'] = townCount;
		data['cityCount'] = cityCount;
		return data;
	}
}

class States {
	String? name;
	String? code;
	int? type;
	String? slug;

	States({this.name, this.code, this.type, this.slug});

	States.fromJson(Map<String, dynamic> json) {
		name = json['name'];
		code = json['code'];
		type = json['type'];
		slug = json['slug'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = Map<String, dynamic>();
		data['name'] = name;
		data['code'] = code;
		data['type'] = type;
		data['slug'] = slug;
		return data;
	}
}