import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BookPage extends StatefulWidget {
  @override
  _BookPageState createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  String text = 'loading';
  List<String> books = List();

  @override
  void initState() {
    super.initState();

    requestSearchBooks();
  }

  void requestSearchBooks() async {
    final response = await http.get('https://www.googleapis.com/books/v1/volumes/?q=factfulness');
    final body = response.body;
    Map result = json.decode(body);
    List items = result["items"];

    for(int i = 0; i < items.length; i++) {
      Map item = items[i];
      print(item["volumeInfo"]["title"]);
      books.add(item["volumeInfo"]["title"]);
    }

    setState(() {
      text = items[0].toString();
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
