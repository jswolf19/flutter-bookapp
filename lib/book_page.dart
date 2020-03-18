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
  String text = '検索条件を入力してください。';
  List<Book> books = List();
  TextEditingController _controller = TextEditingController();
  FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget results;
    if(books.length == 0) {
      results = Text(text);
    } else {
      results = Wrap(
        children: _buildBooks(),
      );
    }

    return Scaffold(
      appBar:  AppBar(
        title: Text('Book App'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _buildTextField(),
            results,
          ],
        ),
      ),
    );
  }

  Widget _buildTextField() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _controller,
              focusNode: _focusNode,
            ),
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: _onPressed,
          )
        ],
      )
    );
  }

  void _onPressed() async {
    _focusNode.unfocus();

    setState(() {
      text = '読み込み中…';
      books = List();
    });

    GoogleBookConnection conn = GoogleBookConnection();
    List<Book> results = await conn.requestSearchBooks(_controller.text);
    setState(() {
      if(results.length > 0) {
        books = results;
      } else {
        text = '条件を満たす結果はありません。';
      }
    });
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
