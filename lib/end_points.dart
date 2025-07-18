class EndPoints {
  static const String endPointsPrefix = "http://10.10.25.148:3000";
  static const String wsPrefix = "ws://10.10.25.148:3000";
  // Auth endpoints
  static const String signup = "$endPointsPrefix/api/auth/signup";
  static const String login = "$endPointsPrefix/api/auth/login";
  static const String oAuthLogin = "$endPointsPrefix/api/auth/oauth-login";
  static const String verifyAccount =
      "$endPointsPrefix/api/auth/verify-account";
  static const String requestResetPassword =
      "$endPointsPrefix/api/auth/request-reset-password";
  static const String verifyResetPasswordOtp =
      "$endPointsPrefix/api/auth/verify-reset-password-otp";
  static const String changePassword =
      "$endPointsPrefix/api/auth/change-password";
  static const String sendAccountVerifOtp =
      "$endPointsPrefix/api/auth/send-verify-account-otp";

  // User endpoints
  static const String currentUser = "$endPointsPrefix/api/user/current-user";
  static const String updateUserInfo = "$endPointsPrefix/api/user/profile";
  static const String uploaadUserProfile =
      "$endPointsPrefix/api/user/upload-profile-picture";

  // Membership endpoints
  static const String currentMembership =
      "$endPointsPrefix/api/membership/current-user-membership";

  // Gym endpoints
  static const String getAllGyms = "$endPointsPrefix/api/gym";
  static const String getGymImage = "$endPointsPrefix/api/gym/image";
  static const String singleGym = "$endPointsPrefix/api/gym";
  static const String topGyms = "$endPointsPrefix/api/gym/top-gyms";
  static const String getAvailbleGymCities =
      "$endPointsPrefix/api/gym/available-gym-cities";
  static const String getAvailableCoaches =
      "$endPointsPrefix/api/gym/:gymId/available-coaches";
  static const String coachAvailableTimes =
      "$endPointsPrefix/api/coach/available-times/:coachId?date=:date";

  // Notification endpoints
  static const String getAllNotification =
      "$endPointsPrefix/api/notification/me";

  // Appointment endpoints
  static const String getUserappointment =
      "$endPointsPrefix/api/appointment/user-appointments";
  static const String makeAppointment = "$endPointsPrefix/api/appointment";
  static const String getCoachAvailableSlots =
      "$endPointsPrefix/api/coach/available-times/:coachId";

  // Collective sessions endpoints
  static const String getRecentCollectiveSessions =
      "$endPointsPrefix/api/collective-session/:gymId/recent";

  // Misc
  static const String test = "$endPointsPrefix/test";

  //FCM
  static const String addFcm = "$endPointsPrefix/api/push-notification/add-fcm";
}
