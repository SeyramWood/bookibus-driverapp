import 'package:bookihub/src/features/trip/data/api_service.dart';
import 'package:bookihub/src/features/trip/domain/entities/trip_model.dart';
import 'package:bookihub/src/features/trip/domain/repository/trip_repo.dart';
import 'package:bookihub/src/shared/errors/custom_exception.dart';
import 'package:dartz/dartz.dart';

import '../../../../shared/errors/failure.dart';

class TripRepoImpl implements TripRepo {
  final TripApiService api;

  TripRepoImpl(this.api);

  @override
  Future<Either<Failure,List<Trip>>> fetchTrips(
    bool today,
    bool scheduled,
    bool completed,
  ) async {
     try {
      final result = await api.fetchTrips(today, scheduled, completed);
      return Right(result);
    } on CustomException catch (failure) {
      return Left(Failure(failure.message));
    } catch (e) {
      return Left(Failure('something went wrong'));
    }
  }
}
