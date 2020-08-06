import 'dart:async';

import 'package:flutterfire/src/models/user.dart';
import 'package:flutterfire/src/models/user_role.dart';
import 'package:flutterfire/src/utils/utils.dart';
import 'package:injectable/injectable.dart';

import 'auth_service.dart';
import 'repository.dart';

@Singleton(as: AuthService)
class MemoryAuthService extends AuthService {
  final Repository _repository;

  final authStateCtrl = StreamController<String>();

  @override
  Future<bool> isUserAvailable(String email) {
    return Future.value(true);
  }

  @override
  Stream<String> get onAuthStateChanged => authStateCtrl.stream;

  @override
  Future<String> signIn(String email, String password) async {
    final users = await _repository.getAll<User>();
    final user = users.firstWhere((x) => x.email == email && x.password == password, orElse: () => null);

    await Future.delayed(Duration(seconds: 2)); // simulate some delay

    if (user != null) {
      authStateCtrl.sink.add(user.id);
    }
    return user?.id;
  }

  @override
  Future<User> signUp(String name, String email, String password) async {
    if (!await isUserAvailable(email)) return null;
    final newUser = User(id: newId(), name: name, email: email, password: password, role: UserRole.User);
    final userId = await _repository.save<User>(newUser);

    return userId != null ? newUser : null;
  }

  @override
  Future<void> signOut() {
    return Future.delayed(Duration(seconds: 1), () {
      authStateCtrl.sink.add(null);
    });
  }

  MemoryAuthService(this._repository) {
    authStateCtrl.sink.add(null);
  }

  void dispose() {
    authStateCtrl?.close();
  }
}
