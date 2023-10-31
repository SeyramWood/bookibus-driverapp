import 'package:bookihub/src/features/trip/domain/entities/trip_model.dart';
import 'package:bookihub/src/features/trip/presentation/provider/trip_provider.dart';
import 'package:bookihub/src/features/trip/presentation/widgets/trip_card.dart';
import 'package:bookihub/src/shared/constant/dimensions.dart';
import 'package:bookihub/src/shared/utils/date_time.formatting.dart';
import 'package:bookihub/src/shared/utils/show.snacbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../shared/constant/colors.dart';

class ScheduledTripView extends StatefulWidget {
  const ScheduledTripView({super.key});

  @override
  State<ScheduledTripView> createState() => _ScheduledTripViewState();
}

class _ScheduledTripViewState extends State<ScheduledTripView> {
  Future<List<Trip>>? trips;
  fetchTrips() async {
    final result =
        await context.read<TripProvider>().fetchTrips(false, true, false);

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

  final List<Map<String, String>> dates = [];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Trip>>(
        future: trips,
        builder: (context, snapshot) {
          var trips = snapshot.data;
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            //check and add dates for sorting
            for (var trip in trips!) {
              dates.add({'date': date.format(trip.departureDate)});
            }
            return ListView.builder(
              itemCount: dates.length,
              itemBuilder: (context, index) {
                final cn = dates[index];
                final prevState = index > 0 ? dates[index - 1] : null;
                final isDiff =
                    prevState == null || cn['date'] != prevState['date'];
                var trip = trips[index];
                return Column(
                  children: [
                    if (isDiff)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: vPadding),
                        child: Text(cn['date']!),
                      ),
                    Padding(
                      padding: EdgeInsets.only(top: !isDiff ? vPadding : 0.0),
                      child: TripCard(
                        location: trip.route.from,
                        lDescription: trip.boardingPoint[0].location,
                        destination: trip.route.to,
                        dDescription: trip.boardingPoint[1].location,
                        startTime: time.format(trip.departureDate),
                        endTime: time.format(trip.arrivalDate),
                      ),
                    )
                  ],
                );
              },
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('You have no trip available.'));
          }
          return const Center(child: CircularProgressIndicator());
        });
  }
}
