import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:validators/validators.dart';

import '../models/user.dart';
import '../services/auth_service.dart';

part 'register_page_store.g.dart';

@injectable
class RegisterPageStore = _RegisterPageStoreBase with _$RegisterPageStore;

abstract class _RegisterPageStoreBase with Store {
  final AuthService _auth;
  final error = LoginPageErrorState();

  List<ReactionDisposer> _disposers;

  @observable
  String name;

  @observable
  String email;

  @observable
  String password;

  @action
  void validateName(String value) {
    error.invalidLogin = null;
    error.name = (isNull(value) || value.isEmpty) ? "Name cannot be blank" : null;
  }

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

  @action
  Future isAlreadyRegistered(String value) async {
    error.alreadyRegistered = null;

    if (isNull(value) || value.isEmpty || error.hasErrors) {
      return;
    }

    final available = await _auth.isUserAvailable(email);
    error.alreadyRegistered = available ? null : "Already registered";
  }

  _RegisterPageStoreBase(this._auth);

  void setupValidations() {
    dispose();
    _disposers = [
      reaction((_) => name, validateName),
      reaction((_) => email, validateEmail),
      reaction((_) => password, validatePassword),
    ];
  }

  Future<bool> isValid() async {
    validateName(email);
    validateEmail(email);
    validatePassword(password);
    await isAlreadyRegistered(email);
    return !error.hasErrors;
  }

  Future<User> signUp() async {
    if (await isValid()) {
      final user = await _auth.signUp(name, email, password);
      return user;
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
  String name;

  @observable
  String email;

  @observable
  String password;

  @observable
  String alreadyRegistered;

  @observable
  String invalidLogin;

  @computed
  bool get hasErrors => name != null || email != null || password != null || alreadyRegistered != null || invalidLogin != null;
}
