import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BookPage extends StatefulWidget {
  @override
  _BookPageState createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  String text = 'loading';

  @override
  void initState() {
    super.initState();

    requestSearchBooks();
  }

  void requestSearchBooks() async {
    final response = await http.get('https://www.googleapis.com/books/v1/volumes/?q=factfulness');
    setState(() {
      text = response.body;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: Text('Book App'),
      ),
      body: Text(text),
    );
  }
}
