import 'package:equatable/equatable.dart';
import 'package:pokemon_app/model/pokemon_model.dart';

class PokemonListResponseModel with EquatableMixin {
  PokemonListResponseModel({
    this.count,
    this.next,
    this.previous,
    this.results,
    this.message,
  });

  int count;
  String next;
  String previous;
  String message;
  List<PokemonModel> results;

  factory PokemonListResponseModel.fromJson(Map<String, dynamic> json) =>
      PokemonListResponseModel(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: List<PokemonModel>.from(
            json["results"].map((x) => PokemonModel.fromJson(x))),
      );

  PokemonListResponseModel.withError(String value)
      : message = value,
        count = 0,
        results = [];

  @override
  List<Object> get props => [count, next, previous, message, results];
}
