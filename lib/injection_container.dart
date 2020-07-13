import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pokemon_app/api/api_helper.dart';

final singleton = GetIt.instance;

Future<void> initialization() async {
  singleton
      .registerLazySingleton<ApiHelper>(() => ApiHelperImpl(dio: singleton()));
  singleton.registerLazySingleton(() => Dio());
}
