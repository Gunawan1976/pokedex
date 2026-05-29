part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class GetPokemonsEvent extends HomeEvent {}

class SearchPokemonsEvent extends HomeEvent {
  final String query;
  SearchPokemonsEvent(this.query);
}

class FilterTypeEvent extends HomeEvent {
  final String? type;
  FilterTypeEvent(this.type);
}
