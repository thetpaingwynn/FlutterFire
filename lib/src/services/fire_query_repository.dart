import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../models/entity.dart';
import '../utils/firestore_helpers.dart';
import '../services/query_repository.dart';

@Singleton(as: QueryRepository)
class FireQueryRepository extends QueryRepository {
  final Firestore _firestore = Firestore.instance;

  @override
  Future<T> get<T extends Entity>(String id) async {
    final collection = getCollection<T>();
    final snapshot = await _firestore.collection(collection).document(id).get();
    if (snapshot != null) {
      return fromJson<T>(snapshot.data);
    }
    return null;
  }

  @override
  Stream<List<T>> getStream<T extends Entity>({String orderBy, bool descending = false, int count = 0}) {
    final collection = getCollection<T>();
    final collectionRef = _firestore.collection(collection);

    Query query;

    if (count > 0) {
      query = collectionRef.limit(count);
    }

    if (orderBy != null) {
      query = query == null ? collectionRef.orderBy(orderBy, descending: descending) : query.orderBy(orderBy, descending: descending);
    }

    final stream = query == null ? collectionRef.snapshots() : query.snapshots();
    return stream.transform(StreamTransformer.fromHandlers(handleData: (data, sink) {
      sink.add(data.documents.map((e) => fromJson<T>(e.data)).cast<T>().toList());
    }));
  }
}
