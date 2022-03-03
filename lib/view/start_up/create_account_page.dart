import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simple_sns/model/account.dart';
import 'package:simple_sns/utils/authentication.dart';
import 'package:simple_sns/utils/firestore/users.dart';
import 'package:simple_sns/utils/widget_utils.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({Key? key}) : super(key: key);

  @override
  _CreateAccountPageState createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController userIdController = TextEditingController();
  TextEditingController serfIntroductionController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  File? image;
  ImagePicker picker = ImagePicker();

  ImageProvider getImage() {
    if (image == null) {
      return NetworkImage(
          'https://i2.wp.com/bumbullbee.com/wp-content/uploads/2017/03/hitogata.jpg?resize=500%2C487');
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
      appBar: WidgetUtils.createAppBar('SignUp'),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Column(
            children: [
              SizedBox(height: 40),
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
              Container(
                width: 250,
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(hintText: 'Name'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Container(
                  width: 250,
                  child: TextField(
                    controller: userIdController,
                    decoration: InputDecoration(hintText: 'User ID'),
                  ),
                ),
              ),
              Container(
                width: 250,
                child: TextField(
                  controller: serfIntroductionController,
                  decoration: InputDecoration(hintText: 'Self Introduction'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Container(
                  width: 250,
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(hintText: 'Email'),
                  ),
                ),
              ),
              Container(
                width: 250,
                child: TextField(
                  controller: passwordController,
                  decoration: InputDecoration(hintText: 'Password'),
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async {
                  if (nameController.text.isNotEmpty &&
                      userIdController.text.isNotEmpty &&
                      serfIntroductionController.text.isNotEmpty &&
                      emailController.text.isNotEmpty &&
                      passwordController.text.isNotEmpty &&
                      image != null) {
                    // アカウントの認証
                    var result = await Authentication.signUp(
                        email: emailController.text,
                        pass: passwordController.text);
                    // 認証が成功した場合
                    if (result is UserCredential) {
                      String imagePath = await uploadImage(result.user!.uid);
                      Account newAccount = Account(
                        id: result.user!.uid,
                        name: nameController.text,
                        userId: userIdController.text,
                        selfIntroduction: serfIntroductionController.text,
                        imagePath: imagePath,
                      );
                      var _result = await UserFirestore.setUser(newAccount);
                      if (_result == true) {
                        Navigator.pop(context);
                      }
                    }
                  } else {
                    final snackBar = SnackBar(
                      backgroundColor: Colors.red,
                      content: Text('全ての項目を入力してください'),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                child: Text(
                  'Created an Account',
                  style: TextStyle(color: Colors.pinkAccent),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.cyan, //ボタンの背景色
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
