import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

import '../models/user.dart';
import '../services/auth_service.dart';
import '../services/query_repository.dart';
import 'auth_info.dart';

part 'app_store.g.dart';

enum AuthStatus {
  NOT_DETERMINED,
  NOT_LOGGED_IN,
  LOGGED_IN,
}

@singleton
class AppStore = _AppStoreBase with _$AppStore;

abstract class _AppStoreBase with Store {
  final AuthService _auth;
  final QueryRepository _repository;

  @observable
  AuthStatus authStatus = AuthStatus.NOT_DETERMINED;

  @observable
  User currentUser;

  _AppStoreBase(this._auth, this._repository) {
    _auth.onAuthStateChanged.listen((userId) async {
      if (userId != null) {
        final user = await _repository.get<User>(userId);
        this.currentUser = user;
        AuthInfo.currentUser = user;
        authStatus = AuthStatus.LOGGED_IN;
      } else {
        this.currentUser = null;
        AuthInfo.currentUser = null;
        authStatus = AuthStatus.NOT_LOGGED_IN;
      }
    });
  }

  @action
  Future<void> signOut() {
    return _auth.signOut();
  }
}
