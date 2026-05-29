part of 'favourite_bloc.dart';

sealed class FavouriteEvent {}

class LoadFavouritesEvent extends FavouriteEvent {}

class ToggleFavouriteEvent extends FavouriteEvent {
  final PokemonEntity pokemon;
  ToggleFavouriteEvent(this.pokemon);
}
