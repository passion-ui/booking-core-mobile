import 'package:realm/realm.dart';

class RelationalStorage {
  late Realm realm;

  Future<RelationalStorage> init() async {
    var config = Configuration.local([]);
    realm = Realm(config);
    return this;
  }

  Future<void> add<T>(T object) async {
    realm.write(() {
      realm.add(object as RealmObject);
    });
  }

  Future<List<T>> getAll<T extends RealmObject>() async {
    final objects = realm.all<T>();
    return objects.toList();
  }

  Future<T?> getById<T extends RealmObject>(ObjectId id) async {
    final object = realm.find<T>(id);
    return object;
  }

  Future<void> update<T>(T object) async {
    realm.write(() {
      realm.add(object as RealmObject, update: true);
    });
  }

  Future<void> delete<T>(T object) async {
    realm.write(() {
      realm.delete(object as RealmObject);
    });
  }

  Future<void> close() async {
    realm.close();
  }
}
