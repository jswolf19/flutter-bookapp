import 'package:bookapp/calil_connection.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'book.dart';
import 'book_card.dart';
import 'secrets.dart' as secrets;

const _calilSystemId = 'Gifu_Minokamo';

class BookPage extends StatefulWidget {
  @override
  _BookPageState createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  List<Book> books = List();

  @override
  void initState() {
    super.initState();

    requestSearchBooks();
  }

  void requestSearchBooks() async {
    final response = await http.get('https://www.googleapis.com/books/v1/volumes/?q=かがみの孤城');
    final body = response.body;
    Map result = json.decode(body);
    List items = result["items"];

    for(int i = 0; i < items.length; i++) {
      Map item = items[i];
      print(item["volumeInfo"]["title"]);
      try {
        List identifiers = item["volumeInfo"]["industryIdentifiers"];
        books.add(Book(
          title: item["volumeInfo"]["title"],
          imageUrl: item["volumeInfo"]["imageLinks"]["thumbnail"],
          isbn: identifiers.firstWhere((i) => i["type"] == "ISBN_13")["identifier"]
        ));
      } catch(error) {
        print(error);
      }
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Widget body;
    if(books.length == 0) {
      body = Text('loading');
    } else {
      body = SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _buildTextField(),
            Wrap(
                children: _buildBooks(),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar:  AppBar(
        title: Text('Book App'),
      ),
      body: body,
    );
  }

  Widget _buildTextField() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(),
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: null,
          )
        ],
      )
    );
  }

  List<Widget> _buildBooks() {
    List<Widget> bookWidgets = List();

    final CalilConnection conn = CalilConnection(
      appKey: secrets.getCalilAppKey(),
      systemId: _calilSystemId,
    );

    for(Book book in books) {
      bookWidgets.add(BookCard(
        book: book,
        conn: conn,
      ));
    }
    return bookWidgets;
  }
}
