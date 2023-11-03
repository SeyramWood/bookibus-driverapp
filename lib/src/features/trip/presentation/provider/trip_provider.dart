import 'package:bookihub/src/features/trip/domain/entities/trip_model.dart';
import 'package:bookihub/src/features/trip/domain/usecase/fetch_trip.dart';
import 'package:bookihub/src/features/trip/domain/usecase/update_inspection_status.dart';
import 'package:bookihub/src/shared/errors/failure.dart';
import 'package:bookihub/src/shared/utils/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:bookihub/src/shared/constant/model.dart';

import '../../domain/usecase/update_trip_status.dart';

class TripProvider extends ChangeNotifier {
  final FetchTrips _fetchTrips;
  final UpdateTripStatus _updateTripStatus;
  final UpdateInspectionStatus _updateInspectionStatus;
  TripProvider(
      {required FetchTrips fetchTrips,
      required UpdateTripStatus updateTripStatus,
      required UpdateInspectionStatus inspectionStatus})
      : _fetchTrips = fetchTrips,
        _updateTripStatus = updateTripStatus,
        _updateInspectionStatus = inspectionStatus;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(loading) {
    _isLoading = loading;
  }

  //fetch trips by driver
  Future<Either<Failure, List<Trip>>> fetchTrips(
    bool today,
    bool scheduled,
    bool completed,
  ) async {
    _isLoading = true;
    notifyListeners();
    final result = await _fetchTrips(MultiParams(
      today,
      scheduled,
      data3: completed,
    ));
    return result.fold(
      (failure) {
        _isLoading = false;
        notifyListeners();
       return Left(Failure(failure.message));
      },
      (success) {
        _isLoading = false;
        notifyListeners();
        return Right(success);
      },
    );
  }

  Future<Either<Failure, String>> updateTripStatus(
      String tripId, String status) async {
        _isLoading = true;
    notifyListeners();
    final result = await _updateTripStatus(MultiParams(tripId, status));
    return result.fold(
      (failure)  {
        _isLoading = false;
    notifyListeners();
        return Left(Failure(failure.message));},
      (success) {
        _isLoading = false;
    notifyListeners();
        return Right(success);
      },
    );
  }

  Future<Either<Failure, String>> updateInspectionStatus(
    String tripId,
    InspectionStatus inspectionStatus,
  ) async {
    _isLoading = true;
    notifyListeners();
    final result =
        await _updateInspectionStatus(MultiParams(tripId, inspectionStatus));
    return result.fold(
      (failure) {
        _isLoading = false;
    notifyListeners();
        return Left(Failure(failure.message));},
      (success) {
        _isLoading = false;
    notifyListeners();
        return Right(success);
      },
    );
  }
}
