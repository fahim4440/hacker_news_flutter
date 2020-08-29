import 'package:flutter/material.dart';

class LoadingComment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 20.0, top: 20.0),
          height: 80.0,
          color: Colors.grey[200],
        ),
        Container(
          margin: EdgeInsets.only(left: 32.0, right: 16.0),
          height: 80.0,
          color: Colors.grey[200],
        ),
      ],
    );
  }
}
