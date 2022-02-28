import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:simple_sns/model/account.dart';

class UserFirestore {
  static final _firestoreInstance = FirebaseFirestore.instance;
  // firetoreの'users'のコレクションの取得
  static final CollectionReference users =
      _firestoreInstance.collection('users');

  static Future<dynamic> setUser(Account newAccount) async {
    try {
      await users.doc(newAccount.id).set({
        'name': newAccount.name,
        'user_id': newAccount.userId,
        'self_introduction': newAccount.selfIntroduction,
        'image_path': newAccount.imagePath,
        'created_time': Timestamp.now(),
        'updated_time': Timestamp.now(),
      });
      print('新しいユーザー登録成功');
      return true;
    } on FirebaseException catch (e) {
      print('新しいユーザー登録失敗: $e');
      return false;
    }
  }
}
