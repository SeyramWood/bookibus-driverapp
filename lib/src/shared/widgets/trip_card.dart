import 'package:bookihub/src/shared/constant/dimensions.dart';
import 'package:bookihub/src/shared/utils/divider.dart';
import 'package:bookihub/src/shared/utils/exports.dart';
import 'package:flutter_dash/flutter_dash.dart';

class TripCard extends StatefulWidget {
  const TripCard(
      {super.key,
      this.location,
      this.lDescription,
      this.destination,
      this.dDescription,
      this.startTime,
      this.endTime,
      this.onTap});
  final String? location;
  final String? lDescription;
  final String? destination;
  final String? dDescription;
  final String? startTime;
  final String? endTime;
  final void Function()? onTap;

  @override
  State<TripCard> createState() => _TripCardState();
}

class _TripCardState extends State<TripCard> {
  String? startTime;
  String? endTime;

  // static TimeOfDay selectedStartTime = TimeOfDay.now();
  TimeOfDay selectedEndTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(color: white, borderRadius: borderRadius),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.adjust,
                  color: green,
                  size: 17,
                ),
                Dash(
                    direction: Axis.vertical,
                    length: 50,
                    dashLength: 5,
                    dashThickness: 1,
                    dashColor: grey),
                Icon(
                  Icons.place_outlined,
                  color: orange,
                  size: 17,
                )
              ],
            ),
            SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.02,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //a row showing location and departure time
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.location!,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontWeight: FontWeight.w600),
                          ),
                          Text(
                            widget.lDescription!,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                      Material(
                        shape: RoundedRectangleBorder(
                            borderRadius: borderRadius,
                            side: const BorderSide(width: 1, color: green)),
                        child: Padding(
                          padding: const EdgeInsets.all(6),
                          child: Text(
                            "12:30 PM",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  divider,
                  //a row showing destination and arrival time
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.destination!,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontWeight: FontWeight.w600),
                          ),
                          Text(
                            widget.dDescription!,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                      Material(
                        shape: RoundedRectangleBorder(
                            borderRadius: borderRadius,
                            side: const BorderSide(
                              width: 1,
                              color: orange,
                            )),
                        child: Padding(
                          padding: const EdgeInsets.all(6),
                          child: Text(
                            "12:45 PM",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

List<Map<String, String>> cards = [
  {
    "location": "Ho",
    "lDescription": "Big Market Station",
    "destination": "Kumasi",
    "dDescription": "Neoplan Station"
  },
  {
    "location": "Ho",
    "lDescription": "Big Market Station",
    "destination": "Kumasi",
    "dDescription": "Neoplan Station"
  },
  {
    "location": "Ho",
    "lDescription": "Big Market Station",
    "destination": "Kumasi",
    "dDescription": "Neoplan Station"
  }
];
