import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simple_sns/model/account.dart';
import 'package:simple_sns/utils/authentication.dart';
import 'package:simple_sns/utils/firestore/users.dart';
import 'package:simple_sns/view/start_up/login_page.dart';

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
  TextEditingController ageController = TextEditingController();
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
    ageController = TextEditingController(text: myAccount.age);
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
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.pinkAccent),
        backgroundColor: Colors.cyan,
        title: Text('Edit Page', style: TextStyle(color: Colors.pinkAccent)),
        actions: [
          IconButton(
            onPressed: () {
              Authentication.signOut();
              while (Navigator.canPop(context)) {
                Navigator.pop(context);
              }
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ));
            },
            icon: Icon(
              Icons.logout,
              color: Colors.pinkAccent,
              size: 30,
            ),
          ),
        ],
      ),
      body: Container(
        color: Colors.pinkAccent.withOpacity(0.5),
        child: SingleChildScrollView(
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
                SizedBox(height: 20),
                Container(
                  width: 270,
                  child: TextField(
                    maxLength: 7,
                    controller: nameController,
                    decoration: InputDecoration(
                      hintText: 'Name',
                      filled: true,
                      fillColor: Colors.cyanAccent.withOpacity(0.1),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Container(
                    width: 270,
                    child: TextField(
                      maxLength: 7,
                      controller: userIdController,
                      decoration: InputDecoration(
                        hintText: 'User ID',
                        filled: true,
                        fillColor: Colors.cyanAccent.withOpacity(0.1),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 270,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: ageController,
                    decoration: InputDecoration(
                      hintText: 'age',
                      filled: true,
                      fillColor: Colors.cyanAccent.withOpacity(0.1),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  width: 270,
                  child: TextField(
                    controller: serfIntroductionController,
                    decoration: InputDecoration(
                      hintText: 'Comment',
                      filled: true,
                      fillColor: Colors.cyanAccent.withOpacity(0.1),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (nameController.text.isNotEmpty &&
                        userIdController.text.isNotEmpty &&
                        ageController.text.isNotEmpty &&
                        serfIntroductionController.text.isNotEmpty) {
                      String imagePath = '';
                      if (image == null) {
                        imagePath = myAccount.imagePath;
                      } else {
                        var result = await uploadImage(myAccount.id);
                        imagePath = result;
                      }
                      Account updateAccount = Account(
                        id: myAccount.id,
                        name: nameController.text,
                        age: ageController.text,
                        userId: userIdController.text,
                        selfIntroduction: serfIntroductionController.text,
                        imagePath: imagePath,
                      );
                      Authentication.myAccount = updateAccount;
                      var result =
                          await UserFirestore.updateUser(updateAccount);
                      // 更新が成功した場合、画面を戻る
                      if (result == true) {
                        Navigator.pop(context, true);
                      }
                    }
                  },
                  child: Text(
                    'Update',
                    style: TextStyle(color: Colors.pinkAccent),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.cyan,
                    onPrimary: Colors.pinkAccent,
                    shape: StadiumBorder(),
                    elevation: 10,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
