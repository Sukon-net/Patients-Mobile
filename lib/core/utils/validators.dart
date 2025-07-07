class Validators {
  static bool isValidEmail(String email) {
    if (email.contains('..')) return false;
    return RegExp(
            r'^(?!\.)[A-Za-z0-9._%+-]{1,64}(?<!\.\.)@[A-Za-z0-9-]+(\.[A-Za-z0-9-]+)*\.[A-Za-z]{2,}$')
        .hasMatch(email);
  }

  static bool isValidName(String name) => name.length >= 3;

  static bool isValidComplain(String complain) => complain.length >= 5;
}
