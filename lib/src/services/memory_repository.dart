import 'repository.dart';
import '../models/entity.dart';

class MemoryRepository extends Repository {
  final Map<Type, Map<String, Entity>> _store = {};

  @override
  Future<T> get<T extends Entity>(String id) {
    if (_store.containsKey(T) && _store[T].containsKey(id)) {
      final data = _store[T][id] as T;
      return Future.value(data);
    }
    return null;
  }

  @override
  Future<String> save<T extends Entity>(T entity) {
    if (!_store.containsKey(T)) {
      _store[T] = {};
    }
    _store[T][entity.id] = entity;
    return Future.value(entity.id);
  }

  @override
  Future<List<T>> getAll<T extends Entity>({bool includeDeleted = false, bool onlyDeleted = false}) {
    if (!_store.containsKey(T)) {
      return Future.value([]);
    }
    final result = _store[T].values.toList().cast<T>();
    return Future.value(result);
  }

  Future delete<T extends Entity>(String id) {
    if (_store.containsKey(T) && _store[T].containsKey(id)) {
      _store[T].remove(id);
    }
    return Future.value();
  }
}
