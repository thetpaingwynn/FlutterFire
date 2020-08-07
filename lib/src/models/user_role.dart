import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(createFactory: false)
class UserRole {
  final String _name;
  final String _code;
  final String _displayName;
  const UserRole._(this._name, [this._code, this._displayName]);

  factory UserRole.fromJson(String value) => tryParse(value);
  String toJson() => this.value;

  @override
  String toString() => _name;
  String get value => _name;
  String get code => _code;
  String get displayName => _displayName ?? _name;

  static List<UserRole> getList() => [
        UserRole.Admin,
        UserRole.Supervisor,
        UserRole.User,
      ];

  static UserRole tryParse(String val) {
    switch (val.toUpperCase()) {
      case 'ADMIN':
        return UserRole.Admin;
      case 'SUPERVISOR':
        return UserRole.Supervisor;
      case 'USER':
        return UserRole.User;
      default:
        return null;
    }
  }

  static const UserRole Admin = UserRole._('Admin', 'A');
  static const UserRole Supervisor = UserRole._('Supervisor', 'S');
  static const UserRole User = UserRole._('User', 'D');
}
