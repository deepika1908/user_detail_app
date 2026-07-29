class Validators {
  Validators._();

  static String? name(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Name is required';
    }

    return null;
  }

  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }

    if (!value.endsWith('@gmail.com')) {
      return 'Enter a valid Gmail address';
    }

    return null;
  }

  static String? phone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }

    if (value.length != 10) {
      return 'Phone number must be 10 digits';
    }

    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'Only numbers are allowed';
    }

    return null;
  }

  static String? otp(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter OTP';
    }

    if (value.length != 6) {
      return 'OTP must be 6 digits';
    }

    return null;
  }

  static String? dob(String? value) {
    if (value == null || value.isEmpty) {
      return 'Select Date of Birth';
    }

    return null;
  }
}