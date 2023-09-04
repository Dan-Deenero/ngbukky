class StatisticsModel {
  int? pENDING;
  int? aCCEPTED;
  int? rEJECTED;
  int? bARGAINING;
  int? aPPROVED;
  int? dISAPPROVED;
  int? aWAITINGPAYMENT;
  int? dECLINED;
  int? cOMPLETED;

  StatisticsModel(
      {this.pENDING,
      this.aCCEPTED,
      this.rEJECTED,
      this.bARGAINING,
      this.aPPROVED,
      this.dISAPPROVED,
      this.aWAITINGPAYMENT,
      this.dECLINED,
      this.cOMPLETED});

  StatisticsModel.fromJson(Map<String, dynamic> json) {
    pENDING = json['PENDING'];
    aCCEPTED = json['ACCEPTED'];
    rEJECTED = json['REJECTED'];
    bARGAINING = json['BARGAINING'];
    aPPROVED = json['APPROVED'];
    dISAPPROVED = json['DISAPPROVED'];
    aWAITINGPAYMENT = json['AWAITING_PAYMENT'];
    dECLINED = json['DECLINED'];
    cOMPLETED = json['COMPLETED'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PENDING'] = this.pENDING;
    data['ACCEPTED'] = this.aCCEPTED;
    data['REJECTED'] = this.rEJECTED;
    data['BARGAINING'] = this.bARGAINING;
    data['APPROVED'] = this.aPPROVED;
    data['DISAPPROVED'] = this.dISAPPROVED;
    data['AWAITING_PAYMENT'] = this.aWAITINGPAYMENT;
    data['DECLINED'] = this.dECLINED;
    data['COMPLETED'] = this.cOMPLETED;
    return data;
  }
}