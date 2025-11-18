import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Signup
  Future<String?> signup(String name, String email, String password) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final idToken = await userCredential.user!.getIdToken();

      // send token to backend
      await http.post(
        Uri.parse("http://google-discussing.gl.at.ply.gg:16557/api/auth/signup"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "uid": userCredential.user!.uid,
          "email": userCredential.user!.email,
          "name": name,
          "token": idToken,
        }),
      );
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  // Login
  Future<String?> login(String email, String password) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final idToken = await userCredential.user!.getIdToken();

      // send token to backend
      await http.post(
        Uri.parse("http://google-discussing.gl.at.ply.gg:16557/api/auth/login"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "uid": userCredential.user!.uid,
          "email": userCredential.user!.email,
          "token": idToken,
        }),
      );
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  // Logout
  Future<void> logout() async {
    await _auth.signOut();
  }

  // Check User State
  Stream<User?> get userStream => _auth.authStateChanges();
}
