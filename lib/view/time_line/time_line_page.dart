import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simple_sns/model/account.dart';
import 'package:simple_sns/model/post.dart';

class TimeLinePage extends StatefulWidget {
  const TimeLinePage({Key? key}) : super(key: key);

  @override
  _TimeLinePageState createState() => _TimeLinePageState();
}

class _TimeLinePageState extends State<TimeLinePage> {
  Account myAccount = Account(
    id: '1',
    name: 'Eren',
    selfIntroduction: 'Hello',
    userId: 'attack_on_titan',
    imagePath:
        'https://pbs.twimg.com/media/FMRDuQ8acAAk9aU?format=jpg&name=small',
    createdTime: DateTime.now(),
    updatedTime: DateTime.now(),
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
      appBar: AppBar(
        title: Text(
          'TimeLine',
          style: TextStyle(color: Colors.pinkAccent),
        ),
        backgroundColor: Colors.cyan,
      ),
      body: ListView.builder(
        itemCount: postList.length,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
                border: index == 0
                    ? Border(
                        top: BorderSide(color: Colors.cyanAccent, width: 0),
                        bottom: BorderSide(color: Colors.cyanAccent, width: 0),
                      )
                    : Border(
                        bottom: BorderSide(color: Colors.cyanAccent, width: 0),
                      )),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: CircleAvatar(
                    radius: 30,
                    foregroundImage: NetworkImage(myAccount.imagePath),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 5.0),
                                  child: Text(
                                    myAccount.name,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.pinkAccent),
                                  ),
                                ),
                                Text(
                                  '@${myAccount.userId}',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Text(DateFormat('M/d/yy')
                                  .format(postList[index].createdTime!)),
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
        },
      ),
    );
  }
}
