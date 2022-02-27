import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simple_sns/utils/authentication.dart';

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

  // 画像の取得
  Future<void> getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        iconTheme: IconThemeData(color: Colors.pinkAccent),
        title: Text(
          'Sign Up',
          style: TextStyle(color: Colors.pinkAccent),
        ),
      ),
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
                child: CircleAvatar(
                  foregroundImage: image == null ? null : FileImage(image!),
                  backgroundColor: Colors.cyan,
                  radius: 70,
                  child: Icon(
                    Icons.add,
                    color: Colors.pinkAccent,
                  ),
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
                    var result = await Authentication.signUp(
                        email: emailController.text,
                        pass: passwordController.text);
                    if (result == true) {
                      Navigator.pop(context);
                    }
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
