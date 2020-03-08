import 'package:flutter/material.dart';
import 'book.dart';

class BookCard extends StatefulWidget {
  BookCard(this.book);

  final Book book;

  @override
  _BookCardState createState() => _BookCardState();
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
          SizedBox(
            width: 120,
            child: Image.network(widget.book.imageUrl),
          ),
          Text(widget.book.title)
        ],
      ),
    );
  }
}
