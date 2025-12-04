import 'package:firebase_auth/firebase_auth.dart';

void printToken() async {
  String? token = await FirebaseAuth.instance.currentUser?.getIdToken();
  print("TOKEN: $token");
}
