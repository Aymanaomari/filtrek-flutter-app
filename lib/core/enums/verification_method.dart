/// Enum for verification methods
enum VerificationMethod {
  email,
  sms,
  none; // Default when no method is selected yet

  String get displayName {
    switch (this) {
      case VerificationMethod.email:
        return 'Email';
      case VerificationMethod.sms:
        return 'SMS';
      case VerificationMethod.none:
        return 'None';
    }
  }

  /// Convert from string to enum (useful for parsing from API responses)
  static VerificationMethod fromString(String value) {
    switch (value.toLowerCase()) {
      case 'email':
        return VerificationMethod.email;
      case 'sms':
      case 'phone':
        return VerificationMethod.sms;
      default:
        return VerificationMethod.none;
    }
  }

  /// Convert enum to string (useful for API requests)
  String toApiString() {
    switch (this) {
      case VerificationMethod.email:
        return 'email';
      case VerificationMethod.sms:
        return 'sms';
      case VerificationMethod.none:
        return 'none';
    }
  }
}
