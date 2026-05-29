part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeLoaded extends HomeState {
  final List<PokemonEntity> allPokemons;
  final List<PokemonEntity> displayPokemons;
  final String searchQuery;
  final String? selectedType;

  HomeLoaded({
    required this.allPokemons,
    required this.displayPokemons,
    this.searchQuery = '',
    this.selectedType,
  });

  HomeLoaded copyWith({
    List<PokemonEntity>? allPokemons,
    List<PokemonEntity>? displayPokemons,
    String? searchQuery,
    String? selectedType,
    bool clearSelectedType = false,
  }) {
    return HomeLoaded(
      allPokemons: allPokemons ?? this.allPokemons,
      displayPokemons: displayPokemons ?? this.displayPokemons,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedType: clearSelectedType ? null : (selectedType ?? this.selectedType),
    );
  }
}

final class HomeError extends HomeState {
  final String message;
  HomeError({required this.message});
}
