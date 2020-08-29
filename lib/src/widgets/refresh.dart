import 'package:flutter/material.dart';
import '../blocs/storiesProvider.dart';

class Refresh extends StatelessWidget {
  Widget child;
  Refresh({this.child});

  @override
  Widget build(BuildContext context) {
    final bloc = StoriesProvider.of(context);
    return RefreshIndicator(
      child: child,
      onRefresh: () async {
        await bloc.clearCachesDb();
        await bloc.fetchTopIds();
      }
    );
  }
}
