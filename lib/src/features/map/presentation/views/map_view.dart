import 'package:bookihub/src/features/map/presentation/widget/order_button.dart';
import 'package:bookihub/src/shared/constant/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mapbox_navigation/flutter_mapbox_navigation.dart';
import 'package:get/route_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class RouteMap extends StatefulWidget {
  const RouteMap({super.key, required this.from, required this.to});
  final LatLng from;
  final LatLng to;

  @override
  State<RouteMap> createState() => _RouteMapState();
}

class _RouteMapState extends State<RouteMap> {
  String? _platformVersion;
  String? _instruction;

  bool _isMultipleStop = false;
  MapBoxNavigationViewController? _controller;
  bool _routeBuilt = false;
  bool _isNavigating = false;
  late MapBoxOptions _navigationOption;

  @override
  void initState() {
    super.initState();
    initialize();
    Future.delayed(const Duration(seconds: 2), () {
      var wayPoints = <WayPoint>[];
      wayPoints.add(WayPoint(
          name: "Home",
          latitude: widget.from.latitude,
          longitude: widget.from.longitude,
          isSilent: false));
      wayPoints.add(WayPoint(
          name: "Your destination",
          latitude: widget.to.latitude,
          longitude: widget.to.longitude,
          isSilent: false));
      _isMultipleStop = wayPoints.length > 2;
      _controller?.buildRoute(wayPoints: wayPoints, options: _navigationOption);
    });
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
    // _navigationOption.mapStyleUrlDay = "https://url_to_night_style";
    // _navigationOption.tilt
    //_navigationOption.initialLatitude = 36.1175275;
    //_navigationOption.initialLongitude = -115.1839524;
    MapBoxNavigation.instance.registerRouteEventListener(_onEmbeddedRouteEvent);

    String? platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await MapBoxNavigation.instance.getPlatformVersion();
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(children: <Widget>[
            Expanded(
              child: SizedBox(
                height: 300,
                child: Container(
                  color: Colors.grey,
                  child: MapBoxNavigationView(
                      options: _navigationOption,
                      onRouteEvent: _onEmbeddedRouteEvent,
                      onCreated:
                          (MapBoxNavigationViewController controller) async {
                        _controller = controller;
                        controller.initialize();
                      }),
                ),
              ),
            ),
            ///////////////
            // Container(
            //   color: Theme.of(context).cardColor,
            //   padding: const EdgeInsets.all(10),
            //   child: Column(
            //     children: [
            //       // CommonButton(onPressed: (){},title: "Start Trip",),
            //       SafeArea(
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: [
            //             Expanded(
            //               child: OrderButton(
            //                 title: "Start Trip",
            //                 textColor: black,
            //                 borderColor: black,
            //                 onTap: _routeBuilt && !_isNavigating
            //                     ? () {
            //                         _controller?.startNavigation();
            //                       }
            //                     : null,
            //               ),
            //             ),
            //             const SizedBox(
            //               width: 15,
            //             ),
            //             Expanded(
            //               child: OrderButton(
            //                 title: "End Trip",
            //                 textColor: black,
            //                 borderColor: black,
            //                 onTap: _isNavigating
            //                     ? () {
            //                         _controller?.finishNavigation();
            //                       }
            //                     : null,
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
          ]),
        ),
      ),
    );
  }

  Future<void> _onEmbeddedRouteEvent(e) async {
    // _distanceRemaining = await MapBoxNavigation.instance.getDistanceRemaining();
    // _durationRemaining = await MapBoxNavigation.instance.getDurationRemaining();

    // print(_durationRemaining);

    switch (e.eventType) {
      case MapBoxEvent.progress_change:
        var progressEvent = e.data as RouteProgressEvent;
        if (progressEvent.currentStepInstruction != null) {
          _instruction = progressEvent.currentStepInstruction;
        }
        break;
      case MapBoxEvent.route_building:
      case MapBoxEvent.route_built:
        setState(() {
          _routeBuilt = true;
        });
        break;
      case MapBoxEvent.route_build_failed:
        setState(() {
          _routeBuilt = false;
        });
        break;
      case MapBoxEvent.navigation_running:
        setState(() {
          _isNavigating = true;
        });
        break;
      case MapBoxEvent.on_arrival:
        if (!_isMultipleStop) {
          await Future.delayed(const Duration(seconds: 3));
          await _controller?.finishNavigation();
        } else {}
        break;
      case MapBoxEvent.navigation_finished:
      case MapBoxEvent.navigation_cancelled:
        setState(() {
          _routeBuilt = false;
          _isNavigating = false;
          // _scaleDialog();
          if (kDebugMode) {
            print("asbHJFBDSHJBFJDSBFJBDSFJBDSJFBS");
          }
        });

      default:
        break;
    }
    setState(() {});
  }

  void _scaleDialog({
    Function()? onCancel,
    Function()? onConfirm,
  }) {
    showGeneralDialog(
      context: context,
      pageBuilder: (ctx, a1, a2) {
        return Container();
      },
      transitionBuilder: (ctx, a1, a2, child) {
        var curve = Curves.easeInOut.transform(a1.value);
        return Transform.scale(
          scale: curve,
          child: _dialog(ctx, onCancel: onCancel, onConfirm: onConfirm),
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }

  Widget _dialog(
    BuildContext context, {
    Function()? onCancel,
    Function()? onConfirm,
  }) {
    return AlertDialog(
      title: const Center(child: Text("Alert")),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "You are about to cancel this order?",
            // style: smallTextStyle,
          ),
          Row(
            children: [
              Expanded(
                child: OrderButton(
                  borderColor: black,
                  title: "Confirm",
                  textColor: black,
                  onTap: onConfirm,
                ),
              ),
              const SizedBox(
                width: 30,
              ),
              Expanded(
                child: OrderButton(
                  borderColor: black,
                  textColor: black,
                  title: "Cancel",
                  onTap: onCancel,
                ),
              ),
            ],
          )
        ],
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
    );
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
