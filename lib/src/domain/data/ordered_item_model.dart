class OrderedItem {
  String? id;
  String? status;
  int? quantity;
  int? price;
  int? subtotal;
  String? createdAt;
  Product? product;
  Order? order;

  OrderedItem(
      {this.id,
      this.status,
      this.quantity,
      this.price,
      this.subtotal,
      this.createdAt,
      this.product,
      this.order});

  OrderedItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    quantity = json['quantity'];
    price = json['price'];
    subtotal = json['subtotal'];
    createdAt = json['createdAt'];
    product =
        json['product'] != null ? Product.fromJson(json['product']) : null;
    order = json['order'] != null ? Order.fromJson(json['order']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['status'] = status;
    data['quantity'] = quantity;
    data['price'] = price;
    data['subtotal'] = subtotal;
    data['createdAt'] = createdAt;
    if (product != null) {
      data['product'] = product!.toJson();
    }
    if (order != null) {
      data['order'] = order!.toJson();
    }
    return data;
  }
}

class Product {
  String? id;
  String? name;
  String? description;
  String? imageUrl;
  Specifications? specifications;
  int? price;
  int? discount;
  int? finalPrice;

  Product(
      {this.id,
      this.name,
      this.description,
      this.imageUrl,
      this.specifications,
      this.price,
      this.discount,
      this.finalPrice});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    imageUrl = json['imageUrl'];
    specifications = json['specifications'] != null
        ? Specifications.fromJson(json['specifications'])
        : null;
    price = json['price'];
    discount = json['discount'];
    finalPrice = json['finalPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['imageUrl'] = imageUrl;
    if (specifications != null) {
      data['specifications'] = specifications!.toJson();
    }
    data['price'] = price;
    data['discount'] = discount;
    data['finalPrice'] = finalPrice;
    return data;
  }
}

class Specifications {

  String? color;
  String? width; 
  String? placement;
  String? weight;
  String? length;
  String? height;
  String? volume;
  dynamic countryOfProducton;
  String? modelNumber;

  Specifications({
    this.color,
    this.width,
    this.placement,
    this.weight,
    this.length,
    this.height,
    this.volume,
    this.countryOfProducton,
    this.modelNumber,
  });

  Specifications.fromJson(Map<String, dynamic> json){
    color = json['color'];
    width = json['width'];
    placement = json['placement']; 
    weight = json['weight'];
    length = json['length'];
    height = json['height'];
    volume = json['volume'];
    countryOfProducton = json['countryOfProducton'];
    modelNumber = json['modelNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['color'] = color;
    data['width'] = width;
    data['placement'] = placement;
    data['weight'] = weight; 
    data['length'] = length;
    data['height'] = height;
    data['volume'] = volume;
    data['countryOfProducton'] = countryOfProducton; 
    data['modelNumber'] = modelNumber;
    return data;
  }

}

class Order {
  String? id;
  String? deliveryMethod;
  String? address;
  String? city;
  String? lga;
  String? state;
  User? user;

  Order(
      {this.id,
      this.deliveryMethod,
      this.address,
      this.city,
      this.lga,
      this.state,
      this.user});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    deliveryMethod = json['deliveryMethod'];
    address = json['address'];
    city = json['city'];
    lga = json['lga'];
    state = json['state'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['deliveryMethod'] = deliveryMethod;
    data['address'] = address;
    data['city'] = city;
    data['lga'] = lga;
    data['state'] = state;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  String? id;
  String? username;
  String? profileImageUrl;

  User({this.id, this.username, this.profileImageUrl});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    profileImageUrl = json['profileImageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['username'] = username;
    data['profileImageUrl'] = profileImageUrl;
    return data;
  }
}