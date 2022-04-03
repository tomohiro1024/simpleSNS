import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:simple_sns/utils/authentication.dart';
import 'package:simple_sns/utils/firestore/users.dart';
import 'package:simple_sns/view/screen.dart';
import 'package:simple_sns/view/start_up/create_account_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                  'https://images.unsplash.com/photo-1648741470777-7d1110408905?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=928&q=80'),
              fit: BoxFit.cover),
        ),
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(
              height: 70,
            ),
            RichText(
                text: TextSpan(children: [
              TextSpan(
                  text: 'シンプル',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade700,
                  )),
              TextSpan(
                text: 'SNS',
                style: TextStyle(
                  color: Colors.pinkAccent,
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ])),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25.0),
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
                obscureText: true,
                obscuringCharacter: '*',
                controller: passwordController,
                decoration: InputDecoration(hintText: 'Password'),
              ),
            ),
            SizedBox(height: 40),
            SizedBox(
              width: 150,
              child: ElevatedButton(
                onPressed: () async {
                  var results = await Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            CreateAccountPage(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          return FadeUpwardsPageTransitionsBuilder()
                              .buildTransitions(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          CreateAccountPage()),
                                  context,
                                  animation,
                                  secondaryAnimation,
                                  child);
                        },
                      ));
                  if (results == true) {
                    setState(() {
                      final snackBar = SnackBar(
                        backgroundColor: Colors.blue,
                        content: Text('アカウント登録完了しました'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    });
                  }
                },
                child: Text(
                  '新規登録',
                  style: TextStyle(
                      color: Colors.pinkAccent, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.cyan, //ボタンの背景色
                ),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 150,
              child: ElevatedButton(
                onPressed: () async {
                  if (emailController.text.isNotEmpty &&
                      passwordController.text.isNotEmpty) {
                    var result = await Authentication.emailSignIn(
                        email: emailController.text,
                        pass: passwordController.text);
                    if (result is UserCredential) {
                      var _result =
                          await UserFirestore.getUser(result.user!.uid);
                      if (_result == true) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Screen()));
                      }
                    } else {
                      final snackBar = SnackBar(
                        backgroundColor: Colors.red,
                        content: Text('Eメールもしくはパスワードが間違っています'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  } else {
                    final snackBar = SnackBar(
                      backgroundColor: Colors.red,
                      content: Text('Eメールもしくはパスワードを入力してください'),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                child: Text(
                  'ログイン',
                  style: TextStyle(
                      color: Colors.pinkAccent, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.cyan, //ボタンの背景色
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
