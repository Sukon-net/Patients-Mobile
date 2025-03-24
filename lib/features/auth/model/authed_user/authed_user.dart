import 'package:clients/features/model/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'authed_user.g.dart';

@JsonSerializable()
class AuthedUser {
  final String token;
  final User user;

  AuthedUser({required this.token, required this.user});

  factory AuthedUser.fromJson(Map<String, dynamic> json) =>
      _$AuthedUserFromJson(json);

  Map<String, dynamic> toJson() => _$AuthedUserToJson(this);
}
