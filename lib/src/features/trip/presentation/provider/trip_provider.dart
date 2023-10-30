import 'package:bookihub/src/features/trip/domain/entities/trip_model.dart';
import 'package:bookihub/src/features/trip/domain/usecase/fetch_trip.dart';
import 'package:bookihub/src/shared/errors/failure.dart';
import 'package:bookihub/src/shared/utils/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

class TripProvider extends ChangeNotifier {
  final FetchTrips _fetchTrips;

  TripProvider({required FetchTrips fetchTrips}) : _fetchTrips = fetchTrips;
  //fetch trips by driver
  Future<Either<Failure, List<Trip>>> fetchTrips(
    bool today,
    bool scheduled,
    bool completed,
  ) async {
    final result = await _fetchTrips(MultiParams(
      today,
      scheduled,
      data3: completed,
    ));
    return result.fold(
      (failure) => Left(Failure(failure.message)),
      (success) {
        print(success.first.company.name);
        return Right(success);
      },
    );
  }
}
