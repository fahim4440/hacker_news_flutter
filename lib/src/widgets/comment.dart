import 'package:flutter/material.dart';
import '../models/itemModel.dart';
import 'loadingComment.dart';

class Comment extends StatelessWidget {
  final int itemId;
  final int depth;
  final Map<int, Future<ItemModel>> itemMap;
  Comment({this.itemId, this.itemMap, this.depth});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: itemMap[itemId],
      builder: (context, AsyncSnapshot<ItemModel> snapshot) {
        if (!snapshot.hasData) {
          return LoadingComment();
        }
        final children = <Widget>[
          ListTile(
            title: snapshot.data.by == ''
                ? Text('Deleted by Moderator')
                : buildText('${snapshot.data.text}'),
            subtitle:
                snapshot.data.by == '' ? Text('') : Text('${snapshot.data.by}'),
            contentPadding: EdgeInsets.only(
              right: 16.0,
              left: depth * 16.0,
            ),
          ),
          Divider(),
        ];
        snapshot.data.kids.map((kidId) => children.add(Comment(
              itemId: kidId,
              itemMap: itemMap,
              depth: depth + 1,
            )));
        return Container(
          margin: EdgeInsets.all(10.0),
          child: Column(
            children: children,
          ),
        );
      },
    );
  }

  Widget buildText(String text) {
    final textM = text
        .replaceAll('&#x27;', "'")
        .replaceAll('<p>', '\n')
        .replaceAll('</p>', '')
        .replaceAll('&#x2F;', '/')
        .replaceAll('<a href=', '\n')
        .replaceAll('</a>', '')
        .replaceAll('&quot;', '"')
        .replaceAll('<i>', '')
        .replaceAll('</i>', '')
        .replaceAll('&gt;', '');

    return Text(textM);
  }
}
