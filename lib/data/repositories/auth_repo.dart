import 'package:firebase_auth/firebase_auth.dart';
import 'package:link_nest/core/local_storage/app_storage.dart';

/// Auth service for login/register/logout
// class AuthRepository {
//   final FirebaseAuth _auth;
//   AuthRepository(this._auth);

//   Future<User?> signIn(String email, String password) async {
//     final result = await _auth.signInWithEmailAndPassword(
//       email: email,
//       password: password,
//     );
//     return result.user;
//   }

//   Future<User?> register(String email, String password) async {
//     final result = await _auth.createUserWithEmailAndPassword(
//       email: email,
//       password: password,
//     );
//     return result.user;
//   }

//   Future<void> signOut() async => await _auth.signOut();

  
// }
class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final AppStorage _storage;

  AuthRepository(this._storage);

  User? get currentUser => _auth.currentUser;
  Stream<User?> authStateChanges() => _auth.authStateChanges();

  Future<void> setOnboardingSeen() async {
    await _storage.put(key: "onboarding_seen", value: "true");
  }

  bool hasSeenOnboarding() {
    final val = _storage.get(key: "onboarding_seen");
    return val == "true";
  }

  Future<void> signOut() async {
    await _auth.signOut();
    await _storage.clearAllData();
  }

  /// 🔹 Sign up with email & password
  Future<User?> signUp(String email, String password, String name) async {
  final userCred = await _auth.createUserWithEmailAndPassword(
    email: email,
    password: password,
  );

  // Update displayName after signup
  await userCred.user?.updateDisplayName(name);

  // Make sure the update is applied
  await userCred.user?.reload();

  return _auth.currentUser;
}


  /// 🔹 Login with email & password
  Future<User?> login(String email, String password) async {
    final userCred = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCred.user;
  }
}


