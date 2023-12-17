class AccountName {
  String? accountNumber;
  String? accountName;

  AccountName({
    this.accountNumber,
    this.accountName,
  });

  AccountName.fromJson(Map<String, dynamic> json) {
    accountNumber = json['account_number'];
    accountName = json['account_name'];
  }

  Map<String, dynamic> toJson() {
    // ignore: prefer_collection_literals
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['account_number'] = accountNumber;
    data['account_name'] = accountName;
    return data;
  }
}