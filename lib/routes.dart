import 'package:flutter/material.dart';
import 'package:pokemon_app/presentation/detail/pokemon_detail_page.dart';
import 'package:pokemon_app/presentation/homepage/home_page.dart';

Map<String, WidgetBuilder> get routes {
  return {
    HomePage.routeName: (_) => HomePage(),
    PokemonDetailPage.routeName: (_) => PokemonDetailPage(),
  };
}
