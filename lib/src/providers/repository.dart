import 'newsApiProvider.dart';
import 'newsDbProvider.dart';
import '../models/itemModel.dart';

class Repository {
  List<Source> sources = <Source>[dbProvider, NewsApiProvider()];
  List<Cache> caches = <Cache>[dbProvider];

  Future<List<int>> fetchTopIds() {
    return sources[1].fetchTopIds();
  }

  Future<ItemModel> fetchItem(int id) async {
    Source source;
    ItemModel item;

    for (source in sources) {
      item = await source.fetchItem(id);
      if (item != null) {
        break;
      }
    }
    // item = await sources[0].fetchItem(id);
    // if (item == null) {
    //   item = await sources[1].fetchItem(id);
    // }

    for (var cache in caches) {
      if ((cache as Source) != source) {
        cache.addItem(item);
      }
    }

    return item;
  }

  Future<int> clearCaches() async {
    for (var cache in caches) {
      await cache.clearDb();
    }
  }
}

abstract class Source {
  Future<List<int>> fetchTopIds();
  Future<ItemModel> fetchItem(int id);
}

abstract class Cache {
  Future<int> addItem(ItemModel item);
  Future<int> clearDb();
}
