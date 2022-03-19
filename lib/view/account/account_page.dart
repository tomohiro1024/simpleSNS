import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simple_sns/model/account.dart';
import 'package:simple_sns/model/post.dart';
import 'package:simple_sns/utils/authentication.dart';
import 'package:simple_sns/utils/firestore/posts.dart';
import 'package:simple_sns/utils/firestore/users.dart';
import 'package:simple_sns/view/account/edit_account_page.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  Account myAccount = Authentication.myAccount!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(right: 15, left: 15, top: 20),
              height: 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: CircleAvatar(
                              radius: 40,
                              foregroundImage:
                                  NetworkImage(myAccount.imagePath),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  myAccount.name,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.pinkAccent,
                                      fontSize: 15),
                                ),
                                Text(
                                  '@${myAccount.userId}',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                          OutlinedButton(
                            onPressed: () async {
                              var result = await Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation,
                                            secondaryAnimation) =>
                                        EditAccountPage(),
                                    transitionsBuilder: (context, animation,
                                        secondaryAnimation, child) {
                                      return FadeUpwardsPageTransitionsBuilder()
                                          .buildTransitions(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      EditAccountPage()),
                                              context,
                                              animation,
                                              secondaryAnimation,
                                              child);
                                    },
                                  ));
                              if (result == true) {
                                setState(() {
                                  myAccount = Authentication.myAccount!;
                                  final snackBar = SnackBar(
                                    backgroundColor: Colors.green,
                                    content: Text('プロフィールを編集しました'),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                });
                              }
                            },
                            child: Text(
                              'Edit',
                              style: TextStyle(color: Colors.pinkAccent),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.cyan, //ボタンの背景色
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Divider(
                    color: Colors.cyanAccent,
                  ),
                  SizedBox(
                    height: 17,
                  ),
                  Text(myAccount.selfIntroduction)
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              decoration: BoxDecoration(
                  border:
                      Border(bottom: BorderSide(color: Colors.cyan, width: 3))),
              child: Text(
                'PostList',
                style:
                    TextStyle(color: Colors.cyan, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
                child: StreamBuilder<QuerySnapshot>(
                    stream: UserFirestore.users
                        .doc(myAccount.id)
                        .collection('my_posts')
                        .orderBy('created_time', descending: true)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<String> myPostIds =
                            List.generate(snapshot.data!.docs.length, (index) {
                          return snapshot.data!.docs[index].id;
                        });
                        return FutureBuilder<List<Post>?>(
                            future: PostsFirestore.getPostsFromIds(myPostIds),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return ListView.builder(
                                    itemCount: snapshot.data!.length,
                                    itemBuilder: (context, index) {
                                      Post post = snapshot.data![index];
                                      return Container(
                                        decoration: BoxDecoration(
                                            border: index == 0
                                                ? Border(
                                                    top: BorderSide(
                                                        color:
                                                            Colors.cyanAccent,
                                                        width: 0),
                                                    bottom: BorderSide(
                                                        color:
                                                            Colors.cyanAccent,
                                                        width: 0),
                                                  )
                                                : Border(
                                                    bottom: BorderSide(
                                                        color:
                                                            Colors.cyanAccent,
                                                        width: 0),
                                                  )),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 15),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 10.0),
                                              child: CircleAvatar(
                                                radius: 30,
                                                foregroundImage: NetworkImage(
                                                    myAccount.imagePath),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      right:
                                                                          5.0),
                                                              child: Text(
                                                                myAccount.name,
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .pinkAccent),
                                                              ),
                                                            ),
                                                            Text(
                                                              '@${myAccount.userId}',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .grey),
                                                            ),
                                                          ],
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 20.0),
                                                          child: Text(DateFormat(
                                                                  'M/d/yy')
                                                              .format(post
                                                                  .createdTime!
                                                                  .toDate())),
                                                        )
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(post.content),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    });
                              } else {
                                return Container();
                              }
                            });
                      } else {
                        return Container();
                      }
                    }))
          ],
        ),
      ),
    );
  }
}
