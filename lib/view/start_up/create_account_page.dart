import 'package:flutter/material.dart';

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
              CircleAvatar(
                radius: 70,
                child: Icon(Icons.add),
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
                onPressed: () {
                  if (nameController.text.isNotEmpty &&
                      userIdController.text.isNotEmpty &&
                      serfIntroductionController.text.isNotEmpty &&
                      emailController.text.isNotEmpty &&
                      passwordController.text.isNotEmpty) {
                    Navigator.pop(context);
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
