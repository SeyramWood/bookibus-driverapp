import 'package:bookihub/src/features/map/presentation/views/map_view.dart';
import 'package:bookihub/src/features/trip/presentation/views/trip_tracker.dart';
import 'package:bookihub/src/shared/utils/exports.dart';
import 'package:bookihub/src/shared/widgets/custom_button.dart';

class TripStartedView extends StatefulWidget {
  const TripStartedView({super.key});

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
        width: MediaQuery.sizeOf(context).width *.7,
        child: const RouteMap(),
            ),
            SizedBox(
                  height: MediaQuery.sizeOf(context).height * .02),
            SizedBox(
              width: MediaQuery.sizeOf(context).width *.4,
              height: MediaQuery.sizeOf(context).height * .06,
              child: CustomButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return const TripTrackingView();
                      },
                    ));
                },
                title: "Expand Map")),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * .04),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Trip Started",
                    style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontWeight: FontWeight.w600),),
                              SizedBox(
                                width: MediaQuery.sizeOf(context).width*.02,
                              ),
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * .07,
                      child: Material(
                        shape: OutlineInputBorder(
                            borderSide: const BorderSide(color: blue),
                            borderRadius: BorderRadius.circular(5)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 20),
                          child: Text(
                            "1 hour : 29 mins : 30 secs",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontWeight: FontWeight.w600, color: blue),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * .04),
                  CustomButton(
                    onPressed: (){},
                    title: "End Trip",
                  )
          ],
        ),
      ),
    );
  }
}