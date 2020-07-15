import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pokemon_app/model/pokemon_model.dart';

class PokemonFormResponseModel with EquatableMixin {
  PokemonFormResponseModel({
    this.formName,
    this.name,
    this.sprites,
    this.message,
    this.pokemonModel,
    this.pokemonColor,
  });

  String formName;
  String name;
  Sprites sprites;
  String message;
  PokemonModel pokemonModel;
  Color pokemonColor;

  factory PokemonFormResponseModel.fromJson(Map<String, dynamic> json) =>
      PokemonFormResponseModel(
        formName: json["form_name"],
        name: json["name"],
        pokemonModel: json['pokemon'] == null
            ? null
            : PokemonModel.fromJson(json['pokemon']),
        sprites:
            json['sprites'] == null ? null : Sprites.fromJson(json["sprites"]),
      );

  PokemonFormResponseModel.withError(String value) : message = value;

  Map<String, dynamic> toJson() => {
        "form_name": formName,
        "name": name,
        "sprites": sprites.toJson(),
      };

  @override
  List<Object> get props => [formName, name, sprites, message];
}

class Sprites with EquatableMixin {
  Sprites({
    this.frontDefault,
  });

  String frontDefault;

  factory Sprites.fromJson(Map<String, dynamic> json) => Sprites(
        frontDefault: json["front_default"],
      );

  Map<String, dynamic> toJson() => {
        "front_default": frontDefault,
      };

  @override
  List<Object> get props => [frontDefault];
}
