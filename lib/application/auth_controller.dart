import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yamekaku/data/%20auth_repository.dart';

final authStateProvider = StreamProvider<User?>((ref) {
  return ref.watch(authRepositoryProvider).authState();
});

final authControllerProvider = Provider<AuthController>(
  (ref) => AuthController(ref),
);

class AuthController {
  AuthController(this._ref);
  final Ref _ref;

  Future<String?> signIn(String email, String pw) async {
    try {
      await _ref
          .read(authRepositoryProvider)
          .signIn(email: email, password: pw);
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> signUp(String email, String pw) async {
    try {
      await _ref
          .read(authRepositoryProvider)
          .signUp(email: email, password: pw);
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> signOut() => _ref.read(authRepositoryProvider).signOut();
}
