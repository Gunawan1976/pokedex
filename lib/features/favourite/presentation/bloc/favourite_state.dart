part of 'favourite_bloc.dart';

sealed class FavouriteState {}

final class FavouriteInitial extends FavouriteState {}

final class FavouriteLoaded extends FavouriteState {
  final List<PokemonEntity> favourites;
  
  FavouriteLoaded(this.favourites);
  
  bool isFavourite(String pokemonId) {
    return favourites.any((p) => p.id == pokemonId);
  }
}
