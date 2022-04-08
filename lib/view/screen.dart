import 'package:flutter/material.dart';
import 'package:simple_sns/view/account/account_page.dart';
import 'package:simple_sns/view/time_line/post_page.dart';
import 'package:simple_sns/view/time_line/time_line_page.dart';

class Screen extends StatefulWidget {
  const Screen({Key? key}) : super(key: key);

  @override
  _ScreenState createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  int selectedIndex = 0;
  List<Widget> pageList = [TimeLinePage(), AccountPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pageList[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.timeline,
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.account_circle,
              ),
              label: ''),
        ],
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.cyan,
        onPressed: () async {
          var result = await Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    PostPage(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return FadeUpwardsPageTransitionsBuilder().buildTransitions(
                      MaterialPageRoute(builder: (context) => PostPage()),
                      context,
                      animation,
                      secondaryAnimation,
                      child);
                },
              ));
          if (result == true) {
            setState(() {
              final snackBar = SnackBar(
                backgroundColor: Colors.blue,
                content: Text('コメントを投稿しました'),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            });
          }
        },
        child: Icon(
          Icons.mode_comment,
          color: Colors.white,
        ),
      ),
    );
  }
}
