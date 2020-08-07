import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import 'entity.dart';
import 'user_role.dart';

part 'user.g.dart';

@JsonSerializable()
class User extends Entity {
  String name;
  UserRole role;
  @JsonKey(nullable: false)
  String imageUrl;
  String email;
  String password;

  User({
    @required String id,
    @required this.name,
    @required this.role,
    @required this.email,
    @required this.password,
    this.imageUrl,
    String createdBy,
    DateTime createdDate,
    String updatedBy,
    DateTime updatedDate,
  }) : super(id: id, createdBy: createdBy, createdDate: createdDate, updatedBy: updatedBy, updatedDate: updatedDate);

  @override
  Map<String, dynamic> toJson() => _$UserToJson(this);
  factory User.fromJson(Map json) => _$UserFromJson(json);
}
