
import 'package:bookihub/src/features/trip/presentation/views/trip_started.dart';
import 'package:bookihub/src/shared/constant/dimensions.dart';
import 'package:bookihub/src/shared/utils/divider.dart';
import 'package:bookihub/src/shared/utils/exports.dart';
import 'package:bookihub/src/features/map/presentation/views/map_view.dart';
import 'package:bookihub/src/shared/widgets/percentage_indicator.dart';
import 'package:bookihub/src/features/trip/presentation/widgets/trip_inspect_row.dart';

class TripDetails extends StatefulWidget {
  const TripDetails({super.key});

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

  @override
  Widget build(BuildContext context) {
    bool isChecked = checkPercentage == 0.9999999999999999;

    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Trip Details',
            style: Theme.of(context).textTheme.headlineMedium,
          )),
      body: Padding(
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
                    width: MediaQuery.sizeOf(context).width * .66,
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
                                'Trip ID: MTGHD8',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineLarge!
                                    .copyWith(color: titleColor),
                              ),
                              Text(
                                'Bus Number: MTGHD8',
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
                        child: mounted ? const RouteMap() : null),
                  ),
                  child: Container(
                    width: MediaQuery.sizeOf(context).width * .2,
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
                  onChanged: () {
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
                  onChanged: () {
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
                  onChanged: () {
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
                  onChanged: () {
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
                  onChanged: () {
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
                  onChanged: () {
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
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return const TripStartedView();
                      },
                    ));
                }
              },
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(isChecked ? blue : grey)),
              child: const Text('Start Trip'),
            ),
          )
        ]),
      ),
    );
  }
}
