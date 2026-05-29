import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/pokemon_model.dart';

abstract class HomeLocalDataSource {
  Future<List<PokemonModel>?> getCachedPokemons();
  Future<void> cachePokemons(List<PokemonModel> pokemons);
}

class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  final FlutterSecureStorage secureStorage;
  static const _cacheKey = 'cached_pokemons';

  HomeLocalDataSourceImpl({required this.secureStorage});

  @override
  Future<List<PokemonModel>?> getCachedPokemons() async {
    try {
      final jsonString = await secureStorage.read(key: _cacheKey);
      if (jsonString != null && jsonString.isNotEmpty) {
        final List<dynamic> jsonList = json.decode(jsonString);
        return jsonList.map((e) => PokemonModel.fromJson(e as Map<String, dynamic>)).toList();
      }
    } catch (e) {
      // Ignore cache errors
    }
    return null;
  }

  @override
  Future<void> cachePokemons(List<PokemonModel> pokemons) async {
    try {
      final jsonList = pokemons.map((e) => e.toJson()).toList();
      final jsonString = json.encode(jsonList);
      await secureStorage.write(key: _cacheKey, value: jsonString);
    } catch (e) {
      // Ignore cache errors
    }
  }
}
