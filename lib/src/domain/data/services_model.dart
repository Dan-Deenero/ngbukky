class MechanicServicesModel {
  List<SystemServices>? systemServices;
  List<String>? otherServices;

  MechanicServicesModel({this.systemServices, this.otherServices});

  MechanicServicesModel.fromJson(Map<String, dynamic> json) {
    if (json['systemServices'] != null) {
      systemServices = <SystemServices>[];
      json['systemServices'].forEach((v) {
        systemServices!.add(SystemServices.fromJson(v));
      });
    }
    otherServices = json['otherServices'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (systemServices != null) {
      data['systemServices'] = systemServices!.map((v) => v.toJson()).toList();
    }
    data['otherServices'] = otherServices;
    return data;
  }
}

class SystemServices {
  String? id;
  String? name;
  String? description;
  String? imageUrl;
  String? slug;

  SystemServices(
      {this.id, this.name, this.description, this.imageUrl, this.slug});

  SystemServices.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    imageUrl = json['imageUrl'];
    slug = json['slug'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['imageUrl'] = imageUrl;
    data['slug'] = slug;
    return data;
  }
}
