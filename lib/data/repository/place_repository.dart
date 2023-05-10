// ignore_for_file: body_might_complete_normally_nullable

import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:places/domain/exceptions.dart';
import 'package:places/domain/place.dart';
import 'package:places/data/model/place_dto.dart';
import 'package:places/data/model/places_filter_request_dto.dart';
import 'package:places/data/repository/place_repository_interface.dart';
import 'package:places/http_client_interface.dart';

//Репозиторий интересных мест
class PlaceRepository implements IPlaceRepository {
  final IHttpClient httpClient;

  PlaceRepository({required this.httpClient});
  @override
  Future<Place> addPlace(Place place) async {
    try {
      Completer<Place> completer = Completer();
      final response = await httpClient.dio.post(
        '/place',
        data: jsonEncode(
          place.toMap(),
        ),
      );
      if (response.statusCode == 200) {
        completer.complete(Place.fromMap(response.data));
      } else {
        throw NetworkException(
            errorCode: response.statusCode ?? 0,
            errorName: response.statusMessage ?? '',
            request: 'POST ${httpClient.dio.options.baseUrl}/place');
      }
      return completer.future;
    } on Exception catch (_) {
      rethrow;
    }
  }

  @override
  Future<List<Place>> getPlacesList() async {
    try {
      Completer<List<Place>> completer = Completer();
      final response = await httpClient.dio.get('/place');
      if (response.statusCode == 200) {
        List result = response.data;
        result = result.expand((e) => [Place.fromMap((e))]).toList();
        completer.complete(result as List<Place>);
      } else {
        throw NetworkException(
            errorCode: response.statusCode ?? 0,
            errorName: response.statusMessage ?? '',
            request: 'GET ${httpClient.dio.options.baseUrl}/place');
      }
      return completer.future;
    } on Exception catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> deletePlaceByID(final int id) async {
    try {
      Response response = await httpClient.dio.delete('/place/$id');
      if (response.statusCode == 200) {
        return;
      } else {
        throw NetworkException(
            errorCode: response.statusCode ?? 0,
            errorName: response.statusMessage ?? '',
            request: 'DELETE ${httpClient.dio.options.baseUrl}/place/$id');
      }
    } on Exception catch (_) {
      rethrow;
    }
  }

  @override
  Future<List<Place>> getFilteredPlaces(
      final PlacesFilterRequestDto filter) async {
    try {
      Completer<List<Place>> completer = Completer();

      final response = await httpClient.dio.post(
        '/filtered_places',
        data: jsonEncode(
          filter.toMap(),
        ),
      );
      if (response.statusCode == 200) {
        List result = response.data;
        result = result
            .expand((e) => [
                  Place.fromPlaceDTO(PlaceDto.fromMap(e)),
                ])
            .toList();
        completer.complete(result as List<Place>?);
      } else {
        throw NetworkException(
            errorCode: response.statusCode ?? 0,
            errorName: response.statusMessage ?? '',
            request: 'POST ${httpClient.dio.options.baseUrl}/filtered_places');
      }
      return completer.future;
    } on Exception catch (_) {
      rethrow;
    }
  }

  @override
  Future<Place> getPlaceByID(final int id) async {
    try {
      Completer<Place> completer = Completer();
      final Response<dynamic> response = await httpClient.dio.get('/place/$id');
      if (response.statusCode == 200) {
        completer.complete(
          Place.fromMap(response.data),
        );
      } else {
        throw NetworkException(
            errorCode: response.statusCode ?? 0,
            errorName: response.statusMessage ?? '',
            request: 'GET ${httpClient.dio.options.baseUrl}place/$id');
      }

      return completer.future;
    } on Exception catch (_) {
      rethrow;
    }
  }

  @override
  Future<List<String>> uploadFile(final String bytes) async {
    try {
      httpClient.dio.options.contentType = 'multipart/form-data';
      final Response response =
          await httpClient.dio.post('/upload_file', data: bytes);

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw NetworkException(
            errorCode: response.statusCode ?? 0,
            errorName: response.statusMessage ?? '',
            request: 'POST ${httpClient.dio.options.baseUrl}/upload_file');
      }
    } on Exception catch (_) {
      rethrow;
    } finally {
      httpClient.dio.options.contentType = 'application/json';
    }
  }

  @override
  Future<Place> updatePlaceByID(final Place place) async {
    try {
      Completer<Place> completer = Completer();
      Map<String, dynamic> request = place.toMap();
      // Невозможно изменить id на сервере
      request.remove('id');
      final Response response = await httpClient.dio.put(
        '/place/${place.id}',
        data: jsonEncode(
          request,
        ),
      );
      if (response.statusCode == 200) {
        completer.complete(
          Place.fromMap(response.data),
        );
      } else {
        throw NetworkException(
            errorCode: response.statusCode ?? 0,
            errorName: response.statusMessage ?? '',
            request:
                'PUT ${httpClient.dio.options.baseUrl}//place/${place.id}');
      }

      return completer.future;
    } on Exception catch (_) {
      rethrow;
    }
  }
}
