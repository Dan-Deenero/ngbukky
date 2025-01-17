class Account {
  int? id;
  String? name;
  String? accountName;
  String? slug;
  String? code;
  String? longcode;
  String? gateway;
  bool? payWithBank;
  bool? active;
  String? country;
  String? currency;
  String? type;
  bool? isDeleted;
  String? createdAt;
  String? updatedAt;

  Account(
      {this.id,
      this.name,
      this.accountName,
      this.slug,
      this.code,
      this.longcode,
      this.gateway,
      this.payWithBank,
      this.active,
      this.country,
      this.currency,
      this.type,
      this.isDeleted,
      this.createdAt,
      this.updatedAt});

  Account.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    accountName = json['accountName'];
    slug = json['slug'];
    code = json['code'];
    longcode = json['longcode'];
    gateway = json['gateway'];
    payWithBank = json['pay_with_bank'];
    active = json['active'];
    country = json['country'];
    currency = json['currency'];
    type = json['type'];
    isDeleted = json['is_deleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    // ignore: prefer_collection_literals
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['accountName'] = accountName;
    data['slug'] = slug;
    data['code'] = code;
    data['longcode'] = longcode;
    data['gateway'] = gateway;
    data['pay_with_bank'] = payWithBank;
    data['active'] = active;
    data['country'] = country;
    data['currency'] = currency;
    data['type'] = type;
    data['is_deleted'] = isDeleted;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}