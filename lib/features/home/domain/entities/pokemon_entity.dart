import 'package:equatable/equatable.dart';

class PokemonEntity extends Equatable {
  final String id;
  final String name;
  final String imageUrl;
  final String xDescription;
  final String height;
  final String weight;
  final String category;
  final List<String> typeOfPokemon;
  final List<String> weaknesses;
  final List<String> evolutions;
  final List<String> abilities;
  final String malePercentage;
  final String femalePercentage;
  final int hp;
  final int attack;
  final int defense;
  final int specialAttack;
  final int specialDefense;
  final int speed;

  const PokemonEntity({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.xDescription,
    required this.height,
    required this.weight,
    required this.category,
    required this.typeOfPokemon,
    required this.weaknesses,
    required this.evolutions,
    required this.abilities,
    required this.malePercentage,
    required this.femalePercentage,
    required this.hp,
    required this.attack,
    required this.defense,
    required this.specialAttack,
    required this.specialDefense,
    required this.speed,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        imageUrl,
        xDescription,
        height,
        weight,
        category,
        typeOfPokemon,
        weaknesses,
        evolutions,
        abilities,
        malePercentage,
        femalePercentage,
        hp,
        attack,
        defense,
        specialAttack,
        specialDefense,
        speed,
      ];
}
