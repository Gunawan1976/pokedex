import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserStorageWrapper{
  Future<void> deleteAllField() async {
    return await UserSecureStorage.deleteAllField();
  }

  Future<void> deleteField(String value) async {
    return await UserSecureStorage.deleteField(value);
  }

  Future setField(String key, value) async {
    await UserSecureStorage.setField(key,value);
  }

  Future getField(String key) async {
    return await UserSecureStorage.getField(key);
  }

  // Future<void> saveUser(UserEntities? user,key) async {
  //   await UserSecureStorage.saveUser(key:key,user: user);
  // }
  //
  // Future<UserEntities> getUser(String key) async {
  //   UserEntities user = await UserSecureStorage.getUser(key) ?? UserEntities();
  //   return user;
  // }
}

class UserSecureStorage {
  static final _storage = FlutterSecureStorage(
    aOptions: const AndroidOptions(
      encryptedSharedPreferences: true,
    ),
  );

  static Future<void> setField(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  // static Future<void> saveUser({UserEntities? user,required String key}) async {
  //   final userJson = jsonEncode(user?.toJson());
  //   await _storage.write(key: key, value: userJson);
  // }
  //
  // static Future<UserEntities?> getUser(String key) async {
  //   final String? userJson = await _storage.read(key: key);
  //   if (userJson != null) {
  //     final Map<String, dynamic> userMap = jsonDecode(userJson);
  //     return UserEntities.fromJson(userMap);
  //   }
  //   return null;
  // }

  static Future<void> clearUser(String key) async {
    await _storage.delete(key: key);
  }


  static Future<String?> getField(String key) async {
    try {
      return await _storage.read(key: key);
    } catch (e) {
      if (e is PlatformException && e.code == 'BadPaddingException') {
        await _storage.deleteAll();
      }

      return null;
    }
  }

  static Future<void> deleteAllField() async {
    return await _storage.deleteAll();
  }

  static Future<void> deleteField(String key) async {
    return await _storage.delete(key: key);
  }
}