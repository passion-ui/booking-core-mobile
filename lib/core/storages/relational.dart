import 'package:realm/realm.dart';

class RelationalStorage {
  final Realm realm;

  RelationalStorage(this.realm);

  static Future<RelationalStorage> init() async {
    final config = Configuration.local([]);
    return RelationalStorage(Realm(config));
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
