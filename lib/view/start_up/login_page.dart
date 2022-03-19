import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
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
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            width: double.infinity,
            child: Column(
              children: [
                SizedBox(
                  height: 70,
                ),
                Text(
                  'シンプルSNS',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.cyan),
                ),
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
                SizedBox(height: 15),
                RichText(
                  text: TextSpan(
                    style: TextStyle(color: Colors.black87),
                    children: [
                      TextSpan(text: 'アカウントを持ってない方は'),
                      TextSpan(
                          text: 'こちら',
                          style: TextStyle(
                            color: Colors.pinkAccent,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation,
                                            secondaryAnimation) =>
                                        CreateAccountPage(),
                                    transitionsBuilder: (context, animation,
                                        secondaryAnimation, child) {
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
                            }),
                    ],
                  ),
                ),
                SizedBox(height: 50),
                ElevatedButton(
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
                  child: Text('Emailでログイン'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.cyan, //ボタンの背景色
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
