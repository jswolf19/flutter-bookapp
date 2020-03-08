import 'package:flutter/material.dart';

class FavoriteWidget extends StatefulWidget {
  @override
  _FavoriteWidgetState createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  int count = 41;
  bool isSelected = false;

  void onPressed() {
    setState(() {
      count = count + 1;
      isSelected = true;
    });
  }

  IconData starIconData() {
    if (isSelected) {
      return Icons.star;
    } else {
      return Icons.star_border;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text('$count'),
        IconButton(
          icon: Icon(
            starIconData(),
            color: Colors.red,
          ),
          onPressed: onPressed,
        ),
      ],
    );
  }
}
