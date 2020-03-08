import 'package:flutter/material.dart';

class BookmarkWidget extends StatefulWidget {
  @override
  _BookmarkWidgetState createState() => _BookmarkWidgetState();
}

class _BookmarkWidgetState extends State<BookmarkWidget> {
  bool isSelected = false;

  void onPressed() {
    setState(() {
      isSelected = !isSelected;
    });
  }

  IconData getIconData() {
    return isSelected ? Icons.bookmark : Icons.bookmark_border;
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(getIconData()),
      onPressed: onPressed,
    );
  }
}
