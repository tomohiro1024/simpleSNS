import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
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
      body: SafeArea(
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
                    fontSize: 30,
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
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => const Screen()));
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
    );
  }
}
