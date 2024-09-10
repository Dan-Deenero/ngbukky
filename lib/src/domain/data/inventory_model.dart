class InventoryModel {
  dynamic id;
  String? name;
  int? price;
  dynamic finalPrice;
  dynamic markup;
  String? imageUrl;
  String? description;
  int? discount;
  bool? isPublished;
  int? quantityInStock;
  String? slug;
  Specifications? specifications;
  Dealer? dealer;
  // List<String>? reviews;

  InventoryModel({
    this.id,
    this.name,
    this.price,
    this.finalPrice,
    this.imageUrl,
    this.description,
    this.slug,
    this.specifications,
    this.dealer,
    // this.reviews,
    this.markup,
    this.discount,
    this.isPublished,
    this.quantityInStock,
  });

  InventoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    finalPrice = json['finalPrice'];
    markup = json['markup'];
    imageUrl = json['imageUrl'];
    description = json['description'];
    slug = json['slug'];
    discount = json['discount'];
    isPublished = json['isPublished'];
    quantityInStock = json['quantityInStock'];
    specifications = json['specifications'] != null
        ? Specifications.fromJson(json['specifications'])
        : null;
    dealer = json['dealer'] != null ? Dealer.fromJson(json['dealer']) : null;
    // reviews = json['reviews'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['price'] = price;
    data['finalPrice'] = finalPrice;
    data['markup'] = markup;
    data['imageUrl'] = imageUrl;
    data['description'] = description;
    data['slug'] = slug;
    // data['reviews'] = reviews;
    data['discount'] = discount;
    data['isPublished'] = isPublished;
    data['quantityInStock'] = quantityInStock;
    if (specifications != null) {
      data['specifications'] = specifications!.toJson();
    }
    if (dealer != null) {
      data['dealer'] = dealer!.toJson();
    }
    return data;
  }
}

class Specifications {
  String? color;
  String? width;
  dynamic weight;
  String? length;
  String? height;
  String? volume;
  dynamic countryOfProducton;
  String? modelNumber;

  Specifications({
    this.color,
    this.width,
    this.weight,
    this.length,
    this.height,
    this.volume,
    this.countryOfProducton,
    this.modelNumber,
  });

  Specifications.fromJson(Map<String, dynamic> json) {
    color = json['color'];
    width = json['width'];
    weight = json['weight'];
    length = json['length'];
    height = json['height'];
    volume = json['volume'];
    countryOfProducton = json['countryOfProducton'];
    modelNumber = json['modelNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['color'] = color;
    data['width'] = width;
    data['weight'] = weight;
    data['length'] = length;
    data['height'] = height;
    data['volume'] = volume;
    data['countryOfProduction'] = countryOfProducton;
    data['modelNumber'] = modelNumber;
    return data;
  }
}

class Dealer {
  String? id;
  String? firstname;
  String? lastname;
  String? address;
  String? city;
  String? lga;
  String? state;
  String? businessName;

  Dealer(
      {this.id,
      this.firstname,
      this.lastname,
      this.address,
      this.city,
      this.lga,
      this.state,
      this.businessName});

  Dealer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    address = json['address'];
    city = json['city'];
    lga = json['lga'];
    state = json['state'];
    businessName = json['businessName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    data['address'] = address;
    data['city'] = city;
    data['lga'] = lga;
    data['state'] = state;
    data['businessName'] = businessName;
    return data;
  }
}
