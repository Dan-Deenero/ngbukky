class OrdersModel {
  String? status;
  int? quantity;
  int? subtotal;
  String? id;
  int? price;
  String? createdAt;
  Product? product;
  Order? order;

  OrdersModel(
      {this.status,
      this.quantity,
      this.id,
      this.price,
      this.product,
      this.subtotal,
      this.order,
      this.createdAt});

  OrdersModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    quantity = json['quantity'];
    id = json['id'];
    createdAt = json['createdAt'];
    price = json['price'];
    subtotal = json['subtotal'];
    product =
        json['product'] != null ? Product.fromJson(json['product']) : null;
    order = json['order'] != null ? Order.fromJson(json['order']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['quantity'] = quantity;
    data['id'] = id;
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
  int? quantityInStock;
  int? price;
  int? discount;
  int? finalPrice;

  Product({
    this.id,
    this.name,
    this.description,
    this.imageUrl,
    this.specifications,
    this.price,
    this.discount,
    this.quantityInStock,
    this.finalPrice,
  });

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    imageUrl = json['imageUrl'];
    specifications = json['specifications'] != null
        ? Specifications.fromJson(json['specifications'])
        : null;
    quantityInStock = json['quantityInStock'];
    price = json['price'];
    discount = json['discount'];
    finalPrice = json['finalPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['imageUrl'] = imageUrl;
    if (specifications != null) {
      data['specifications'] = specifications!.toJson();
    }
    data['quantityInStock'] = quantityInStock;
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

  Specifications({this.color, this.width, this.placement});

  Specifications.fromJson(Map<String, dynamic> json) {
    color = json['color'];
    width = json['width'];
    placement = json['placement'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['color'] = color;
    data['width'] = width;
    data['placement'] = placement;
    return data;
  }
}

class Order {
  String? id;
  String? deliveryMethod;
  String? address;
  String? city;
  String? town;
  String? state;
  User? user;

  Order({
    this.id,
    this.deliveryMethod,
    this.address,
    this.city,
    this.town,
    this.state,
    this.user,
  });

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    deliveryMethod = json['deliveryMethod'];
    address = json['address'];
    city = json['city'];
    town = json['town'];
    state = json['state'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['deliveryMethod'] = deliveryMethod;
    data['address'] = address;
    data['city'] = city;
    data['town'] = town;
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
  String? deviceToken;
  String? email;
  String? profileImageUrl;

  User({this.id, this.username, this.deviceToken, this.email, this.profileImageUrl});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    deviceToken = json['deviceToken'];
    email = json['email'];
    profileImageUrl = json['profileImageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['deviceToken'] = deviceToken;
    data['email'] = email;
    data['profileImageUrl'] = profileImageUrl;
    return data;
  }
}
