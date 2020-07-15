import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:pokemon_app/api/api_helper.dart';
import 'package:pokemon_app/model/pokemon_detail_model.dart';

class PokemonDetailProvider with ChangeNotifier {
  final ApiHelper _apiHelper;
  PokemonDetailProvider({ApiHelper apiHelper})
      : assert(apiHelper != null),
        _apiHelper = apiHelper;

  Future<PokemonDetailModel> getPokemonDetail(String url) async {
    return await _apiHelper.getPokemonDetail(url);
  }
}
