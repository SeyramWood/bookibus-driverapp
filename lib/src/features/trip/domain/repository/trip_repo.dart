import 'package:dartz/dartz.dart';

import '../../../../shared/errors/failure.dart';
import '../entities/trip_model.dart';

abstract class TripRepo {
  Future<Either<Failure,List<Trip>>> fetchTrips(
    bool today,
    bool scheduled,
    bool completed,
  );
}
