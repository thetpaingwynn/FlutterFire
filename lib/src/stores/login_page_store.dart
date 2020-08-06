import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:validators/validators.dart';

import '../services/auth_service.dart';

part 'login_page_store.g.dart';

@injectable
class LoginPageStore = _LoginPageStoreBase with _$LoginPageStore;

abstract class _LoginPageStoreBase with Store {
  final AuthService _auth;
  final error = LoginPageErrorState();

  List<ReactionDisposer> _disposers;

  @observable
  String email;

  @observable
  String password;

  @action
  void validateEmail(String value) {
    error.invalidLogin = null;
    error.email = (isNull(value) || value.isEmpty || !isEmail(value)) ? "Invalid email" : null;
  }

  @action
  void validatePassword(String value) {
    error.invalidLogin = null;
    error.password = isNull(value) || value.isEmpty ? "Invalid password" : null;
  }

  _LoginPageStoreBase(this._auth);

  void setupValidations() {
    dispose();
    _disposers = [
      reaction((_) => email, validateEmail),
      reaction((_) => password, validatePassword),
    ];
  }

  bool isValid() {
    validateEmail(email);
    validatePassword(password);
    return !error.hasErrors;
  }

  Future signIn() async {
    if (isValid()) {
      String userId = await _auth.signIn(this.email, this.password);
      if (userId == null) {
        error.invalidLogin = 'Invalid email or password';
      }
      return userId;
    }
    return null;
  }

  void dispose() {
    for (final d in _disposers ?? []) {
      d();
    }
    _disposers?.clear();
  }
}

class LoginPageErrorState = _LoginPageErrorState with _$LoginPageErrorState;

abstract class _LoginPageErrorState with Store {
  @observable
  String email;

  @observable
  String password;

  @observable
  String invalidLogin;

  @computed
  bool get hasErrors => email != null || password != null || invalidLogin != null;
}
