import 'package:flutterfire/src/models/entity.dart';

abstract class Repository {
  Future<T> get<T extends Entity>(String id);
  Future<List<T>> getAll<T extends Entity>({bool includeDeleted = false, bool onlyDeleted = false});
  Future<String> save<T extends Entity>(T entity);
  Future delete<T extends Entity>(String id);
}
