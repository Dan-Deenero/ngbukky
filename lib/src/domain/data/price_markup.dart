// ignore_for_file: unnecessary_this, unnecessary_new, prefer_collection_literals

class PriceMarkup {
  String? id;
  String? name;
  String? slug;
  String? description;
  dynamic value;
  bool? isActive;
  String? createdAt;
  String? updatedAt;

  PriceMarkup(
      {this.id,
      this.name,
      this.slug,
      this.description,
      this.value,
      this.isActive,
      this.createdAt,
      this.updatedAt});

  PriceMarkup.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    description = json['description'];
    value = json['value'];
    isActive = json['isActive'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['description'] = this.description;
    data['value'] = this.value;
    data['isActive'] = this.isActive;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}