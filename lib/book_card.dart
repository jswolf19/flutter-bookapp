import 'package:bookapp/calil_connection.dart';
import 'package:bookapp/library_status.dart';
import 'package:flutter/material.dart';
import 'book.dart';

class BookCard extends StatefulWidget {
  BookCard({this.book, conn}) : _conn = conn;

  final Book book;
  final CalilConnection _conn;

  @override
  _BookCardState createState() => _BookCardState();

  Future<Iterable<LibraryStatus>> check() {
    return _conn.check(book);
  }
}

class _BookCardState extends State<BookCard> {
  List<LibraryStatus> _status = List();

  @override
  Widget build(BuildContext context) {
    final contentWidth = (MediaQuery.of(context).size.width / 2) - 8;

    return Container(
      margin: EdgeInsets.all(4),
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
          border: Border.all()
      ),
      width: contentWidth,
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: _onTap,
            child: SizedBox(
              width: 120,
              child: Image.network(widget.book.imageUrl),
            ),
          ),
          Text(widget.book.title),
          for(LibraryStatus status in _status)
            _buildLibraryStatus(status)
        ],
      ),
    );
  }

  void _onTap() async {
    List status = (await widget.check()).toList();
    setState(() {
      _status = status;
    });
  }

  Widget _buildLibraryStatus(LibraryStatus status) {
    return Row(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 10),
          width: 100,
          child: Text(status.library)
        ),
        Text(status.status),
      ],
    );
  }
}
