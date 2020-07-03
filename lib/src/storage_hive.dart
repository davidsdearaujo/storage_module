import 'dart:async';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'storage_interface.dart';

class StorageHive implements IStorage {
  final String boxName;

  final _box = Completer<Box>();

  StorageHive([this.boxName = "storage-box"]) {
    _initBox();
  }

  Future<void> _initBox() async {
    final dir = await getApplicationDocumentsDirectory();
    var path = dir.path;
    Hive.init(path);
    _box.complete(Hive.openBox(boxName));
  }

  @override
  Future<dynamic> get(String key) async {
    Map response = {};
    final box = await _box.future;
    if (box.containsKey(key)) {
      response = box.get(key);
    }
    return response["value"];
  }

  @override
  Future<void> put(String key, dynamic value) async {
    final box = await _box.future;
    await box.put(key, {"value": value});
  }

  @override
  Future<bool> containsKey(String key) async {
    final box = await _box.future;
    return key != null && box.containsKey(key);
  }

  @override
  Future<void> clear() async {
    final box = await _box.future;
    await box.clear();
  }

  @override
  Future<void> remove(String key) async {
    final box = await _box.future;
    await box.delete(key);
  }
}
