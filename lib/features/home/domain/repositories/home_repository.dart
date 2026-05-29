import '../entities/pokemon_entity.dart';

abstract class HomeRepository {
  Future<List<PokemonEntity>> getPokemons();
}
