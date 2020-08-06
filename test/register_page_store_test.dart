import 'package:flutter_test/flutter_test.dart';
import 'package:flutterfire/src/models/user.dart';

import 'package:flutterfire/src/stores/register_page_store.dart';

import 'mock_services.dart';

main() {
  test('Register without email and password', () async {
    // Arrange
    final auth = MockAuthService();
    final loginPageStore = RegisterPageStore(auth);

    // Act
    loginPageStore.setupValidations();
    await loginPageStore.signUp();

    // Assert
    expect(loginPageStore.error.hasErrors, true);
    expect(loginPageStore.error.email, isNotNull);
    expect(loginPageStore.error.password, isNotNull);
    expect(loginPageStore.error.invalidLogin, isNull);
  });

  test('Register with invalid email', () async {
    // Arrange
    final auth = MockAuthService();
    final loginPageStore = RegisterPageStore(auth);

    // Act
    loginPageStore.setupValidations();
    loginPageStore.email = 'user@test';
    await loginPageStore.signUp();

    // Assert
    expect(loginPageStore.error.hasErrors, true);
    expect(loginPageStore.error.email, isNotNull);
    expect(loginPageStore.error.password, isNotNull);
    expect(loginPageStore.error.invalidLogin, isNull);
  });

  test('Register with empty password', () async {
    // Arrange
    final auth = MockAuthService();
    final loginPageStore = RegisterPageStore(auth);

    // Act
    loginPageStore.setupValidations();
    loginPageStore.email = 'user@test.com';
    await loginPageStore.signUp();

    // Assert
    expect(loginPageStore.error.hasErrors, true);
    expect(loginPageStore.error.email, isNull);
    expect(loginPageStore.error.password, isNotNull);
    expect(loginPageStore.error.invalidLogin, isNull);
  });

  test('Register with already registered email', () async {
    // Arrange
    final auth = MockAuthService(onIsUserAvailable: (email) => (email != 'existinguser@test.com'));
    final loginPageStore = RegisterPageStore(auth);

    // Act
    loginPageStore.setupValidations();
    loginPageStore.email = 'existinguser@test.com';
    loginPageStore.password = 'xxxxxx';
    await loginPageStore.signUp();

    // Assert
    expect(loginPageStore.error.hasErrors, true);
    expect(loginPageStore.error.email, isNull);
    expect(loginPageStore.error.password, isNull);
    expect(loginPageStore.error.alreadyRegistered, isNotNull);
    expect(loginPageStore.error.invalidLogin, isNull);
  });

  test('Register with email and password', () async {
    // Arrange
    final auth = MockAuthService(
      onSignUp: (name, email, password) => (email == 'user@test.com' && password == 'xxxxxx')
          ? User(
              id: 'user-id-001',
              name: name,
              email: email,
              password: password,
              role: null,
            )
          : null,
      onIsUserAvailable: (email) => (email != 'existinguser@test.com'),
    );
    final loginPageStore = RegisterPageStore(auth);

    // Act
    loginPageStore.setupValidations();
    loginPageStore.email = 'User';
    loginPageStore.email = 'user@test.com';
    loginPageStore.password = 'xxxxxx';
    final user = await loginPageStore.signUp();

    // Assert
    expect(user.id, 'user-id-001');
    expect(loginPageStore.error.hasErrors, false);
    expect(loginPageStore.error.email, isNull);
    expect(loginPageStore.error.password, isNull);
    expect(loginPageStore.error.invalidLogin, isNull);
  });
}
