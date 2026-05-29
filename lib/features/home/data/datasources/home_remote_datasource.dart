import 'dart:convert';
import 'package:dio/dio.dart';
import '../models/pokemon_model.dart';

abstract class HomeRemoteDataSource {
  Future<List<PokemonModel>> getPokemons();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final Dio dio;

  HomeRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<PokemonModel>> getPokemons() async {
    try {
      final response = await dio.get('https://gist.githubusercontent.com/hungps/0bfdd96d3ab9ee20c2e572e47c6834c7/raw/pokemons.json');
      
      if (response.statusCode == 200) {
        // the response data might be a string if not parsed properly by DIO, or already a List
        List<dynamic> jsonList;
        if (response.data is String) {
          jsonList = json.decode(response.data);
        } else {
          jsonList = response.data;
        }
        
        return jsonList.map((e) => PokemonModel.fromJson(e as Map<String, dynamic>)).toList();
      } else {
        throw Exception('Failed to load pokemons');
      }
    } catch (e) {
      throw Exception('Failed to load pokemons: $e');
    }
  }
}
