import 'package:filtrek_app/app/environment_config.dart';

class EndPoints {
  static String endPointsPrefix = EnvironmentConfig.apiBaseUrlValue;
  static String wsPrefix = "ws://10.10.25.148:3000";
  // Auth endpoints
  static String signup = "$endPointsPrefix/api/auth/signup";
  static String login = "$endPointsPrefix/api/auth/login";
  static String oAuthLogin = "$endPointsPrefix/api/auth/oauth-login";
  static String verifyAccount = "$endPointsPrefix/api/auth/verify-account";
  static String requestResetPassword =
      "$endPointsPrefix/api/auth/request-reset-password";
  static String verifyResetPasswordOtp =
      "$endPointsPrefix/api/auth/verify-reset-password-otp";
  static String changePassword = "$endPointsPrefix/api/auth/change-password";
  static String sendAccountVerifOtp =
      "$endPointsPrefix/api/auth/send-verify-account-otp";

  // User endpoints
  static String currentUser = "$endPointsPrefix/api/user/current-user";
  static String updateUserInfo = "$endPointsPrefix/api/user/profile";
  static String uploaadUserProfile =
      "$endPointsPrefix/api/user/upload-profile-picture";

  // Membership endpoints
  static String currentMembership =
      "$endPointsPrefix/api/membership/current-user-membership";

  // Gym endpoints
  static String getAllGyms = "$endPointsPrefix/api/gym";
  static String getGymImage = "$endPointsPrefix/api/gym/image";
  static String singleGym = "$endPointsPrefix/api/gym";
  static String topGyms = "$endPointsPrefix/api/gym/top-gyms";
  static String getAvailbleGymCities =
      "$endPointsPrefix/api/gym/available-gym-cities";
  static String getAvailableCoaches =
      "$endPointsPrefix/api/gym/:gymId/available-coaches";
  static String coachAvailableTimes =
      "$endPointsPrefix/api/coach/available-times/:coachId?date=:date";

  // Notification endpoints
  static String getAllNotification = "$endPointsPrefix/api/notification/me";

  // Appointment endpoints
  static String getUserappointment =
      "$endPointsPrefix/api/appointment/user-appointments";
  static String makeAppointment = "$endPointsPrefix/api/appointment";
  static String getCoachAvailableSlots =
      "$endPointsPrefix/api/coach/available-times/:coachId";

  // Collective sessions endpoints
  static String getRecentCollectiveSessions =
      "$endPointsPrefix/api/collective-session/:gymId/recent";

  // Misc
  static String test = "$endPointsPrefix/test";

  //FCM
  static String addFcm = "$endPointsPrefix/api/push-notification/add-fcm";
}
