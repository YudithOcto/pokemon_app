import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pokemon_app/model/pokemon_form_response_model.dart';
import 'package:pokemon_app/presentation/homepage/providers/home_providers.dart';

import '../fake_response_model/response_model_reader.dart';

class MockProviders extends Mock implements HomeProviders {}

void main() {
  test('get pokemon detail', () async {
    final provider = MockProviders();
    when(provider.getPokemonForms('413')).thenAnswer((_) async =>
        PokemonFormResponseModel.fromJson(
            jsonDecode(responseModelReader('pokemon_form.json'))));
    expect(
        await provider.getPokemonForms('413'), isA<PokemonFormResponseModel>());
  });

  test('get pokemon detail failed', () async {
    final provider = MockProviders();
    when(provider.getPokemonForms('413'))
        .thenAnswer((_) async => PokemonFormResponseModel(message: 'Error'));
    expect(
        await provider.getPokemonForms('413'), isA<PokemonFormResponseModel>());
  });
}
