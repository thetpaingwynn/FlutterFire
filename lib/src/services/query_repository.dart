import '../models/entity.dart';

abstract class QueryRepository {
  Future<T> get<T extends Entity>(String id);
  Stream<List<T>> getStream<T extends Entity>({String orderBy, bool descending = false, int count = 0});
}
