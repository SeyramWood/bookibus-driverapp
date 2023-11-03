// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bookihub/src/shared/utils/button_extension.dart';
import 'package:bookihub/src/shared/utils/show.snacbar.dart';
import 'package:provider/provider.dart';

import 'package:bookihub/main.dart';
import 'package:bookihub/src/features/map/presentation/views/map_view.dart';
import 'package:bookihub/src/features/trip/domain/entities/trip_model.dart';
import 'package:bookihub/src/features/trip/presentation/provider/trip_provider.dart';
import 'package:bookihub/src/features/trip/presentation/views/trip_tracker.dart';
import 'package:bookihub/src/shared/utils/exports.dart';
import 'package:bookihub/src/shared/widgets/custom_button.dart';

import '../../../../shared/utils/alert_dialog.dart';
import '../../../reports/presentation/views/fleet_mgt.dart';

class TripStartedView extends StatefulWidget {
  const TripStartedView({
    Key? key,
    required this.trip,
  }) : super(key: key);
  final Trip trip;

  @override
  State<TripStartedView> createState() => _TripStartedViewState();
}

class _TripStartedViewState extends State<TripStartedView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Trip Details",
            style: Theme.of(context).textTheme.headlineMedium!),
        backgroundColor: bg,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.sizeOf(context).height * .5,
              width: MediaQuery.sizeOf(context).width * .7,
              child: locator<RouteMap>(),
            ),
            SizedBox(height: MediaQuery.sizeOf(context).height * .02),
            SizedBox(
                width: MediaQuery.sizeOf(context).width * .4,
                height: MediaQuery.sizeOf(context).height * .06,
                child: CustomButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return const TripTrackingView();
                        },
                      ));
                    },
                    child: const Text("Expand Map"))),
            SizedBox(height: MediaQuery.sizeOf(context).height * .04),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Trip Started",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * .02,
                ),
                Material(
                  shape: OutlineInputBorder(
                      borderSide: const BorderSide(color: blue),
                      borderRadius: BorderRadius.circular(5)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Text(
                      "1 hour : 29 mins : 30 secs",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.w600, color: blue),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: MediaQuery.sizeOf(context).height * .04),
            CustomButton(
              onPressed: () {
                showCustomDialog(
                    context, const Text('Do you want to end this trip?'),
                    () async {
                  await context
                      .read<TripProvider>()
                      .updateTripStatus('${widget.trip.id}', 'ended')
                      .then(
                    (result) {
                      Navigator.of(context).pop();
                      result.fold((l) {
                        print(l);
                      },
                          (r) => {
                                showCustomSnackBar(
                                  context,
                                  'Trip successfully ended',
                                  green,
                                )
                                // Navigator.push(context, MaterialPageRoute(
                                //   builder: (context) {
                                //     return const TripStartedView();
                                //   },
                                // )),
                              });
                    },
                  );
                });
              },
              child: const Text("End Trip"),
            ).loading(context.watch<TripProvider>().isLoading),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: ElevatedButton(
                  onPressed: () {
                    showModalBottomSheet(
                      showDragHandle: true,
                      isScrollControlled: true,
                      isDismissible: false,
                      useSafeArea: true,
                      context: context,
                      builder: (context) => SizedBox(
                          height: MediaQuery.sizeOf(context).height * .8,
                          child: const FleetMgtReport()),
                    );
                  },
                  child: const Text('Make report'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
