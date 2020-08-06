// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_page_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LoginPageStore on _LoginPageStoreBase, Store {
  final _$emailAtom = Atom(name: '_LoginPageStoreBase.email');

  @override
  String get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  final _$passwordAtom = Atom(name: '_LoginPageStoreBase.password');

  @override
  String get password {
    _$passwordAtom.reportRead();
    return super.password;
  }

  @override
  set password(String value) {
    _$passwordAtom.reportWrite(value, super.password, () {
      super.password = value;
    });
  }

  final _$_LoginPageStoreBaseActionController =
      ActionController(name: '_LoginPageStoreBase');

  @override
  void validateEmail(String value) {
    final _$actionInfo = _$_LoginPageStoreBaseActionController.startAction(
        name: '_LoginPageStoreBase.validateEmail');
    try {
      return super.validateEmail(value);
    } finally {
      _$_LoginPageStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validatePassword(String value) {
    final _$actionInfo = _$_LoginPageStoreBaseActionController.startAction(
        name: '_LoginPageStoreBase.validatePassword');
    try {
      return super.validatePassword(value);
    } finally {
      _$_LoginPageStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
email: ${email},
password: ${password}
    ''';
  }
}

mixin _$LoginPageErrorState on _LoginPageErrorState, Store {
  Computed<bool> _$hasErrorsComputed;

  @override
  bool get hasErrors =>
      (_$hasErrorsComputed ??= Computed<bool>(() => super.hasErrors,
              name: '_LoginPageErrorState.hasErrors'))
          .value;

  final _$emailAtom = Atom(name: '_LoginPageErrorState.email');

  @override
  String get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  final _$passwordAtom = Atom(name: '_LoginPageErrorState.password');

  @override
  String get password {
    _$passwordAtom.reportRead();
    return super.password;
  }

  @override
  set password(String value) {
    _$passwordAtom.reportWrite(value, super.password, () {
      super.password = value;
    });
  }

  final _$invalidLoginAtom = Atom(name: '_LoginPageErrorState.invalidLogin');

  @override
  String get invalidLogin {
    _$invalidLoginAtom.reportRead();
    return super.invalidLogin;
  }

  @override
  set invalidLogin(String value) {
    _$invalidLoginAtom.reportWrite(value, super.invalidLogin, () {
      super.invalidLogin = value;
    });
  }

  @override
  String toString() {
    return '''
email: ${email},
password: ${password},
invalidLogin: ${invalidLogin},
hasErrors: ${hasErrors}
    ''';
  }
}
