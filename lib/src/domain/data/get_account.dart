// ignore_for_file: unnecessary_new, prefer_collection_literals

class GetAccount {
  String? bankName;
  String? accountNumber;
  String? bankCode;

  GetAccount({this.bankName, this.accountNumber, this.bankCode});

  GetAccount.fromJson(Map<String, dynamic> json) {
    bankName = json['bankName'];
    accountNumber = json['accountNumber'];
    bankCode = json['bankCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bankName'] = bankName;
    data['accountNumber'] = accountNumber;
    data['bankCode'] = bankCode;
    return data;
  }
}