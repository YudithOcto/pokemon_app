import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
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
    _streamController.add(apiState.loading);
    final result =
        await _apiProvider.getPokemonList('pokemon?limit=10&offset=$_offset');
    if (result.message == null) {
      _canLoadMore = result.next != null;
      _offset += 10;
      transformListPokemonAndGetPokemonForms(result.results);
    }
    notifyListeners();
  }

  transformListPokemonAndGetPokemonForms(List<PokemonModel> pokemonList) async {
    final listIds = pokemonList.map((e) => e.url.split('/')[6]).toList();
    final data = listIds.map((e) => getPokemonForms(e)).toList();
    final futures = Future.wait(data);
    final _futuresResult = await futures;
    _pokemonList.addAll(_futuresResult);
    _streamController.add(apiState.success);
  }

  Future<PokemonFormResponseModel> getPokemonForms(String id) async {
    return await _apiProvider.getPokemonFormDetail('pokemon-form/$id');
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }
}

extension on String {
  String get pokemonId {
    print(this.split('/')[4]);
    return this.split('/').join();
  }
}
