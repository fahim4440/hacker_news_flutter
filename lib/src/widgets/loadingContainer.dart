import 'package:flutter/material.dart';

class LoadingContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Container(
        height: 20.0,
        width: 80.0,
        color: Colors.grey[200],
      ),
      subtitle: Container(
        height: 14.0,
        width: 30.0,
        color: Colors.grey[200],
      ),
      trailing: Container(
        height: 34.0,
        width: 34.0,
        color: Colors.grey[200],
      ),
    );
  }
}
