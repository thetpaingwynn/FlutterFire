// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map json) {
  return User(
    id: json['id'] as String,
    name: json['name'] as String,
    role:
        json['role'] == null ? null : UserRole.fromJson(json['role'] as String),
    email: json['email'] as String,
    password: json['password'] as String,
    imageUrl: json['imageUrl'] as String,
    createdBy: json['createdBy'] as String,
    createdDate: json['createdDate'] == null
        ? null
        : DateTime.parse(json['createdDate'] as String),
    updatedBy: json['updatedBy'] as String,
    updatedDate: json['updatedDate'] == null
        ? null
        : DateTime.parse(json['updatedDate'] as String),
  )..type = json['type'] as String;
}

Map<String, dynamic> _$UserToJson(User instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('type', instance.type);
  writeNotNull('createdBy', instance.createdBy);
  writeNotNull('createdDate', instance.createdDate?.toIso8601String());
  writeNotNull('updatedBy', instance.updatedBy);
  writeNotNull('updatedDate', instance.updatedDate?.toIso8601String());
  writeNotNull('name', instance.name);
  writeNotNull('role', instance.role?.toJson());
  val['imageUrl'] = instance.imageUrl;
  writeNotNull('email', instance.email);
  writeNotNull('password', instance.password);
  return val;
}
