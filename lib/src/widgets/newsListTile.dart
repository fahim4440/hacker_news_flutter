import 'package:flutter/material.dart';
import '../blocs/storiesProvider.dart';
import '../models/itemModel.dart';
import 'loadingContainer.dart';

class NewsListTile extends StatelessWidget {
  final int itemId;

  NewsListTile(this.itemId);

  @override
  Widget build(BuildContext context) {
    final bloc = StoriesProvider.of(context);
    return StreamBuilder(
      stream: bloc.item,
      builder: (context, AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
        if (!snapshot.hasData) {
          return LoadingContainer();
        }
        return FutureBuilder(
          future: snapshot.data[itemId],
          builder: (context, itemSnapShot) {
            if (!itemSnapShot.hasData) {
              return LoadingContainer();
            }
            return Column(
              children: <Widget>[
                ListTile(
                  onTap: () {
                    Navigator.pushNamed(context, '/$itemId');
                  },
                  title: Text('${itemSnapShot.data.title}'),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('${itemSnapShot.data.score} points'),
                      Text('by ${itemSnapShot.data.by}'),
                      Text('type: ${itemSnapShot.data.type}'),
                    ],
                  ),
                  trailing: Column(
                    children: <Widget>[
                      Icon(Icons.comment),
                      Text('${itemSnapShot.data.kids.length}'),
                    ],
                  ),
                ),
                Divider(),
              ],
            );
          },
        );
      },
    );
  }
}
