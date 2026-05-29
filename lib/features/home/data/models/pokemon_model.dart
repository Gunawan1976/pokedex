import '../../domain/entities/pokemon_entity.dart';

class PokemonModel extends PokemonEntity {
  const PokemonModel({
    required super.id,
    required super.name,
    required super.imageUrl,
    required super.xDescription,
    required super.height,
    required super.weight,
    required super.category,
    required super.typeOfPokemon,
    required super.weaknesses,
    required super.evolutions,
    required super.abilities,
    required super.malePercentage,
    required super.femalePercentage,
    required super.hp,
    required super.attack,
    required super.defense,
    required super.specialAttack,
    required super.specialDefense,
    required super.speed,
  });

  factory PokemonModel.fromJson(Map<String, dynamic> json) {
    return PokemonModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      imageUrl: json['imageurl'] ?? '',
      xDescription: json['xdescription'] ?? '',
      height: json['height'] ?? '',
      weight: json['weight'] ?? '',
      category: json['category'] ?? '',
      typeOfPokemon: List<String>.from(json['typeofpokemon'] ?? []),
      weaknesses: List<String>.from(json['weaknesses'] ?? []),
      evolutions: List<String>.from(json['evolutions'] ?? []),
      abilities: List<String>.from(json['abilities'] ?? []),
      malePercentage: json['male_percentage'] ?? '',
      femalePercentage: json['female_percentage'] ?? '',
      hp: json['hp'] ?? 0,
      attack: json['attack'] ?? 0,
      defense: json['defense'] ?? 0,
      specialAttack: json['special_attack'] ?? 0,
      specialDefense: json['special_defense'] ?? 0,
      speed: json['speed'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageurl': imageUrl,
      'xdescription': xDescription,
      'height': height,
      'weight': weight,
      'category': category,
      'typeofpokemon': typeOfPokemon,
      'weaknesses': weaknesses,
      'evolutions': evolutions,
      'abilities': abilities,
      'male_percentage': malePercentage,
      'female_percentage': femalePercentage,
      'hp': hp,
      'attack': attack,
      'defense': defense,
      'special_attack': specialAttack,
      'special_defense': specialDefense,
      'speed': speed,
    };
  }
}
