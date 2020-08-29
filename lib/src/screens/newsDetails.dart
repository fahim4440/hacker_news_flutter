import 'dart:async';
import 'package:flutter/material.dart';
import 'package:news/src/widgets/comment.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import '../blocs/commentsProvider.dart';
import '../models/itemModel.dart';
import '../widgets/loadingContainer.dart';

class NewsDetails extends StatelessWidget {
  final itemId;
  NewsDetails({this.itemId});
  @override
  Widget build(BuildContext context) {
    final bloc = CommentsProvider.of(context);
    return StreamBuilder(
      stream: bloc.itemWithComments,
      builder: (context, AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
        if (!snapshot.hasData) {
          return Text('Still Loading.....');
        }

        return FutureBuilder(
          future: snapshot.data[itemId],
          builder: (context, AsyncSnapshot<ItemModel> itemSnapshot) {
            if (!itemSnapshot.hasData) {
              return LoadingContainer();
            }
            return buildList(itemSnapshot.data, snapshot.data);
          },
        );
      },
    );
  }

  Widget buildList(ItemModel item, Map<int, Future<ItemModel>> itemMap) {
    final children = <Widget>[];
    children.add(buildDashboard(item));
    final commentsList = item.kids
        .map((kidId) => Comment(
              itemId: kidId,
              itemMap: itemMap,
              depth: 1,
            ))
        .toList();
    children.addAll(commentsList);
    return ListView(
      children: children,
    );
  }

  Widget buildDashboard(ItemModel item) {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.topCenter,
          margin: EdgeInsets.all(10.0),
          child: Text(
            '${item.title}',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          margin: EdgeInsets.all(10.0),
          child: Linkify(
            onOpen: (item) async {
              if (await canLaunch(item.url)) {
                await launch(item.url);
              } else {
                throw 'Could not launch $item.url';
              }
            },
            text: 'URL: ${item.url}',
          ),
        ),
        Container(
          alignment: Alignment.topLeft,
          margin: EdgeInsets.all(10.0),
          child: Text(
            'COMMENTS',
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
