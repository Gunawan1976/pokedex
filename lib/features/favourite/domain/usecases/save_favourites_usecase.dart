import '../../../home/domain/entities/pokemon_entity.dart';
import '../repositories/favourite_repository.dart';

class SaveFavouritesUseCase {
  final FavouriteRepository repository;

  SaveFavouritesUseCase(this.repository);

  Future<void> call(List<PokemonEntity> favourites) async {
    return await repository.saveFavourites(favourites);
  }
}
