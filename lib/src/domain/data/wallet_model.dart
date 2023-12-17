class WalletModel {
  String? id;
  String? userId;
  int? balance;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  Owner? owner;

  WalletModel(
      {this.id,
      this.userId,
      this.balance,
      this.deletedAt,
      this.createdAt,
      this.updatedAt,
      this.owner});

  WalletModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    balance = json['balance'];
    deletedAt = json['deletedAt'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    owner = json['owner'] != null ? Owner.fromJson(json['owner']) : null;
  }

  Map<String, dynamic> toJson() {
    // ignore: prefer_collection_literals
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['userId'] = userId;
    data['balance'] = balance;
    data['deletedAt'] = deletedAt;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (owner != null) {
      data['owner'] = owner!.toJson();
    }
    return data;
  }
}

class Owner {
  String? id;
  String? firstname;
  String? lastname;
  String? username;

  Owner({this.id, this.firstname, this.lastname, this.username});

  Owner.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    // ignore: prefer_collection_literals
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    data['username'] = username;
    return data;
  }
}