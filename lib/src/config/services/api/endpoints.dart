class Endpoints {
  static const String baseURL = "http://23.234.211.147/api/v1/";
  static const String register = "auth/register";
  static const String login = "auth/login";
  static const String verifyOTP = "auth/verify";
  static const String resetPassword = "auth/reset-password";
  static const String resetOTPVerify = "auth/reset-password/verify";
  static const String resendOTP = "/auth/resend";
  static const String newPasword = "auth/password/reset";
  static const String getProfileMechanic = 'mechanic/profile';
  static const String getMechanicServices = 'services';
  static const String getLocation = 'location/sub-domains';
  static const String updateBusiness = 'mechanic/business-profile';
  static const String getStatisticsInfo = 'mechanic/summary?type=quote-request';
}
