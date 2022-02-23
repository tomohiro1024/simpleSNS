import 'package:flutter/material.dart';

class PostPage extends StatefulWidget {
  const PostPage({Key? key}) : super(key: key);

  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  TextEditingController contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'New Post',
          style: TextStyle(color: Colors.pinkAccent),
        ),
        backgroundColor: Colors.cyan,
        iconTheme: IconThemeData(color: Colors.amber),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            TextField(controller: contentController),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text(
                'Post',
                style: TextStyle(
                    color: Colors.pinkAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
              style: ElevatedButton.styleFrom(primary: Colors.cyan),
            )
          ],
        ),
      ),
    );
  }
}
