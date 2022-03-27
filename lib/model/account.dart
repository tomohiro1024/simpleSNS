import 'package:cloud_firestore/cloud_firestore.dart';

class Account {
  String id;
  String name;
  String imagePath;
  String selfIntroduction;
  String userId;
  String age;
  Timestamp? createdTime;
  Timestamp? updatedTime;

  Account(
      {this.id = '',
      this.name = '',
      this.imagePath = '',
      this.selfIntroduction = '',
      this.userId = '',
      this.age = '',
      this.createdTime,
      this.updatedTime});
}
