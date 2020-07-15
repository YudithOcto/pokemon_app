import 'package:equatable/equatable.dart';
import 'package:pokemon_app/model/pokemon_model.dart';

class PokemonDetailModel with EquatableMixin {
  PokemonDetailModel({
    this.abilities,
    this.baseExperience,
    this.height,
    this.id,
    this.name,
    this.stats,
    this.types,
    this.weight,
    this.message,
    this.pokemonImage,
    this.species,
  });

  List<Ability> abilities;
  int baseExperience;
  int height;
  int id;
  String name;
  List<Stat> stats;
  List<Type> types;
  String pokemonImage;
  int weight;
  String message;
  PokemonModel species;

  factory PokemonDetailModel.fromJson(Map<String, dynamic> json) =>
      PokemonDetailModel(
        abilities: json["abilities"] == null
            ? []
            : List<Ability>.from(
                json["abilities"].map((x) => Ability.fromJson(x))),
        baseExperience: json["base_experience"],
        height: json["height"],
        id: json["id"],
        name: json["name"],
        stats: json["stats"] == null
            ? []
            : List<Stat>.from(json["stats"].map((x) => Stat.fromJson(x))),
        types: json['types'] == null
            ? []
            : List<Type>.from(json["types"].map((x) => Type.fromJson(x))),
        weight: json["weight"],
        pokemonImage: json['sprites']['front_default'] == null
            ? null
            : json['sprites']['front_default'],
        species: json['species'] == null
            ? null
            : PokemonModel.fromJson(json['species']),
      );

  PokemonDetailModel.withError(String value) : message = value;

  @override
  List<Object> get props => [
        abilities,
        baseExperience,
        height,
        id,
        name,
        stats,
        types,
        weight,
        message,
        pokemonImage,
        species,
      ];
}

class Ability with EquatableMixin {
  Ability({
    this.ability,
    this.isHidden,
    this.slot,
  });

  StatDetail ability;
  bool isHidden;
  int slot;

  factory Ability.fromJson(Map<String, dynamic> json) => Ability(
        ability: StatDetail.fromJson(json["ability"]),
        isHidden: json["is_hidden"],
        slot: json["slot"],
      );

  Map<String, dynamic> toJson() => {
        "ability": ability.toJson(),
        "is_hidden": isHidden,
        "slot": slot,
      };

  @override
  List<Object> get props => [ability, isHidden, slot];
}

class StatDetail with EquatableMixin {
  StatDetail({
    this.name,
    this.url,
  });

  String name;
  String url;

  factory StatDetail.fromJson(Map<String, dynamic> json) => StatDetail(
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
      };

  @override
  List<Object> get props => [name, url];
}

class Stat with EquatableMixin {
  Stat({
    this.baseStat,
    this.effort,
    this.stat,
  });

  int baseStat;
  int effort;
  StatDetail stat;

  factory Stat.fromJson(Map<String, dynamic> json) => Stat(
        baseStat: json["base_stat"],
        effort: json["effort"],
        stat: StatDetail.fromJson(json["stat"]),
      );

  Map<String, dynamic> toJson() => {
        "base_stat": baseStat,
        "effort": effort,
        "stat": stat.toJson(),
      };

  @override
  List<Object> get props => [baseStat, effort, stat];
}

class Type with EquatableMixin {
  Type({
    this.slot,
    this.type,
  });

  int slot;
  StatDetail type;

  factory Type.fromJson(Map<String, dynamic> json) => Type(
        slot: json["slot"],
        type: StatDetail.fromJson(json["type"]),
      );

  Map<String, dynamic> toJson() => {
        "slot": slot,
        "type": type.toJson(),
      };

  @override
  List<Object> get props => [slot, type];
}
