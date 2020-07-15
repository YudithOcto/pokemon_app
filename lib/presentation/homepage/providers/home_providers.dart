import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:pokemon_app/api/api_helper.dart';
import 'package:pokemon_app/api/state.dart';
import 'package:pokemon_app/model/pokemon_form_response_model.dart';
import 'package:pokemon_app/model/pokemon_model.dart';

class HomeProviders with ChangeNotifier {
  final ApiHelper _apiProvider;
  HomeProviders({@required ApiHelper apiProvider})
      : assert(apiProvider != null),
        _apiProvider = apiProvider;

  final _streamController = StreamController<apiState>.broadcast();
  Stream<apiState> get pokemonListStream => _streamController.stream;

  List<PokemonFormResponseModel> _pokemonList = [];
  List<PokemonFormResponseModel> get pokemonList => _pokemonList;

  int _offset = 0;

  bool _canLoadMore = true;
  bool get canLoadMore => _canLoadMore;

  Future<Null> getPokemonList({bool isRefresh = true}) async {
    if (isRefresh) {
      _canLoadMore = true;
      _pokemonList.clear();
      _offset = 0;
    }
    if (!_canLoadMore) return;
    _streamController.add(apiState.loading);
    final result = await _apiProvider.getPokemonList(_offset);
    if (result.message == null) {
      _canLoadMore = result.next != null;
      _offset += 10;
      transformListPokemonAndGetPokemonForms(result.results);
    }
  }

  transformListPokemonAndGetPokemonForms(List<PokemonModel> pokemonList) async {
    final listIds = pokemonList.map((e) => e.url.split('/')[6]).toList();
    final data = listIds.map((e) => getPokemonForms(e)).toList();
    final futures = Future.wait(data);
    final _futuresResult = await futures;
    addColorsToPokemon(_futuresResult);
  }

  addColorsToPokemon(List<PokemonFormResponseModel> model) async {
    final data = model.map((e) async {
      if (e.sprites != null && e.sprites.frontDefault != null) {
        return await _paletteGenerator(e?.sprites?.frontDefault);
      }
      return null;
    });
    final listAddColor = Future.wait(data);
    pokemonBackgroundColor.addAll(await listAddColor);
    _pokemonList.addAll(model);
    _streamController.add(apiState.success);
    notifyListeners();
  }

  List<PaletteGenerator> pokemonBackgroundColor = [];

  Future<PokemonFormResponseModel> getPokemonForms(String id) async {
    return await _apiProvider.getPokemonFormDetail(id);
  }

  Future<PaletteGenerator> _paletteGenerator(String image) async {
    PaletteGenerator _paletteGenerator =
        await PaletteGenerator.fromImageProvider(NetworkImage(image),
            size: Size(110, 50), maximumColorCount: 20);
    return _paletteGenerator;
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }
}
