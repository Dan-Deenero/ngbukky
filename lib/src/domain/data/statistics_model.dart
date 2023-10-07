class StatisticsModel {
  int? cANCELED;
  int? pENDING;
  int? aCCEPTED;
  int? rEJECTED;
  int? bARGAINING;
  int? aPPROVED;
  int? dISAPPROVED;
  int? aWAITINGPAYMENT;
  int? dECLINED;
  int? cOMPLETED;

  StatisticsModel({
    this.pENDING,
    this.aCCEPTED,
    this.rEJECTED,
    this.bARGAINING,
    this.aPPROVED,
    this.dISAPPROVED,
    this.aWAITINGPAYMENT,
    this.dECLINED,
    this.cOMPLETED,
    this.cANCELED,
  });

  StatisticsModel.fromJson(Map<String, dynamic> json) {

    cANCELED = json['CANCELED'];
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
    data['cANCELED'] = cANCELED;
    data['PENDING'] = pENDING;
    data['ACCEPTED'] = aCCEPTED;
    data['REJECTED'] = rEJECTED;
    data['BARGAINING'] = bARGAINING;
    data['APPROVED'] = aPPROVED;
    data['DISAPPROVED'] = dISAPPROVED;
    data['AWAITING_PAYMENT'] = aWAITINGPAYMENT;
    data['DECLINED'] = dECLINED;
    data['COMPLETED'] = cOMPLETED;
    return data;
  }
}
