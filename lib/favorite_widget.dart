import 'package:flutter/material.dart';

class FavoriteWidget extends StatefulWidget {
  @override
  _FavoriteWidgetState createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text('41'),
        IconButton(
          icon: Icon(
            Icons.star_border,
            color: Colors.red,
          ),
          onPressed: null,
        ),
      ],
    );
  }
}
