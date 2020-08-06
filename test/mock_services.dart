import 'package:flutterfire/src/models/user.dart';
import 'package:flutterfire/src/services/auth_service.dart';

class MockAuthService extends AuthService {
  final Function onSignIn;
  final Function onSignUp;
  final Function onIsUserAvailable;

  @override
  Future<bool> isUserAvailable(String email) {
    return Future.value(onIsUserAvailable(email));
  }

  @override
  Stream<String> get onAuthStateChanged => throw UnimplementedError();

  @override
  Future<String> signIn(String email, String password) {
    return Future.value(onSignIn(email, password));
  }

  @override
  Future<void> signOut() {
    throw UnimplementedError();
  }

  @override
  Future<User> signUp(String name, String email, String password) {
    return Future.value(onSignUp(name, email, password));
  }

  MockAuthService({this.onSignIn, this.onSignUp, this.onIsUserAvailable});
}
