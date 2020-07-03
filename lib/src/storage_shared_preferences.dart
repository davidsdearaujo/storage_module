import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

import 'storage_interface.dart';

class StorageSharedPreferences implements IStorage {
  final _instance = Completer<SharedPreferences>();

  StorageSharedPreferences(){
    _initInstance();
  }

  Future<void> _initInstance() async {
    final instance = await SharedPreferences.getInstance();
    _instance.complete(instance);
  }

  @override
  Future<bool> containsKey(String key) async {
    final instance = await _instance.future;
    return instance.containsKey(key);
  }

  @override
  Future<dynamic> get(String key) async {
    final instance = await _instance.future;
    return instance.get(key);
  }

  @override
  Future<void> put(String key, dynamic value) async {
    final instance = await _instance.future;
    await instance.setString(key, value?.toString());
  }

  @override
  Future<void> clear() async {
    final instance = await _instance.future;
    await instance.clear();
  }

  @override
  Future<void> remove(String key) async {
    final instance = await _instance.future;
    await instance.remove(key);
  }
}
