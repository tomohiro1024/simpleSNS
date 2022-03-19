import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:simple_sns/model/post.dart';

class PostsFirestore {
  static final _firestoreInstance = FirebaseFirestore.instance;

  // さまざまなユーザーの投稿内容のPosts
  static final CollectionReference posts =
      _firestoreInstance.collection('posts');

  static Future<dynamic> addPost(Post newPost) async {
    try {
      // 自分だけの投稿内容のmyPosts
      final CollectionReference _userPosts = _firestoreInstance
          .collection('users')
          .doc(newPost.postAccountId)
          .collection('my_posts');

      var result = await posts.add({
        'content': newPost.content,
        'post_account_id': newPost.postAccountId,
        'created_time': Timestamp.now(),
      });

      _userPosts.doc(result.id).set({
        'post_id': result.id,
        'created_time': Timestamp.now(),
      });
      print('投稿完了');
      return true;
    } on FirebaseException catch (e) {
      print('投稿に失敗');
      return false;
    }
  }

  static Future<List<Post>?> getPostsFromIds(List<String> ids) async {
    List<Post> postList = [];
    try {
      await Future.forEach(ids, (String id) async {
        DocumentSnapshot doc = await posts.doc(id).get();
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        Post post = Post(
          id: doc.id,
          content: data['content'],
          postAccountId: data['post_account_id'],
          createdTime: data['created_time'],
        );
        postList.add(post);
      });
      print('自分の投稿を取得しました');
      return postList;
    } on FirebaseException catch (e) {
      print('自分の投稿を取得できませんでした: $e');
      return null;
    }
  }
}
