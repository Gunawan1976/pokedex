import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../home/data/models/pokemon_model.dart';

abstract class FavouriteLocalDataSource {
  Future<List<PokemonModel>> getFavourites();
  Future<void> cacheFavourites(List<PokemonModel> favourites);
}

class FavouriteLocalDataSourceImpl implements FavouriteLocalDataSource {
  final FlutterSecureStorage secureStorage;
  static const String cacheKey = 'CACHED_FAVOURITES';

  FavouriteLocalDataSourceImpl({required this.secureStorage});

  @override
  Future<List<PokemonModel>> getFavourites() async {
    final jsonString = await secureStorage.read(key: cacheKey);
    if (jsonString != null) {
      final List<dynamic> jsonList = json.decode(jsonString);
      return jsonList.map((json) => PokemonModel.fromJson(json)).toList();
    } else {
      return [];
    }
  }

  @override
  Future<void> cacheFavourites(List<PokemonModel> favourites) async {
    final List<Map<String, dynamic>> jsonList = favourites.map((model) => model.toJson()).toList();
    final jsonString = json.encode(jsonList);
    await secureStorage.write(key: cacheKey, value: jsonString);
  }
}
