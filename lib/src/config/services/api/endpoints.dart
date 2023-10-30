class Endpoints {
  static const String baseURL = "http://74.48.46.59/api/v1/";
  static const String register = "auth/register";
  static const String login = "auth/login";
  static const String logout = "auth/logout";
  static const String verifyOTP = "auth/verify";
  static const String resetPassword = "auth/reset-password";
  static const String resetOTPVerify = "auth/reset-password/verify";
  static const String resendOTP = "/auth/resend";
  static const String newPasword = "auth/password/reset";
  static const String updateToken = "auth/device-token";
  static const String mechanicProfileImage = "mechanic/profile/image";
  static const String getProfileMechanic = 'mechanic/profile';
  static const String getMechanicServices = 'services';
  static const String getLocation = 'location/sub-domains';
  static const String updateBusiness = 'mechanic/business-profile';
  static const String getStatisticsInfo = 'mechanic/summary';
  // static const String getBookingStatisticsInfo = 'mechanic/booking-summary';
  static const String getAllBooking = 'mechanic/bookings';
  static const String getAllQuotes = 'mechanic/quote-requests';
  static const String addPersonalizedService = '/mechanic/services/personal';
  static const String getAllNotifications = 'notifications/';
}
