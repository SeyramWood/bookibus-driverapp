import 'dart:convert';

import 'package:bookihub/main.dart';
import 'package:bookihub/src/shared/constant/base_url.dart';
import 'package:bookihub/src/shared/errors/custom_exception.dart';
import 'package:bookihub/src/shared/utils/interceptor.dart';

import '../domain/entities/trip_model.dart';

HttpClientWithInterceptor client = locator<HttpClientWithInterceptor>();

class TripApiService {
//fetch available trips by a driver
  Future<List<Trip>> fetchTrips(
      bool today, bool scheduled, bool completed,) async {
    try {
      final url =
          "$baseUrl/trips/driver/12884901890?today=$today&scheduled=$scheduled&completed=$completed";
      final response = await client.get(url);
      if (response.statusCode != 200) {
        throw CustomException('${response.statusCode}');
      }
      return tripModelFromJson(response.body).data.trip;
    } catch (e) {
      rethrow;
    }
  }
}
