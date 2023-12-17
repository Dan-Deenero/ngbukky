class PaymentResponse {
  String? message;
  String? title;
  bool? status;
  PaymentResponse({this.title, this.message, this.status});

  static PaymentResponse toApiResponse(Map<String, dynamic> response) {
    return PaymentResponse(
        title: response['data'],
        message: response['message'],
        status: response['status']);
  }
}

class SuccessResponse {
  bool? status;
  String? message;
  dynamic data;

  SuccessResponse({this.message, this.status, this.data});
  static SuccessResponse toApiResponse(Map<String, dynamic> response) {
    return SuccessResponse(
        data: response['data'],
        message: response['message'],
        status: response['status']);
  }
}
