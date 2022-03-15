import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
  File? image;
  ImagePicker picker = ImagePicker();
  Account myAccount = Authentication.myAccount!;

  ImageProvider getImage() {
    if (image == null) {
      return NetworkImage('');
    } else {
      return FileImage(image!);
    }
  }

  // 端末の画像の取得
  Future<void> getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
      });
    }
  }

  // 画像をストレージにアップロード
  // 引数をuidではなくpostのid(ランダムID)にする。
  Future<String> uploadImage(String uid) async {
    final FirebaseStorage storageInstance = FirebaseStorage.instance;
    final Reference ref = storageInstance.ref();
    await ref.child(uid).putFile(image!);
    String downloadUrl = await storageInstance.ref(uid).getDownloadURL();
    print('image_path: $downloadUrl');
    return downloadUrl;
  }

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
              GestureDetector(
                onTap: () async {
                  await getImageFromGallery();
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CircleAvatar(
                      foregroundImage: getImage(),
                      backgroundColor: Colors.cyan,
                      radius: 70,
                    ),
                    Icon(
                      Icons.add_a_photo,
                      color: Colors.pinkAccent,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async {
                  if (contentController.text.isNotEmpty && image != null) {
                    // uploadImage()の引数をpost_idにしたい
                    // idの確保
                    // id uuidを使用して取得、ドキュメンと新規作成
                    String imagePost = await uploadImage(myAccount.id);
                    Post newPost = Post(
                        content: contentController.text,
                        postAccountId: Authentication.myAccount!.id,
                        imagePost: imagePost);
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
