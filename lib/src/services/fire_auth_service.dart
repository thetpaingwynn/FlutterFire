import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart' as firebaseAuth;
import 'package:injectable/injectable.dart';

import '../models/user.dart';
import '../models/user_role.dart';
import 'auth_service.dart';
import 'repository.dart';

@Singleton(as: AuthService)
class FireAuthService extends AuthService {
  final firebaseAuth.FirebaseAuth _firebaseAuth = firebaseAuth.FirebaseAuth.instance;
  final Repository _repository;

  FireAuthService(this._repository);

  @override
  Stream<String> get onAuthStateChanged => _firebaseAuth.onAuthStateChanged.transform(
        StreamTransformer.fromHandlers(
          handleData: (firebaseUser, sink) => sink.add(firebaseUser?.uid),
        ),
      );

  @override
  Future<String> signIn(String email, String password) async {
    try {
      final result = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      final user = result.user;
      return user.uid;
    } catch (PlatformException) {
      return null;
    }
  }

  @override
  Future<void> signOut() {
    return _firebaseAuth.signOut();
  }

  @override
  Future<bool> isUserAvailable(String email) async {
    var result = await _firebaseAuth.fetchSignInMethodsForEmail(email: email);
    return result == null || result.isEmpty;
  }

  @override
  Future<User> signUp(String name, String email, String password) async {
    final result = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    if (result != null) {
      final newUser = User(
        id: result.user.uid,
        name: name,
        email: email,
        password: password,
        role: UserRole.User,
      );
      final userId = await _repository.save<User>(newUser);
      return userId != null ? newUser : null;
    }
    return null;
  }
}
