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
      if(isSelected) {
        count-= 1;
        isSelected = false;
      } else {
        count+= 1;
        isSelected = true;
      }
    });
  }

  IconData starIconData() {
    return isSelected ? Icons.star : Icons.star_border;
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
