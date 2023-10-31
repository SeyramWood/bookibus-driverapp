import 'dart:developer';

import 'package:bookihub/main.dart';
import 'package:bookihub/src/shared/constant/base_url.dart';
import 'package:bookihub/src/shared/errors/custom_exception.dart';
import 'package:bookihub/src/shared/utils/interceptor.dart';

import '../../domain/entities/trip_model.dart';

HttpClientWithInterceptor client = locator<HttpClientWithInterceptor>();

class TripApiService {
//fetch available trips by a driver
  Future<List<Trip>> fetchTrips(
    bool today,
    bool scheduled,
    bool completed,
  ) async {
    try {
      final url =
          "$baseUrl/trips/driver/12884901890?today=$today&scheduled=$scheduled&completed=$completed";
      final response = await client.get(url);
      if (response.statusCode != 200) {
        throw CustomException('${response.statusCode}');
      }
      return tripModelFromJson(response.body).data?.trip ?? [];
    } catch (e) {
      rethrow;
    }
  }

  //update trip status (started or ended)
  updateTripStatus(String tripId, String status) async {
    final url = "$baseUrl/trips/$tripId/update-status?status=$status";
    try {
      final response = await client.put(url);
      if (response.statusCode != 200) {
        throw CustomException('couldn\t perform action.\nTry again.');
      }
      log(response.body.toString());
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  updateInspectionStatus(
    String tripId,
    InspectionStatus inspectionStatus,
  ) async {
    final url = "$baseUrl/trips/$tripId/update-inspection";
    try {
      final response = await client.put(url, body: inspectionStatus.toJson());
      if (response.statusCode != 200) {
        log(response.body.toString());

        throw CustomException('couldn\t perform action.\nTry again.');
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
