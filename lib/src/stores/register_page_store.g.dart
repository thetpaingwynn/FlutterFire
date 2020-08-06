// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_page_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$RegisterPageStore on _RegisterPageStoreBase, Store {
  final _$nameAtom = Atom(name: '_RegisterPageStoreBase.name');

  @override
  String get name {
    _$nameAtom.reportRead();
    return super.name;
  }

  @override
  set name(String value) {
    _$nameAtom.reportWrite(value, super.name, () {
      super.name = value;
    });
  }

  final _$emailAtom = Atom(name: '_RegisterPageStoreBase.email');

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

  final _$passwordAtom = Atom(name: '_RegisterPageStoreBase.password');

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

  final _$isAlreadyRegisteredAsyncAction =
      AsyncAction('_RegisterPageStoreBase.isAlreadyRegistered');

  @override
  Future<dynamic> isAlreadyRegistered(String value) {
    return _$isAlreadyRegisteredAsyncAction
        .run(() => super.isAlreadyRegistered(value));
  }

  final _$_RegisterPageStoreBaseActionController =
      ActionController(name: '_RegisterPageStoreBase');

  @override
  void validateName(String value) {
    final _$actionInfo = _$_RegisterPageStoreBaseActionController.startAction(
        name: '_RegisterPageStoreBase.validateName');
    try {
      return super.validateName(value);
    } finally {
      _$_RegisterPageStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateEmail(String value) {
    final _$actionInfo = _$_RegisterPageStoreBaseActionController.startAction(
        name: '_RegisterPageStoreBase.validateEmail');
    try {
      return super.validateEmail(value);
    } finally {
      _$_RegisterPageStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validatePassword(String value) {
    final _$actionInfo = _$_RegisterPageStoreBaseActionController.startAction(
        name: '_RegisterPageStoreBase.validatePassword');
    try {
      return super.validatePassword(value);
    } finally {
      _$_RegisterPageStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
name: ${name},
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

  final _$nameAtom = Atom(name: '_LoginPageErrorState.name');

  @override
  String get name {
    _$nameAtom.reportRead();
    return super.name;
  }

  @override
  set name(String value) {
    _$nameAtom.reportWrite(value, super.name, () {
      super.name = value;
    });
  }

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

  final _$alreadyRegisteredAtom =
      Atom(name: '_LoginPageErrorState.alreadyRegistered');

  @override
  String get alreadyRegistered {
    _$alreadyRegisteredAtom.reportRead();
    return super.alreadyRegistered;
  }

  @override
  set alreadyRegistered(String value) {
    _$alreadyRegisteredAtom.reportWrite(value, super.alreadyRegistered, () {
      super.alreadyRegistered = value;
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
name: ${name},
email: ${email},
password: ${password},
alreadyRegistered: ${alreadyRegistered},
invalidLogin: ${invalidLogin},
hasErrors: ${hasErrors}
    ''';
  }
}
