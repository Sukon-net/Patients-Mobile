class Validators {
  static bool isValidEmail(String email) {
    if (email.contains('..')) return false;
    return RegExp(
            r'^(?!\.)[A-Za-z0-9._%+-]{1,64}(?<!\.\.)@[A-Za-z0-9-]+(\.[A-Za-z0-9-]+)*\.[A-Za-z]{2,}$')
        .hasMatch(email);
  }

  //TODO edit isValidOtp function
  static bool isValidOtp(int otpCode) {
    if (otpCode == 1234) return true;
    return false;
  }
}
