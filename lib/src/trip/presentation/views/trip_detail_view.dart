import 'package:bookihub/shared/constant/colors.dart';
import 'package:bookihub/shared/constant/dimensions.dart';
import 'package:bookihub/shared/utils/divider.dart';
import 'package:bookihub/src/trip/presentation/views/map_view.dart';
import 'package:bookihub/src/trip/presentation/widgets/trip_inspect_row.dart';
import 'package:flutter/material.dart';

class TripDetails extends StatelessWidget {
  const TripDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Trip Details')),
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
                              width: 50,
                              child: Image.asset('asset/images/logo.png')),
                          const Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Trip ID: MTGHD8'),
                              Text('Bus Number: MTGHD8'),
                            ],
                          ),
                        ]),
                  ),
                ),
                GestureDetector(
                  onTap: () => showModalBottomSheet(
                    showDragHandle: true,
                    useSafeArea: true,
                    context: context,
                    builder: (context) => SizedBox(
                        height: MediaQuery.sizeOf(context).height * .8,
                        child: const RouteMap()),
                  ),
                  child: Container(
                    width: MediaQuery.sizeOf(context).width * .2,
                    decoration: BoxDecoration(
                      borderRadius: borderRadius,
                      color: yellow,
                    ),
                    child: const Center(
                        child: Text(
                      'View\nRoute',
                      style: TextStyle(color: white),
                    )),
                  ),
                )
              ],
            ),
          ),
          vSpace,
          vSpace,
          SizedBox(
            height: MediaQuery.sizeOf(context).height * .1,
            child: Material(
              borderRadius: borderRadius,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CircularProgressIndicator.adaptive(
                    backgroundColor: grey,
                    strokeWidth: 6,
                  ),
                  Text('Pre-Trip Inspection')
                ],
              ),
            ),
          ),
          vSpace,
          Material(
            borderRadius: borderRadius,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: hPadding),
              child: Column(children: [
                TripInspectRow(
                  label: 'Exterior Inspection',
                  onChanged: (p0) {},
                  value: false,
                ),
                divider,
                TripInspectRow(
                  label: 'Interior Inspection',
                  onChanged: (p0) {},
                  value: false,
                ),
                divider,
                TripInspectRow(
                  label: 'Engine Compartment',
                  onChanged: (p0) {},
                  value: false,
                ),
                divider,
                TripInspectRow(
                  label: 'Brakes and Steering',
                  onChanged: (p0) {},
                  value: false,
                ),
                divider,
                TripInspectRow(
                  label: 'Emergency Equipment',
                  onChanged: (p0) {},
                  value: false,
                ),
                divider,
                TripInspectRow(
                  label: 'Fuel and Fluids',
                  onChanged: (p0) {},
                  value: false,
                ),
              ]),
            ),
          ),
          vSpace,
          vSpace,
          ElevatedButton(
            onPressed: () {},
            style:
                ButtonStyle(backgroundColor: MaterialStateProperty.all(grey)),
            child: const Text('Start Trip'),
          )
        ]),
      ),
    );
  }
}
