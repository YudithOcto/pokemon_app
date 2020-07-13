import 'package:equatable/equatable.dart';

class PokemonFormResponseModel with EquatableMixin {
  PokemonFormResponseModel({
    this.formName,
    this.name,
    this.sprites,
    this.message,
  });

  String formName;
  String name;
  Sprites sprites;
  String message;

  factory PokemonFormResponseModel.fromJson(Map<String, dynamic> json) =>
      PokemonFormResponseModel(
        formName: json["form_name"],
        name: json["name"],
        sprites: Sprites.fromJson(json["sprites"]),
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
