import 'package:bookihub/src/features/trip/data/api/api_service.dart';
import 'package:bookihub/src/features/trip/domain/entities/trip_model.dart';
import 'package:bookihub/src/features/trip/presentation/provider/trip_provider.dart';
import 'package:bookihub/src/shared/constant/dimensions.dart';
import 'package:bookihub/src/shared/utils/show.snacbar.dart';
import 'package:provider/provider.dart';

import '../../../../shared/utils/date_time.formatting.dart';
import '../../../../shared/utils/exports.dart';

class TodayTripsView extends StatefulWidget {
  const TodayTripsView({super.key});

  @override
  State<TodayTripsView> createState() => _TodayTripsViewState();
}

class _TodayTripsViewState extends State<TodayTripsView> {
  Future<List<Trip>>? trips;
  fetchTrips() async {
    final result =
        await context.read<TripProvider>().fetchTrips(true, false, false);

    result
        .fold((failure) => showCustomSnackBar(context, failure.message, orange),
            (success) {
      setState(() {
        trips = Future.value(success);
      });
    });
  }

  @override
  void initState() {
    fetchTrips();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Trip>>(
        future: trips,
        builder: (context, snapshot) {
          var todayTrips = snapshot.data;
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return ListView.separated(
                separatorBuilder: (context, index) => SizedBox(
                      height: MediaQuery.sizeOf(context).height * .02,
                    ),
                shrinkWrap: true,
                itemCount: todayTrips!.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  var trip = todayTrips[index];
                  return Padding(
                    padding: EdgeInsets.only(
                        bottom: cards[index] == cards.last ? vPadding : 0.0),
                    child: TripCard(
                      location: trip.route.from,
                      lDescription: trip.boardingPoint[0].location,
                      destination: trip.route.to,
                      dDescription: trip.boardingPoint[1].location,
                      startTime: time.format(trip.departureDate),
                      endTime: time.format(trip.arrivalDate),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>  TripDetails(trip:trip),
                        ));
                      },
                    ),
                  );
                });
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('You have no trip available.'));
          }
          return const Center(child: CircularProgressIndicator());
        });
  }
}
