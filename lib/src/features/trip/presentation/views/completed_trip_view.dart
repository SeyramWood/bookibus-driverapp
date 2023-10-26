import 'package:bookihub/src/features/trip/presentation/widgets/trip_card.dart';
import 'package:bookihub/src/shared/constant/colors.dart';
import 'package:bookihub/src/shared/constant/dimensions.dart';
import 'package:flutter/material.dart';

class CompletedTripView extends StatefulWidget {
  const CompletedTripView({super.key});

  @override
  State<CompletedTripView> createState() => _CompletedTripViewState();
}

class _CompletedTripViewState extends State<CompletedTripView> {
  final List<Map<String, String>> dates = [
    {
      "date": "2023-10-20",
    },
    {
      "date": "2023-10-21",
    },
    {
      "date": "2023-10-21",
    },
    {
      "date": "2023-10-22",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: dates.length,
      itemBuilder: (context, index) {
        final cn = dates[index];
        final prevState = index > 0 ? dates[index - 1] : null;
        final isDiff = prevState == null || cn['date'] != prevState['date'];

        return Column(
          children: [
            if (isDiff)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: vPadding),
                child: Text(
                  cn['date']!,
                  style: const TextStyle(color: orange),
                ),
              ),
            Padding(
              padding: EdgeInsets.only(top: !isDiff ? vPadding : 0.0),
              child: TripCard(
                location: cards[index]['location'],
                lDescription: cards[index]['lDescription'],
                destination: cards[index]['destination'],
                dDescription: cards[index]['dDescription'],
              ),
            )
          ],
        );
      },
    );
  }
}
