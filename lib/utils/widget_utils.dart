import 'package:flutter/material.dart';

class WidgetUtils {
  static AppBar createAppBar(String title) {
    return AppBar(
      backgroundColor: Colors.cyan,
      iconTheme: IconThemeData(color: Colors.pinkAccent),
      title: Text(
        title,
        style: TextStyle(color: Colors.pinkAccent),
      ),
    );
  }
}
