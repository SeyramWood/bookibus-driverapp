import 'package:bookihub/src/features/trip/presentation/provider/trip_provider.dart';
import 'package:bookihub/src/features/trip/presentation/views/trip_started.dart';
import 'package:bookihub/src/shared/constant/dimensions.dart';
import 'package:bookihub/src/shared/utils/alert_dialog.dart';
import 'package:bookihub/src/shared/utils/divider.dart';
import 'package:bookihub/src/shared/utils/exports.dart';
import 'package:bookihub/src/features/map/presentation/views/map_view.dart';
import 'package:bookihub/src/shared/widgets/percentage_indicator.dart';
import 'package:bookihub/src/features/trip/presentation/widgets/trip_inspect_row.dart';
import 'package:bookihub/src/features/trip/domain/entities/trip_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:bookihub/main.dart';
import 'package:provider/provider.dart';

class TripDetails extends StatefulWidget {
  const TripDetails({super.key, required this.trip});
  final Trip trip;

  @override
  State<TripDetails> createState() => _TripDetailsState();
}

class _TripDetailsState extends State<TripDetails> {
  bool value1 = false;
  bool value2 = false;
  bool value3 = false;
  bool value4 = false;
  bool value5 = false;
  bool value6 = false;

  double checkPercentage = 0.0;
  injectMap() {
    if (!locator.isRegistered<RouteMap>()) {
      locator.registerLazySingleton<RouteMap>(
        () => RouteMap(
            from: LatLng(
                widget.trip.route.fromLatitude, widget.trip.route.fromLatitude),
            to: LatLng(
              widget.trip.route.toLatitude,
              widget.trip.route.toLongitude,
            )),
      );
    }
  }

  @override
  void initState() {
    injectMap();
    super.initState();
  }

  submitInspections(isChecked) {
    if (isChecked) {
      showDialog(
        context: context,
        builder: (context) => _buildProgressIndicator(2, 'Saving inpections'),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isChecked = checkPercentage == 0.9999999999999999;
    var trip = widget.trip;

    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Trip Details',
            style: Theme.of(context).textTheme.headlineMedium,
          )),
      body: Builder(builder: (context) {
        WidgetsBinding.instance.addPostFrameCallback(
          (timeStamp) async {
            if (isChecked) { showDialog(
                context: context,
                builder: (context) =>
                    _buildProgressIndicator(2, 'Saving inpections'),
              );
              await context.read<TripProvider>().updateInspectionStatus(
                  '${trip.id}',
                  InspectionStatus(
                    brakeAndSteering: true,
                    emergencyEquipment: true,
                    engineCompartment: true,
                    exterior: true,
                    fuelAndFluid: true,
                    interior: true,
                  ));
             Navigator.of(context).pop();
            }
          },
        );

        return Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: hPadding, vertical: vPadding),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            SizedBox(
              height: MediaQuery.sizeOf(context).height * .1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Material(
                    borderRadius: borderRadius,
                    child: SizedBox(
                      width: MediaQuery.sizeOf(context).width * .7,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                                margin: const EdgeInsets.all(10),
                                height: 50,
                                width: 60,
                                child: Image.asset('assets/images/fleet.png')),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Trip ID: ${trip.id}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineLarge!
                                      .copyWith(color: titleColor),
                                ),
                                Text(
                                  'Bus Number: ${trip.vehicle.registrationNumber}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineLarge!
                                      .copyWith(color: titleColor),
                                ),
                              ],
                            ),
                          ]),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => showModalBottomSheet(
                      showDragHandle: true,
                      isScrollControlled: true,
                      useSafeArea: true,
                      context: context,
                      builder: (context) => SizedBox(
                          height: MediaQuery.sizeOf(context).height * .7,
                          child: mounted ? locator<RouteMap>() : null),
                    ),
                    child: Container(
                      width: MediaQuery.sizeOf(context).width * .15,
                      decoration: BoxDecoration(
                        borderRadius: borderRadius,
                        color: orange,
                      ),
                      child: Center(
                          child: Text(
                        'View\nRoute',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(color: white),
                      )),
                    ),
                  )
                ],
              ),
            ),
            vSpace,
            Divider(color: orange.withOpacity(.4)),
            vSpace,
            SizedBox(
              height: MediaQuery.sizeOf(context).height * .1,
              child: Material(
                borderRadius: borderRadius,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularPercentageIndicator(percentage: checkPercentage),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Pre-Trip Inspection',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
            ),
            vSpace,
            vSpace,
            Material(
              borderRadius: borderRadius,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: hPadding),
                child: Column(children: [
                  vSpace,
                  TripInspectRow(
                    label: 'Exterior Inspection',
                    onChanged: () async {
                      setState(() {
                        value1 = !value1;
                        value1
                            ? checkPercentage = (checkPercentage + 1 / 6)
                            : checkPercentage = (checkPercentage - 1 / 6);
                      });
                    },
                    value: value1,
                  ),
                  divider,
                  TripInspectRow(
                    label: 'Interior Inspection',
                    onChanged: () async {
                      setState(() {
                        value2 = !value2;
                        value2
                            ? checkPercentage = (checkPercentage + 1 / 6)
                            : checkPercentage = (checkPercentage - 1 / 6);
                      });
                    },
                    value: value2,
                  ),
                  divider,
                  TripInspectRow(
                    label: 'Engine Compartment',
                    onChanged: () async {
                      setState(() {
                        value3 = !value3;
                        value3
                            ? checkPercentage = (checkPercentage + 1 / 6)
                            : checkPercentage = (checkPercentage - 1 / 6);
                      });
                    },
                    value: value3,
                  ),
                  divider,
                  TripInspectRow(
                    label: 'Brakes and Steering',
                    onChanged: () async {
                      setState(() {
                        value4 = !value4;
                        value4
                            ? checkPercentage = (checkPercentage + 1 / 6)
                            : checkPercentage = (checkPercentage - 1 / 6);
                      });
                    },
                    value: value4,
                  ),
                  divider,
                  TripInspectRow(
                    label: 'Emergency Equipment',
                    onChanged: () async {
                      setState(() {
                        value5 = !value5;
                        value5
                            ? checkPercentage = (checkPercentage + 1 / 6)
                            : checkPercentage = (checkPercentage - 1 / 6);
                      });
                    },
                    value: value5,
                  ),
                  divider,
                  TripInspectRow(
                    label: 'Fuel and Fluids',
                    onChanged: () async {
                      setState(() {
                        value6 = !value6;
                        value6
                            ? checkPercentage = (checkPercentage + 1 / 6)
                            : checkPercentage = (checkPercentage - 1 / 6);
                      });
                    },
                    value: value6,
                  ),
                  vSpace,
                ]),
              ),
            ),
            const Spacer(),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * .07,
              child: ElevatedButton(
                onPressed: () {
                  if (isChecked) {
                    showCustomDialog(
                        context, const Text('Do you want to start this trip?'),
                        () async {
                      await context
                          .read<TripProvider>()
                          .updateTripStatus('${trip.id}', 'started')
                          .then(
                        (result) {
                          Navigator.of(context).pop();

                          result.fold(
                            (l) {
                              print(l);
                            },
                            (r) => Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return TripStartedView(
                                  trip: trip,
                                );
                              },
                            )),
                          );
                        },
                      );
                    });
                  }
                },
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(isChecked ? blue : grey)),
                child: const Text('Start Trip'),
              ),
            )
          ]),
        );
      }),
    );
  }

  _buildProgressIndicator(double value, String description) {
    return Center(
      child: CircularProgressIndicator(
          // value: value,
          ),
    );
  }
}
