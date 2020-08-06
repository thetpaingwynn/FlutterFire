import 'package:ulid/ulid.dart';

String newId() {
  return Ulid(millis: DateTime.now().millisecondsSinceEpoch).toString();
}
