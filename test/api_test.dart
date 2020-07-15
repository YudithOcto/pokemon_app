import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokemon_app/api/api_helper.dart';
import 'package:pokemon_app/injection_container.dart';
import 'package:pokemon_app/model/pokemon_detail_model.dart';
import 'package:pokemon_app/model/pokemon_form_response_model.dart';
import 'package:pokemon_app/model/pokemon_list_response_model.dart';
import 'fake_response_model/response_model_reader.dart';

void main() {
  ApiHelperImpl apiSuitTest;

  setUp(() {
    // Get It initialization here
    initialization();
    // Initialize api helper constructor
    apiSuitTest = ApiHelperImpl(dio: singleton());
  });

  test('get pokemon list data with paging', () async {
    final result = await apiSuitTest.getPokemonList(9);
    final expected = PokemonListResponseModel.fromJson(
        jsonDecode(responseModelReader('pokemon_list_paging.json')));

    expect(result, expected);
  });

  test('get pokemon form detail based on id (id = 413, wormadam-plant)',
      () async {
    final result = await apiSuitTest.getPokemonFormDetail('413');
    final expected = PokemonFormResponseModel.fromJson(
        jsonDecode(responseModelReader('pokemon_form.json')));

    expect(result, expected);
  });

  // make sure no null value if results is empty, parsing etc
  test('get pokemon list out of bounds', () async {
    final result = await apiSuitTest.getPokemonList(964);
    final expected = PokemonListResponseModel.fromJson(
        jsonDecode(responseModelReader('pokemon_list_end.json')));

    expect(result, expected);
  });

  test('get pokemon detail', () async {
    final result = await apiSuitTest.getPokemonDetail('pokemon/6');
    final expected = PokemonDetailModel.fromJson(
        jsonDecode(responseModelReader('pokemon_detail.json')));

    expect(result, expected);
  });
}
