import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pokemon_app/api/api_helper.dart';
import 'package:pokemon_app/presentation/detail/providers/pokemon_detail_provider.dart';
import 'package:pokemon_app/presentation/homepage/providers/home_providers.dart';

final singleton = GetIt.instance;

Future<void> initialization() async {
  final dio = Dio();
  singleton.registerLazySingleton(() => dio);
  singleton
      .registerLazySingleton<ApiHelper>(() => ApiHelperImpl(dio: singleton()));

  singleton.registerFactory(() => HomeProviders(apiProvider: singleton()));
  singleton
      .registerFactory(() => PokemonDetailProvider(apiHelper: singleton()));
}
