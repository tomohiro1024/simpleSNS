import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simple_sns/model/account.dart';
import 'package:simple_sns/model/post.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  Account myAccount = Account(
    id: '1',
    name: 'Eren',
    selfIntroduction: 'Hello',
    userId: 'attack_on_titan',
    imagePath:
        'https://pbs.twimg.com/media/FMRDuQ8acAAk9aU?format=jpg&name=small',
    createdTime: Timestamp.now(),
    updatedTime: Timestamp.now(),
  );

  List<Post> postList = [
    Post(
      id: '1',
      content: '初めての投稿',
      postAccountId: '1',
      createdTime: DateTime.now(),
    ),
    Post(
      id: '2',
      content: 'よろしく！',
      postAccountId: '1',
      createdTime: DateTime.now(),
    ),
  ];

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
                            padding: const EdgeInsets.only(right: 50.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  myAccount.name,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.pinkAccent,
                                      fontSize: 25),
                                ),
                                Text(
                                  '@${myAccount.userId}',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      OutlinedButton(
                        onPressed: () {},
                        child: Text('Edit'),
                      )
                    ],
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
                child: ListView.builder(
                    itemCount: postList.length,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                            border: index == 0
                                ? Border(
                                    top: BorderSide(
                                        color: Colors.cyanAccent, width: 0),
                                    bottom: BorderSide(
                                        color: Colors.cyanAccent, width: 0),
                                  )
                                : Border(
                                    bottom: BorderSide(
                                        color: Colors.cyanAccent, width: 0),
                                  )),
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: CircleAvatar(
                                radius: 30,
                                foregroundImage:
                                    NetworkImage(myAccount.imagePath),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 5.0),
                                              child: Text(
                                                myAccount.name,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.pinkAccent),
                                              ),
                                            ),
                                            Text(
                                              '@${myAccount.userId}',
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20.0),
                                          child: Text(DateFormat('M/d/yy')
                                              .format(postList[index]
                                                  .createdTime!)),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(postList[index].content),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    }))
          ],
        ),
      ),
    );
  }
}
