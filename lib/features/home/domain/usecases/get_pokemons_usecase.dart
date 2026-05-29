import '../entities/pokemon_entity.dart';
import '../repositories/home_repository.dart';

class GetPokemonsUseCase {
  final HomeRepository repository;

  GetPokemonsUseCase(this.repository);

  Future<List<PokemonEntity>> call() async {
    return await repository.getPokemons();
  }
}
