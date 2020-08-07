import 'dart:async';

import '../models/entity.dart';
import 'query_repository.dart';
import 'repository.dart';

class MemoryQueryRepository extends QueryRepository {
  final Repository _repository;

  MemoryQueryRepository(this._repository);

  @override
  Future<T> get<T extends Entity>(String id) {
    return _repository.get<T>(id);
  }

  @override
  Stream<List<T>> getStream<T extends Entity>({String orderBy, bool descending = false, int count = 0}) {
    final dataStream = StreamController<List<T>>();
    _repository.getAll<T>().then((value) => dataStream.sink.add(value), onError: (e) => dataStream.close());
    return dataStream.stream;
  }
}
