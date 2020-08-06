import '../models/user.dart';

abstract class AuthService {
  Future<String> signIn(String email, String password);
  Future<User> signUp(String signUp, String email, String password);
  Future<void> signOut();
  Stream<String> get onAuthStateChanged;
  Future<bool> isUserAvailable(String email);
}
