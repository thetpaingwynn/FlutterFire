import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../models/entity.dart';
import '../utils/firestore_helpers.dart';
import '../services/repository.dart';

@Singleton(as: Repository)
class FireRepository extends Repository {
  final Firestore _firestore = Firestore.instance;

  @override
  Future<T> get<T extends Entity>(String id) {
    throw UnimplementedError();
  }

  @override
  Future<List<T>> getAll<T extends Entity>({bool includeDeleted = false, bool onlyDeleted = false}) {
    throw UnimplementedError();
  }

  @override
  Future<String> save<T extends Entity>(T entity) async {
    final collection = getCollection<T>();
    final docRef = _firestore.collection(collection).document(entity.id);
    await docRef.setData(entity.toJson(), merge: true);
    return docRef.documentID;
  }

  @override
  Future delete<T extends Entity>(String id) async {
    final collection = getCollection<T>();
    final docRef = _firestore.collection(collection).document(id);
    await docRef.delete();
  }
}
