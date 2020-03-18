import 'package:bookapp/calil_connection.dart';
import 'package:bookapp/google_book_connection.dart';
import 'package:flutter/material.dart';
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

    GoogleBookConnection conn = GoogleBookConnection();
    conn.requestSearchBooks('かがみの孤城').then((results) {
      setState(() {
        books = results;
      });
    });
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
