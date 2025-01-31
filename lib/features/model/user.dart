class User {
  final String firstName;
  final String lastName;
  final String email;
  final Gender gender;
  final String phoneNum;
  final String age;
  final DateTime dateOfBirth;
  final bool isActive;
  final bool isEmailVerified;
  final bool hasCompletedSignup;

  User({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.gender,
    required this.phoneNum,
    required this.age,
    required this.dateOfBirth,
    required this.isActive,
    required this.hasCompletedSignup,
    required this.isEmailVerified,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'gender': gender,
      'phoneNum': phoneNum,
      'age': age,
      'dateOfBirth': dateOfBirth,
      'isActive': isActive,
      'hasCompletedSignup': hasCompletedSignup,
      'isEmailVerified': isEmailVerified,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      email: map['email'] as String,
      gender: map['gender'] as Gender,
      phoneNum: map['phoneNum'] as String,
      age: map['age'] as String,
      dateOfBirth: map['dateOfBirth'] as DateTime,
      isActive: map['isActive'] as bool,
      hasCompletedSignup: map['hasCompletedSignup'] as bool,
      isEmailVerified: map['isEmailVerified'] as bool,
    );
  }
}

enum Gender { male, female }
