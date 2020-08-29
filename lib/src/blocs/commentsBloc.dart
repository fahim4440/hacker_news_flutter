import 'dart:async';
import 'package:news/src/blocs/commentsProvider.dart';
import 'package:rxdart/rxdart.dart';
import '../providers/repository.dart';
import '../models/itemModel.dart';

class CommentsBloc {
  final _repository = Repository();
  final _commentsFetcher = PublishSubject<int>();
  final _commentsOutput = BehaviorSubject<Map<int, Future<ItemModel>>>();

  //streams
  Stream<Map<int, Future<ItemModel>>> get itemWithComments =>
      _commentsOutput.stream;

  //sinks
  Function(int) get fetchItemWithComments => _commentsFetcher.sink.add;

  CommentsBloc() {
    _commentsFetcher.stream
        .transform(_itemFetchTransformer())
        .pipe(_commentsOutput);
  }

  _itemFetchTransformer() {
    return ScanStreamTransformer<int, Map<int, Future<ItemModel>>>(
        (cache, int id, index) {
      cache[id] = _repository.fetchItem(id);
      cache[id].then((ItemModel item) => item.kids.forEach((kidId) => fetchItemWithComments(kidId)));
      return cache;
    }, <int, Future<ItemModel>>{});
  }

  dispose() {
    _commentsFetcher.close();
    _commentsOutput.close();
  }
}
