import '../../../home/domain/entities/pokemon_entity.dart';
import '../repositories/favourite_repository.dart';

class GetFavouritesUseCase {
  final FavouriteRepository repository;

  GetFavouritesUseCase(this.repository);

  Future<List<PokemonEntity>> call() async {
    return await repository.getFavourites();
  }
}
