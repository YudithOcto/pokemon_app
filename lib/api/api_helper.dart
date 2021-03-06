import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pokemon_app/model/pokemon_detail_model.dart';
import 'package:pokemon_app/utils/constant.dart';
import 'package:pokemon_app/model/pokemon_form_response_model.dart';
import 'package:pokemon_app/model/pokemon_list_response_model.dart';

abstract class ApiHelper {
  Future<PokemonListResponseModel> getPokemonList(int offset);
  Future<PokemonFormResponseModel> getPokemonFormDetail(String pokemonId);
  Future<PokemonDetailModel> getPokemonDetail(String url);
}

class ApiHelperImpl extends ApiHelper {
  final Dio dio;

  ApiHelperImpl({@required this.dio}) {
    _getOptionRequest();
  }

  _getOptionRequest() async {
    dio
      ..options
      ..options.receiveTimeout = 20000
      ..options.connectTimeout = 20000
      ..interceptors.add(LogInterceptor(
        responseBody: true,
      ))
      ..options.baseUrl = kBaseUrl;
  }

  String _handleError(DioError error) {
    String errorDescription = "";
    switch (error.type) {
      case DioErrorType.CANCEL:
        errorDescription = "Request to API server was cancelled";
        break;
      case DioErrorType.CONNECT_TIMEOUT:
        errorDescription = "Connection timeout with API server";
        break;
      case DioErrorType.DEFAULT:
        errorDescription =
            "Connection to API server failed due to internet connection";
        break;
      case DioErrorType.RECEIVE_TIMEOUT:
        errorDescription = "Receive timeout in connection with API server";
        break;
      case DioErrorType.RESPONSE:
        errorDescription =
            'Request failed with status code ${error.response.statusCode}';
        break;
      case DioErrorType.SEND_TIMEOUT:
        errorDescription = "Request to API Timeout";
        break;
      default:
        errorDescription = "Unexpected Error";
        break;
    }
    return errorDescription;
  }

  @override
  Future<PokemonListResponseModel> getPokemonList(int offset) async {
    try {
      final response = await dio.get('pokemon', queryParameters: {
        'limit': 10,
        'offset': offset,
      });
      return PokemonListResponseModel.fromJson(response.data);
    } catch (error) {
      if (error is DioError) {
        return PokemonListResponseModel.withError(_handleError(error));
      } else {
        return PokemonListResponseModel.withError(error.toString());
      }
    }
  }

  @override
  Future<PokemonFormResponseModel> getPokemonFormDetail(
      String pokemonId) async {
    try {
      final response = await dio.get('pokemon-form/$pokemonId');
      return PokemonFormResponseModel.fromJson(response.data);
    } catch (error) {
      if (error is DioError) {
        return PokemonFormResponseModel.withError(_handleError(error));
      } else {
        return PokemonFormResponseModel.withError(error.toString());
      }
    }
  }

  @override
  Future<PokemonDetailModel> getPokemonDetail(String url) async {
    try {
      final response = await dio.get(url);
      return PokemonDetailModel.fromJson(response.data);
    } catch (error) {
      if (error is DioError) {
        return PokemonDetailModel.withError(_handleError(error));
      } else {
        return PokemonDetailModel.withError(error.toString());
      }
    }
  }
}
