class ApiResponse {
  String? message;
  String? title;
  int? status;
  ApiResponse({this.title, this.message, this.status});

  static ApiResponse toApiResponse(Map<String, dynamic> response) {
    return ApiResponse(
        title: response['data'],
        message: response['message'],
        status: response['status']);
  }
}

class SuccessResponse {
  int? status;
  String? message;
  dynamic entity;

  SuccessResponse({this.message, this.status, this.entity});
  static SuccessResponse toApiResponse(Map<String, dynamic> response) {
    return SuccessResponse(
        entity: response['entity'],
        message: response['message'],
        status: response['status']);
  }
}
