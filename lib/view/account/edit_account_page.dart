import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simple_sns/model/account.dart';
import 'package:simple_sns/utils/authentication.dart';
import 'package:simple_sns/utils/widget_utils.dart';

class EditAccountPage extends StatefulWidget {
  const EditAccountPage({Key? key}) : super(key: key);

  @override
  _EditAccountPageState createState() => _EditAccountPageState();
}

class _EditAccountPageState extends State<EditAccountPage> {
  // 自分のアカウント
  Account myAccount = Authentication.myAccount!;
  TextEditingController nameController = TextEditingController();
  TextEditingController userIdController = TextEditingController();
  TextEditingController serfIntroductionController = TextEditingController();
  File? image;
  ImagePicker picker = ImagePicker();

  ImageProvider getImage() {
    if (image == null) {
      return NetworkImage(myAccount.imagePath);
    } else {
      return FileImage(image!);
    }
  }

  // 初期値
  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: myAccount.name);
    userIdController = TextEditingController(text: myAccount.userId);
    serfIntroductionController =
        TextEditingController(text: myAccount.selfIntroduction);
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
      appBar: WidgetUtils.createAppBar('Edit Page'),
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
                  foregroundImage: getImage(),
                  backgroundColor: Colors.cyan,
                  radius: 70,
                  child: Icon(
                    Icons.add_a_photo,
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
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async {
                  if (nameController.text.isNotEmpty &&
                      userIdController.text.isNotEmpty &&
                      serfIntroductionController.text.isNotEmpty &&
                      image != null) {
                    // 認証が成功した場合

                  }
                },
                child: Text(
                  'Update',
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
