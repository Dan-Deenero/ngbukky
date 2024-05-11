// ignore_for_file: prefer_collection_literals

class WalletModel{
  Wallet? wallet;
  Analytics? analytics;

  WalletModel({this.wallet, this.analytics});

  WalletModel.fromJson(Map<String, dynamic> json) {
    wallet =
        json['wallet'] != null ? Wallet.fromJson(json['wallet']) : null;
    analytics = json['analytics'] != null
        ? Analytics.fromJson(json['analytics'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (wallet != null) {
      data['wallet'] = wallet!.toJson();
    }
    if (analytics != null) {
      data['analytics'] = analytics!.toJson();
    }
    return data;
  }
}

class Wallet {
  int? balance;
  String? id;
  Owner? owner;

  Wallet({this.balance, this.id, this.owner});

  Wallet.fromJson(Map<String, dynamic> json) {
    balance = json['balance'];
    id = json['id'];
    owner = json['owner'] != null ? Owner.fromJson(json['owner']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['balance'] = balance;
    data['id'] = id;
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
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    data['username'] = username;
    return data;
  }
}

class Analytics {
  int? totalEarnedForTheYear;
  int? totalEarnedForTheMonth;
  int? totalWithdrawnThisMonth;

  Analytics(
      {this.totalEarnedForTheYear,
      this.totalEarnedForTheMonth,
      this.totalWithdrawnThisMonth});

  Analytics.fromJson(Map<String, dynamic> json) {
    totalEarnedForTheYear = json['totalEarnedForTheYear'];
    totalEarnedForTheMonth = json['totalEarnedForTheMonth'];
    totalWithdrawnThisMonth = json['totalWithdrawnThisMonth'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['totalEarnedForTheYear'] = totalEarnedForTheYear;
    data['totalEarnedForTheMonth'] = totalEarnedForTheMonth;
    data['totalWithdrawnThisMonth'] = totalWithdrawnThisMonth;
    return data;
  }
}