import 'package:bookapp/calil_connection.dart';
import 'package:flutter/material.dart';
import 'book.dart';

class BookCard extends StatefulWidget {
  BookCard({this.book, conn}) : _conn = conn;

  final Book book;
  final CalilConnection _conn;

  @override
  _BookCardState createState() => _BookCardState();

  void check() {
    _conn.check(book);
  }
}

class _BookCardState extends State<BookCard> {
  @override
  Widget build(BuildContext context) {
    final contentWidth = MediaQuery.of(context).size.width / 2;

    return Container(
      padding: EdgeInsets.all(8),
      width: contentWidth,
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: widget.check,
            child: SizedBox(
              width: 120,
              child: Image.network(widget.book.imageUrl),
            ),
          ),
          Text(widget.book.title)
        ],
      ),
    );
  }
}
