import 'package:flutter/material.dart';

import 'entity.dart';
import 'user_role.dart';

class User extends Entity {
  String name;
  UserRole role;
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
}
