import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

@freezed
class User with _$User {
  const factory User({
    int? id,
    String? firstName,
    String? lastName,
    String? dateOfBirth,
    String? gender,
    String? email,
    String? password,
    List<int>? imagePath,
  }) = _User;

  factory User.fromJSON(Map<String, dynamic> json) {
    Uint8List? image = json["imagePath"];
    return User(
      firstName: json["firstName"],
      lastName: json["lastName"],
      gender: json["gender"],
      email: json["email"],
      dateOfBirth: json["dateOfBirth"],
      id: json["id"],
      imagePath: image?.toList(),
    );
  }
}
