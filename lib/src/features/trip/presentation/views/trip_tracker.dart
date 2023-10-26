import 'package:bookihub/src/features/map/presentation/views/map_view.dart';
import 'package:bookihub/src/shared/utils/exports.dart';

class TripTrackingView extends StatefulWidget {
  const TripTrackingView({super.key});

  @override
  State<TripTrackingView> createState() => _TripTrackingViewState();
}

class _TripTrackingViewState extends State<TripTrackingView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Trip Route",
            style: Theme.of(context).textTheme.headlineMedium!),
        backgroundColor: bg,
      ),
      body: const RouteMap(),
    );
  }
}
