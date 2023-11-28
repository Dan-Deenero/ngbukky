class OrdersModel {
  String? status;
  int? quantity;
  String? id;
  String? createdAt;
  Product? product;
  Order? order;

  OrdersModel(
      {this.status,
      this.quantity,
      this.id,
      this.product,
      this.order,
      this.createdAt});

  OrdersModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    quantity = json['quantity'];
    id = json['id'];
    createdAt = json['createdAt'];
    product =
        json['product'] != null ? Product.fromJson(json['product']) : null;
    order = json['order'] != null ? Order.fromJson(json['order']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = status;
    data['quantity'] = quantity;
    data['id'] = id;
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
  String? name;
  String? description;
  String? imageUrl;
  Specifications? specifications;
  int? quantityInStock;
  int? price;
  int? discount;

  Product({
    this.name,
    this.description,
    this.imageUrl,
    this.specifications,
    this.price,
    this.discount,
    this.quantityInStock,
  });

  Product.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    imageUrl = json['imageUrl'];
    specifications = json['specifications'] != null
        ? Specifications.fromJson(json['specifications'])
        : null;
    quantityInStock = json['quantityInStock'];
    price = json['price'];
    discount = json['discount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = name;
    data['description'] = description;
    data['imageUrl'] = imageUrl;
    if (specifications != null) {
      data['specifications'] = specifications!.toJson();
    }
    data['quantityInStock'] = quantityInStock;
    data['price'] = price;
    data['discount'] = discount;
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
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['color'] = color;
    data['width'] = width;
    data['placement'] = placement;
    return data;
  }
}

class Order {
  String? deliveryMethod;
  String? address;
  String? city;
  String? lga;
  String? state;
  User? user;

  Order(
      {this.deliveryMethod,
      this.address,
      this.city,
      this.lga,
      this.state,
      this.user});

  Order.fromJson(Map<String, dynamic> json) {
    deliveryMethod = json['deliveryMethod'];
    address = json['address'];
    city = json['city'];
    lga = json['lga'];
    state = json['state'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
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
  String? deviceToken;
  String? email;

  User({this.id, this.username, this.deviceToken, this.email});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    deviceToken = json['deviceToken'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['username'] = username;
    data['deviceToken'] = deviceToken;
    data['email'] = email;
    return data;
  }
}
