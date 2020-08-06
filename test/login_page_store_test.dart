import 'package:flutter_test/flutter_test.dart';

import 'package:flutterfire/src/stores/login_page_store.dart';

import 'mock_services.dart';

main() {
  test('Login without email and password', () async {
    // Arrange
    final auth = MockAuthService();
    final loginPageStore = LoginPageStore(auth);

    // Act
    loginPageStore.setupValidations();
    await loginPageStore.signIn();

    // Assert
    expect(loginPageStore.error.hasErrors, true);
    expect(loginPageStore.error.email, isNotNull);
    expect(loginPageStore.error.password, isNotNull);
    expect(loginPageStore.error.invalidLogin, isNull);
  });

  test('Login with invalid email', () async {
    // Arrange
    final auth = MockAuthService();
    final loginPageStore = LoginPageStore(auth);

    // Act
    loginPageStore.setupValidations();
    loginPageStore.email = 'user@test';
    await loginPageStore.signIn();

    // Assert
    expect(loginPageStore.error.hasErrors, true);
    expect(loginPageStore.error.email, isNotNull);
    expect(loginPageStore.error.password, isNotNull);
    expect(loginPageStore.error.invalidLogin, isNull);
  });

  test('Login with empty password', () async {
    // Arrange
    final auth = MockAuthService();
    final loginPageStore = LoginPageStore(auth);

    // Act
    loginPageStore.setupValidations();
    loginPageStore.email = 'user@test.com';
    await loginPageStore.signIn();

    // Assert
    expect(loginPageStore.error.hasErrors, true);
    expect(loginPageStore.error.email, isNull);
    expect(loginPageStore.error.password, isNotNull);
    expect(loginPageStore.error.invalidLogin, isNull);
  });

  test('Login with not registered email', () async {
    // Arrange
    final auth = MockAuthService(onSignIn: (email, password) => null);
    final loginPageStore = LoginPageStore(auth);

    // Act
    loginPageStore.setupValidations();
    loginPageStore.email = 'newuser@test.com';
    loginPageStore.password = 'xxxxxx';
    await loginPageStore.signIn();

    // Assert
    expect(loginPageStore.error.hasErrors, true);
    expect(loginPageStore.error.email, isNull);
    expect(loginPageStore.error.password, isNull);
    expect(loginPageStore.error.invalidLogin, isNotNull);
  });

  test('Login with email and password', () async {
    // Arrange
    final auth = MockAuthService(onSignIn: (email, password) {
      if (email == 'user@test.com' && password == 'xxxxxx') {
        return Future.value('user-id-001');
      }
      return Future.value(null);
    });
    final loginPageStore = LoginPageStore(auth);

    // Act
    loginPageStore.setupValidations();
    loginPageStore.email = 'user@test.com';
    loginPageStore.password = 'xxxxxx';
    final userId = await loginPageStore.signIn();

    // Assert
    expect(userId, 'user-id-001');
    expect(loginPageStore.error.hasErrors, false);
    expect(loginPageStore.error.email, isNull);
    expect(loginPageStore.error.password, isNull);
    expect(loginPageStore.error.invalidLogin, isNull);
  });
}
