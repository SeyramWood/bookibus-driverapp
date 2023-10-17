import 'package:bookihub/shared/utils/exports.dart';
import 'package:flutter_dash/flutter_dash.dart';

class TripCard extends StatefulWidget {
  const TripCard(
      {super.key,
      this.location,
      this.lDescription,
      this.destination,
      this.dDescription,
      this.onTap});
  final String? location;
  final String? lDescription;
  final String? destination;
  final String? dDescription;
  final void Function()? onTap;

  @override
  State<TripCard> createState() => _TripCardState();
}

class _TripCardState extends State<TripCard> {
  String? startTime = "";
  String? endTime = "";

  static TimeOfDay selectedStartTime = TimeOfDay.now();
  TimeOfDay selectedEndTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        height: MediaQuery.of(context).size.height * .15,
        width: MediaQuery.of(context).size.width * .27,
        decoration:
            BoxDecoration(color: white, borderRadius: BorderRadius.circular(5)),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
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
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.75,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.location!,
                              style: const TextStyle(
                                  color: black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                            Text(
                              widget.lDescription!,
                              style: const TextStyle(
                                  color: black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12),
                            )
                          ],
                        ),
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * 0.15,
                        ),
                        InkWell(
                          onTap: () async {
                            final TimeOfDay? timeOfDate = await showTimePicker(
                                context: context,
                                initialTime: selectedStartTime,
                                initialEntryMode: TimePickerEntryMode.dial);
                            if (timeOfDate != null) {
                              setState(() {
                                selectedStartTime = timeOfDate;
                                startTime =
                                    "${timeOfDate.hour > 11 ? timeOfDate.hour - 12 : timeOfDate.hour}:${timeOfDate.minute} ${timeOfDate.hour >= 12 ? 'pm' : 'am'}";
                              });
                            }
                          },
                          child: SizedBox(
                            width: MediaQuery.sizeOf(context).width * 0.17,
                            height: MediaQuery.sizeOf(context).height * 0.038,
                            child: Material(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  side:
                                      const BorderSide(width: 1, color: green)),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.sizeOf(context).width *
                                          0.04,
                                    ),
                                    Text(
                                      "${selectedStartTime.hour > 11 ? selectedStartTime.hour - 12 : selectedStartTime.hour}:${selectedStartTime.minute} ${selectedStartTime.hour >= 12 ? 'pm' : 'am'}",
                                      style: const TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.destination!,
                              style: const TextStyle(
                                  color: black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                            Text(
                              widget.dDescription!,
                              style: const TextStyle(
                                  color: black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12),
                            )
                          ],
                        ),
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * 0.15,
                        ),
                        InkWell(
                          onTap: () async {
                            final TimeOfDay? timeOfDate = await showTimePicker(
                                context: context,
                                initialTime: selectedStartTime,
                                initialEntryMode: TimePickerEntryMode.dial);
                            if (timeOfDate != null) {
                              setState(() {
                                selectedStartTime = timeOfDate;
                                endTime =
                                    "${timeOfDate.hour > 11 ? timeOfDate.hour - 12 : timeOfDate.hour}:${timeOfDate.minute} ${timeOfDate.hour >= 12 ? 'pm' : 'am'}";
                              });
                            }
                          },
                          child: SizedBox(
                            width: MediaQuery.sizeOf(context).width * 0.17,
                            height: MediaQuery.sizeOf(context).height * 0.038,
                            child: Material(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  side: const BorderSide(
                                    width: 1,
                                    color: orange,
                                  )),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.sizeOf(context).width *
                                          0.04,
                                    ),
                                    Text(
                                      "${selectedStartTime.hour > 11 ? selectedStartTime.hour - 12 : selectedStartTime.hour}:${selectedStartTime.minute} ${selectedStartTime.hour >= 12 ? 'pm' : 'am'}",
                                      style: const TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ],
                                ),
                              ),
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
