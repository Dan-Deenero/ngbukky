class CityLGA {
  Data? data;
  MetaData? metaData;

  CityLGA({this.data, this.metaData});

  CityLGA.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    metaData =
        json['metaData'] != null ? MetaData.fromJson(json['metaData']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
  List<String>? cities;
  List<String>? lgas;

  Data({this.cities, this.lgas});

  Data.fromJson(Map<String, dynamic> json) {
    cities = json['cities'].cast<String>();
    lgas = json['lgas'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cities'] = cities;
    data['lgas'] = lgas;
    return data;
  }
}

class MetaData {
  States? state;
  int? cityCount;
  int? lgaCount;

  MetaData({this.state, this.cityCount, this.lgaCount});

  MetaData.fromJson(Map<String, dynamic> json) {
    state = json['state'] != null ? States.fromJson(json['state']) : null;
    cityCount = json['cityCount'];
    lgaCount = json['lgaCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (state != null) {
      data['state'] = state!.toJson();
    }
    data['cityCount'] = cityCount;
    data['lgaCount'] = lgaCount;
    return data;
  }
}

class States {
  int? id;
  String? slug;
  String? name;
  String? capital;

  States({this.id, this.slug, this.name, this.capital});

  States.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    slug = json['slug'];
    name = json['name'];
    capital = json['capital'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['slug'] = slug;
    data['name'] = name;
    data['capital'] = capital;
    return data;
  }
}
