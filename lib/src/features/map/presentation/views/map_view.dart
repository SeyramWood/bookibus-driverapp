
import 'package:bookihub/src/shared/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mapbox_navigation/flutter_mapbox_navigation.dart';
import 'package:location/location.dart';

import '../../../trip/domain/entities/trip_model.dart';

class RouteMap extends StatefulWidget {
  const RouteMap({
    super.key,
    required this.trip,
    this.dimension = .78,
    this.dimension2 = .601,
  });
  final Trip trip;
  final num dimension;
  final num dimension2;

  @override
  State<RouteMap> createState() => _RouteMapState();
}

class _RouteMapState extends State<RouteMap> {
  String? platformVersion;
  String? instruction;

  bool _isMultipleStop = false;
  MapBoxNavigationViewController? _controller;
  bool routeBuilt = false;
  bool _isNavigating = false;
  late MapBoxOptions _navigationOption;

  @override
  void initState() {
    super.initState();
    initialize();
    Future.delayed(
      const Duration(seconds: 2),
      () {
        var wayPoints = <WayPoint>[];

        wayPoints.add(WayPoint(
            name: "Source",
            latitude: widget.trip.route.fromLatitude,
            longitude: widget.trip.route.fromLongitude,
            isSilent: false));
        wayPoints.add(WayPoint(
            name: "Your destination",
            latitude: widget.trip.route.toLatitude,
            longitude: widget.trip.route.toLongitude,
            isSilent: false));
        //stops will be added here
        if (widget.trip.route.stops.isNotEmpty) {
          for (var stop in widget.trip.route.stops) {
            int id = 0;
            wayPoints.add(
              WayPoint(
                name: 'stop ${id++}',
                latitude: stop.latitude,
                longitude: stop.longitude,
              ),
            );
          }
        }
        _isMultipleStop = wayPoints.length > 2;
        _controller?.buildRoute(
            wayPoints: wayPoints, options: _navigationOption);
      },
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initialize() async {
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    _navigationOption = MapBoxNavigation.instance.getDefaultOptions();
    _navigationOption.simulateRoute = false;
    _navigationOption.language = "en";
    _navigationOption.enableRefresh = true;

    MapBoxNavigation.instance.registerRouteEventListener(_onRouteEvent);

    String? platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
   
    setState(() {
      platformVersion = platformVersion;
    });
  }

  bool? arrived = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(children: <Widget>[
          Expanded(
            child: Container(
              color: Colors.grey,
              child: MapBoxNavigationView(
                  options: _navigationOption,
                  onRouteEvent: _onRouteEvent,
                  onCreated: (MapBoxNavigationViewController controller) async {
                    _controller = controller;
                    controller.initialize();
                  }),
            ),
          ),
          Positioned(
            top: MediaQuery.sizeOf(context).height * widget.dimension2,
            left: MediaQuery.sizeOf(context).width * widget.dimension,
            child: SizedBox(
              width: 75,
              height: 55,
              child: CustomButton(
                onPressed: !_isNavigating
                    ? () {
                        if (_isNavigating) {
                          setState(() {
                            _controller?.finishNavigation();
                          });
                        } else {
                          setState(() {
                            _controller?.startNavigation();
                          });
                        }
                      }
                    : null,
                child: const Icon(Icons.navigation),
              ),
            ),
          )
        ]),
      ),
    );
  }

  Future<void> _onRouteEvent(e) async {
    // _distanceRemaining = await _directions.distanceRemaining;
    // _durationRemaining = await _directions.durationRemaining;

    switch (e.eventType) {
      case MapBoxEvent.progress_change:
        var progressEvent = e.data as RouteProgressEvent;
        arrived = progressEvent.arrived;
        if (progressEvent.currentStepInstruction != null) {
          instruction = progressEvent.currentStepInstruction;
        }
        break;
      case MapBoxEvent.route_building:
      case MapBoxEvent.route_built:
        routeBuilt = true;
        break;
      case MapBoxEvent.route_build_failed:
        routeBuilt = false;
        break;
      case MapBoxEvent.navigation_running:
        _isNavigating = true;
        break;
      case MapBoxEvent.on_arrival:
        arrived = true;
        if (!_isMultipleStop) {
          await Future.delayed(const Duration(seconds: 3));
          await _controller?.finishNavigation();
        } else {}
        break;
      case MapBoxEvent.navigation_finished:
      case MapBoxEvent.navigation_cancelled:
        routeBuilt = false;
        _isNavigating = false;
        break;
      default:
        break;
    }
    //refresh UI
    setState(() {});
  }

  ///LOcation
  LocationData? currentLocation;
  void getCurrentLocation() async {
    Location location = Location();
    location.getLocation().then(
      (location) {
        currentLocation = location;
      },
    );
    // GoogleMapController googleMapController = await _controller.;
    location.onLocationChanged.listen(
      (newLoc) {
        currentLocation = newLoc;
        // googleMapController.animateCamera(
        //   CameraUpdate.newCameraPosition(
        //     CameraPosition(
        //       zoom: 13.5,
        //       target: LatLng(
        //         newLoc.latitude!,
        //         newLoc.longitude!,
        //       ),
        //     ),
        // ),
        // );
        setState(() {});
      },
    );
  }
}
