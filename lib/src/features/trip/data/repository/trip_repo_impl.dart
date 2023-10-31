import 'dart:developer';

import 'package:bookihub/src/features/trip/data/api/api_service.dart';
import 'package:bookihub/src/features/trip/domain/entities/trip_model.dart';
import 'package:bookihub/src/features/trip/domain/repository/trip_repo.dart';
import 'package:bookihub/src/shared/errors/custom_exception.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart';

import '../../../../shared/errors/failure.dart';

class TripRepoImpl implements TripRepo {
  final TripApiService api;

  TripRepoImpl(this.api);

  @override
  Future<Either<Failure, List<Trip>>> fetchTrips(
    bool today,
    bool scheduled,
    bool completed,
  ) async {
    try {
      final result = await api.fetchTrips(today, scheduled, completed);
      return Right(result);
    } on CustomException catch (failure) {
      return Left(Failure(failure.message));
    } on ClientException catch (networkError) {
      return Left(Failure(networkError.message));
    } catch (e) {
      log('$e');
      return Left(Failure('something went wrong'));
    }
  }

  @override
  Future<Either<Failure, String>> updateTripStatus(
      String tripId, String status) async {
    try {
      await api.updateTripStatus(tripId, status);
      return const Right('started');
    } on CustomException catch (failure) {
      return Left(Failure(failure.message));
    } on ClientException catch (networkError) {
      return Left(Failure(networkError.message));
    } catch (e) {
      log('$e');
      return Left(Failure('something went wrong'));
    }
  }
  
  @override
  Future<Either<Failure, String>> updateInspectionStatus(String tripId, InspectionStatus inspectionStatus) async {
    try {
      await api.updateInspectionStatus(tripId, inspectionStatus);
      return const Right('started');
    } on CustomException catch (failure) {
      return Left(Failure(failure.message));
    } on ClientException catch (networkError) {
      return Left(Failure(networkError.message));
    } catch (e) {
      log('$e');
      return Left(Failure('something went wrong'));
    }
  }
}