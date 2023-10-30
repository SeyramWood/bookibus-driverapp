import 'package:bookihub/main.dart';
import 'package:bookihub/src/features/trip/data/api_service.dart';
import 'package:bookihub/src/features/trip/data/repository/trip_repo_impl.dart';
import 'package:bookihub/src/features/trip/domain/usecase/fetch_trip.dart';
import 'package:bookihub/src/features/trip/presentation/provider/trip_provider.dart';

injectTripDependencies() {
  locator.registerLazySingleton<TripApiService>(() => TripApiService());
  locator.registerLazySingleton<TripRepoImpl>(
      () => TripRepoImpl(locator<TripApiService>()));
  locator.registerLazySingleton<FetchTrips>(
      () => FetchTrips(locator<TripRepoImpl>()));
        locator.registerLazySingleton<TripProvider>(()=>tripProvider);

}
final tripProvider = TripProvider(fetchTrips: locator<FetchTrips>());