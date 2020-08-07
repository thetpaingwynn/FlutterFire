import '../models/entity.dart';
import '../models/user.dart';

String getCollection<T extends Entity>() {
  switch (T.toString()) {
    case 'User':
      return 'users';
    default:
      throw Exception('Unknown entity type: $T');
  }
}

fromJson<T extends Entity>(Map<String, dynamic> json) {
  switch (T.toString()) {
    case 'User':
      return User.fromJson(json);
    default:
      throw Exception('Unknown entity type: $T');
  }
}
