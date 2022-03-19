import 'package:flutter/material.dart';
import 'package:simple_sns/model/account.dart';
import 'package:simple_sns/model/post.dart';
import 'package:simple_sns/utils/authentication.dart';
import 'package:simple_sns/utils/firestore/posts.dart';

class PostPage extends StatefulWidget {
  const PostPage({Key? key}) : super(key: key);

  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  TextEditingController contentController = TextEditingController();
  Account myAccount = Authentication.myAccount!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'New Post',
          style: TextStyle(color: Colors.pinkAccent),
        ),
        backgroundColor: Colors.cyan,
        iconTheme: IconThemeData(color: Colors.pinkAccent),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              TextField(
                controller: contentController,
                decoration: InputDecoration(hintText: 'Comment'),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async {
                  if (contentController.text.isNotEmpty) {
                    Post newPost = Post(
                      content: contentController.text,
                      postAccountId: Authentication.myAccount!.id,
                    );
                    var result = await PostsFirestore.addPost(newPost);
                    if (result == true) {
                      Navigator.pop(context);
                    }
                  } else {
                    final snackBar = SnackBar(
                      backgroundColor: Colors.red,
                      content: Text('コメントもしくは画像を入力してください'),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                child: Text(
                  'Post',
                  style: TextStyle(
                      color: Colors.pinkAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(primary: Colors.cyan),
              )
            ],
          ),
        ),
      ),
    );
  }
}
