import 'package:flutter/material.dart';
import 'screens/newsList.dart';
import 'screens/newsDetails.dart';
import 'blocs/storiesProvider.dart';
import 'blocs/commentsProvider.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoriesProvider(
        child: CommentsProvider(
      child: MaterialApp(
        onGenerateRoute: routes,
      ),
    ));
  }

  Route routes(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(builder: (context) {
        final storiesBloc = StoriesProvider.of(context);
        storiesBloc.fetchTopIds();
        return Scaffold(
          appBar: AppBar(title: Text('Top Stories')),
          body: NewsList(),
        );
      });
    } else {
      final int itemId = int.parse(settings.name.replaceFirst('/', ''));
      return MaterialPageRoute(
        builder: (context) {
          final commentsBloc = CommentsProvider.of(context);
          commentsBloc.fetchItemWithComments(itemId);
          return Scaffold(
            appBar: AppBar(
              title: Text('Details'),
            ),
            body: NewsDetails(
              itemId: itemId,
            ),
          );
        },
      );
    }
  }
}
