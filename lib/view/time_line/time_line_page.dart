import 'package:flutter/material.dart';
import 'package:simple_sns/model/account.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('TimeLine')),
    );
  }
}
