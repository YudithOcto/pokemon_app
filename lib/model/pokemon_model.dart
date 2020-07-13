import 'package:equatable/equatable.dart';

class PokemonModel with EquatableMixin {
  PokemonModel({
    this.name,
    this.url,
  });

  String name;
  String url;

  factory PokemonModel.fromJson(Map<String, dynamic> json) => PokemonModel(
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
