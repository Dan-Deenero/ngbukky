import 'package:ngbuka/src/domain/data/orders_model.dart';

class DashboardModel {
  int? ongoingOrdersCount;
  int? completedOrdersCount;
  int? returnedOrdersCount;
  List<OrdersModel>? incomingOrders;
  List<ProductsLowInStock>? productsLowInStock;
  List<TopSellers>? topSellers;

  DashboardModel(
      {this.ongoingOrdersCount,
      this.completedOrdersCount,
      this.returnedOrdersCount,
      this.incomingOrders,
      this.productsLowInStock,
      this.topSellers});

  DashboardModel.fromJson(Map<String, dynamic> json) {
    ongoingOrdersCount = json['ongoingOrdersCount'];
    completedOrdersCount = json['completedOrdersCount'];
    returnedOrdersCount = json['returnedOrdersCount'];
    if (json['incomingOrders'] != null) {
      incomingOrders = <OrdersModel>[];
      json['incomingOrders'].forEach((v) {
        incomingOrders!.add(OrdersModel.fromJson(v));
      });
    }
    if (json['productsLowInStock'] != null) {
      productsLowInStock = <ProductsLowInStock>[];
      json['productsLowInStock'].forEach((v) {
        productsLowInStock!.add(ProductsLowInStock.fromJson(v));
      });
    }
    if (json['topSellers'] != null) {
      topSellers = <TopSellers>[];
      json['topSellers'].forEach((v) {
        topSellers!.add(TopSellers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['ongoingOrdersCount'] = ongoingOrdersCount;
    data['completedOrdersCount'] = completedOrdersCount;
    data['returnedOrdersCount'] = returnedOrdersCount;
    if (incomingOrders != null) {
      data['incomingOrders'] =
          incomingOrders!.map((v) => v.toJson()).toList();
    }
    if (productsLowInStock != null) {
      data['productsLowInStock'] =
          productsLowInStock!.map((v) => v.toJson()).toList();
    }
    if (topSellers != null) {
      data['topSellers'] = topSellers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductsLowInStock {
  String? id;
  String? name;
  int? price;
  int? discount;
  int? markup;
  int? finalPrice;
  int? quantityInStock;
  bool? isPublished;
  String? imageUrl;
  String? description;
  String? dealerId;
  String? slug;
  Specifications? specifications;
  String? createdAt;

  ProductsLowInStock(
      {this.id,
      this.name,
      this.price,
      this.discount,
      this.markup,
      this.finalPrice,
      this.quantityInStock,
      this.isPublished,
      this.imageUrl,
      this.description,
      this.dealerId,
      this.slug,
      this.specifications,
      this.createdAt});

  ProductsLowInStock.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    discount = json['discount'];
    markup = json['markup'];
    finalPrice = json['finalPrice'];
    quantityInStock = json['quantityInStock'];
    isPublished = json['isPublished'];
    imageUrl = json['imageUrl'];
    description = json['description'];
    dealerId = json['dealerId'];
    slug = json['slug'];
    specifications = json['specifications'] != null
        ? Specifications.fromJson(json['specifications'])
        : null;
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['price'] = price;
    data['discount'] = discount;
    data['markup'] = markup;
    data['finalPrice'] = finalPrice;
    data['quantityInStock'] = quantityInStock;
    data['isPublished'] = isPublished;
    data['imageUrl'] = imageUrl;
    data['description'] = description;
    data['dealerId'] = dealerId;
    data['slug'] = slug;
    if (specifications != null) {
      data['specifications'] = specifications!.toJson();
    }
    data['createdAt'] = createdAt;
    return data;
  }
}

class Specifications {
  String? color;
  String? width;
  String? placement;

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

class TopSellers {
  String? id;
  String? name;
  String? imageUrl;
  String? description;
  int? finalPrice;
  int? quantityInStock;
  String? createdAt;

  TopSellers(
      {this.id,
      this.name,
      this.imageUrl,
      this.description,
      this.finalPrice,
      this.quantityInStock,
      this.createdAt});

  TopSellers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imageUrl = json['imageUrl'];
    description = json['description'];
    finalPrice = json['finalPrice'];
    quantityInStock = json['quantityInStock'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['imageUrl'] = imageUrl;
    data['description'] = description;
    data['finalPrice'] = finalPrice;
    data['quantityInStock'] = quantityInStock;
    data['createdAt'] = createdAt;
    return data;
  }
}