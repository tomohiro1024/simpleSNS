import 'package:firebase_auth/firebase_auth.dart';

class Authentication {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static User? currentFirebaseUser;

  static Future<dynamic> signUp(
      {required String email, required String pass}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: pass);
      print('認証登録OK');
      return true;
    } on FirebaseAuthException catch (e) {
      print('認証登録エラー');
      return '認証に失敗しました';
    }
  }
}
