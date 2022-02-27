import 'package:firebase_auth/firebase_auth.dart';

class Authentication {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static User? currentFirebaseUser;

  // アカウント登録
  static Future<dynamic> signUp(
      {required String email, required String pass}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: pass);
      print('認証登録OK');
      return true;
    } on FirebaseAuthException catch (e) {
      print('認証登録エラー: $e');
      return false;
    }
  }

  // Eメールログイン
  static Future<dynamic> emailSignIn(
      {required String email, required String pass}) async {
    try {
      final UserCredential _result = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: pass);
      currentFirebaseUser = _result.user;
      print('ログイン成功');
      return true;
    } on FirebaseAuthException catch (e) {
      print('ログイン失敗しました: $e');
      return false;
    }
  }
}
