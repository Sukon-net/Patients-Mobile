class User {
  final String firstName;
  final String lastName;
  final String email;
  final Gender gender;
  final String phoneNum;
  final String password;
  final String confirmPassword;

  User({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.gender,
    required this.phoneNum,
    required this.password,
    required this.confirmPassword,
  });
}

enum Gender { male, female }