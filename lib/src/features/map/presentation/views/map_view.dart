// import 'dart:async';
// import 'dart:io';
// import 'dart:developer';

// import 'package:bookihub/src/shared/constant/colors.dart';
// import 'package:bookihub/src/shared/utils/show.snacbar.dart';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';

// import '../provider/current_location_controller.dart';

// class RouteMap extends StatefulWidget {
//   const RouteMap({super.key, required this.from, required this.to});
//   final LatLng from;
//   final LatLng to;

//   @override
//   State<RouteMap> createState() => _RouteMapState();
// }

// class _RouteMapState extends State<RouteMap> {
//   final Location _locationController = Location();
//   static const LatLng _kGoil = LatLng(5.1115, -1.2790);
//   static const LatLng _kend = LatLng(5.1345, -1.2500);
//   LatLng? _currentLocation;
//   final Completer<GoogleMapController> _mapController =
//       Completer<GoogleMapController>();

//   @override
//   void initState() {
//     super.initState();
//     getLocationUpdates().then(
//       (_) {
//         getPolylinePoints().then(
//           (value) => print(value),
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: ValueListenableBuilder(
//             valueListenable: UpdateCurrentLocation(),
//             builder: (context, currentLocation, _) {
//               return GoogleMap(
//                 initialCameraPosition:
//                     CameraPosition(target: currentLocation, zoom: 8),
//                 onMapCreated: (controller) {
//                   _mapController.complete(controller);
//                   cameraPosition(currentLocation);
//                 },
//                 zoomGesturesEnabled: false,
//                 scrollGesturesEnabled: true,
//                 markers: {
//                   Marker(
//                     markerId: const MarkerId('_currentLocation'),
//                     position: currentLocation,
//                     icon: BitmapDescriptor.defaultMarkerWithHue(
//                         BitmapDescriptor.hueCyan),
//                   ),
//                   Marker(
//                     markerId: const MarkerId('departureLocation'),
//                     position: widget.from,
//                     icon: BitmapDescriptor.defaultMarkerWithHue(
//                         BitmapDescriptor.hueGreen),
//                   ),
//                   Marker(
//                       markerId: const MarkerId('destination'),
//                       position: widget.to,
//                       icon: BitmapDescriptor.defaultMarker),
//                 },
//                 // polylines: {
//                 //   const Polyline(
//                 //       polylineId: PolylineId('destination'),
//                 //       points: [_kGoil, _kend])
//                 // },
//               );
//             }));
//   }

//   Future<void> cameraPosition(LatLng pos) async {
//     final GoogleMapController controller = await _mapController.future;
//     {
//       await controller.animateCamera(
//         CameraUpdate.newCameraPosition(
//           CameraPosition(target: pos, zoom: 9),
//         ),
//       );
//     }
//   }

//   Future<void> getLocationUpdates() async {
//     {
//       bool isServiceEnabled;
//       PermissionStatus persmissionGranted;

//       isServiceEnabled = await _locationController.serviceEnabled();
//       if (!isServiceEnabled) {
//         isServiceEnabled = await _locationController.requestService();
//       }

//       persmissionGranted = await _locationController.hasPermission();
//       if (persmissionGranted == PermissionStatus.denied) {
//         persmissionGranted = await _locationController.requestPermission();
//       }

//       _locationController.onLocationChanged.listen(
//         (currentLocation) {
//           if (currentLocation.latitude != null &&
//               currentLocation.longitude != null) {
//             if (mounted) {
//               UpdateCurrentLocation().cLocation(LatLng(
//                   currentLocation.latitude!, currentLocation.longitude!));
//               setState(() {});
//             }
//           }
//         },
//       );
//     }
//   }

//   Future<List<LatLng>> getPolylinePoints() async {
//     try {
//       List<LatLng> coordinates = [];
//       PolylinePoints polylinePoints = PolylinePoints();

//       PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
//         'AIzaSyDUU4gkWcf_O1o_vq6hh4tlFJHqymjJhxc',
//         PointLatLng(_kGoil.latitude, _kGoil.longitude),
//         PointLatLng(_kend.latitude, _kend.longitude),
//         travelMode: TravelMode.driving,
//       );
//       log(result.points[0].latitude.toString());

//       if (result.points.isNotEmpty) {
//         for (var pointLatLng in result.points) {
//           var newPoint = LatLng(pointLatLng.latitude, pointLatLng.longitude);
//           coordinates.add(newPoint);
//         }
//       } else {
//         print(result.errorMessage);
//       }
//       return coordinates;
//     } on SocketException catch (_) {
//       if (mounted) {
//         showCustomSnackBar(
//             context, 'You are offline. Check your connection.', orange);
//       }
//       return [];
//     } catch (e) {
//       log('Error: $e');
//       if (mounted) {
//         showCustomSnackBar(context, 'Something wrong', orange);
//       }
//       return [];
//     }
//   }
// }


// import 'dart:async';
// import 'dart:typed_data';

// import 'package:draggable_bottom_sheet_nullsafety/draggable_bottom_sheet_nullsafety.dart';
// import 'package:flutter/material.dart';
// import 'package:get/instance_manager.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:joojo_delivery/Controllers/location_controller.dart';
// import 'package:joojo_delivery/Controllers/poylines_handler.dart';
// import 'package:joojo_delivery/Utils/colors.dart';
// import 'package:joojo_delivery/Utils/common_styles.dart';
// import 'package:joojo_delivery/Utils/images.dart';
// import 'package:joojo_delivery/Views/orders/orders.dart';
// import 'package:flutter/services.dart' show rootBundle;
// import 'dart:ui' as ui;

// import 'package:location/location.dart';

// class MapDelivertTracking extends StatefulWidget {
//   const MapDelivertTracking({
//     Key? key,
//   }) : super(key: key);

//   @override
//   State<MapDelivertTracking> createState() => _MapDelivertTrackingState();
// }

// class _MapDelivertTrackingState extends State<MapDelivertTracking> {
//   String? mapStyle;
//   Uint8List? customIcon;
//   static final userAddress = Get.find<LocationController>();

//   final CameraPosition _kGooglePlex = CameraPosition(
//     target: LatLng(userAddress.currentLat, userAddress.currentLng),
//     // 5.519568, -0.423074
//     zoom: 14,
//   );
//   GoogleMapController? mapController;
//   final Completer<GoogleMapController> _completer = Completer();

//   Set<Marker> markers = <Marker>{};

//   Uint8List? marketimages;
//   List<String> images = [
//     CustomeImages.ride,
//     CustomeImages.drop,
//   ];

//   // created empty list of markers
//   final List<Marker> _markers = <Marker>[];
//   Set<Polyline> _polyline = {};
//   final List<LatLng> _latLen = <LatLng>[
//     // const LatLng(5.5614341, -0.4651324),
//     LatLng(userAddress.currentLat, userAddress.currentLng),
//     const LatLng(5.5066596, -0.4489551)
//   ];

//   @override
//   void initState() {
//     rootBundle.loadString('asset/map_style.txt').then((string) {
//       mapStyle = string;
//       loadData();

//       // getCurrentLocation();
//     });
//     super.initState();
//   }

//   LocationData? currentLocation;
//   void getCurrentLocation() async {
//     Location location = Location();
//     location.getLocation().then(
//       (location) {
//         currentLocation = location;
//         print("Updated location");
//       },
//     );
//     GoogleMapController googleMapController = await _completer.future;
//     location.onLocationChanged.listen(
//       (newLoc) {
//         currentLocation = newLoc;
//         googleMapController.animateCamera(
//           CameraUpdate.newCameraPosition(
//             CameraPosition(
//               zoom: 13.5,
//               target: LatLng(
//                 newLoc.latitude!,
//                 newLoc.longitude!,
//               ),
//             ),
//           ),
//         );
//         loadData();
//         setState(() {});
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     // loadData();
//     return Scaffold(
//       appBar: AppBar(),
//       // extendBodyBehindAppBar: true,
//       backgroundColor: Colors.black,
//       body: DraggableBottomSheet(
//         // blurBackground: false,
//         backgroundWidget: Scaffold(
//           backgroundColor: Colors.red,
//           body: GoogleMap(
//             // cameraTargetBounds: ,
//             // mapType: MapType.hybrid,
//             mapType: MapType.normal,
//             myLocationEnabled: true,

//             initialCameraPosition: _kGooglePlex,
//             markers: Set<Marker>.of(_markers),
//             polylines: _polyline,
//             zoomGesturesEnabled: true,
//             zoomControlsEnabled: false,
//             compassEnabled: true,
//             onMapCreated: (GoogleMapController controller) {
//               mapController = controller;
//               mapController!.setMapStyle(mapStyle);
//               _completer.complete(controller);
//             },
//           ),
//         ),
//         expandedChild: Container(
//           padding: const EdgeInsets.symmetric(horizontal: 16),
//           decoration: const BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(20),
//               topRight: Radius.circular(20),
//             ),
//           ),
//           child: SingleChildScrollView(
//             physics: const NeverScrollableScrollPhysics(),
//             child: Column(
//               children: <Widget>[
//                 Image.asset(CustomeImages.divider),
//                 Padding(
//                   padding: const EdgeInsets.only(bottom: 20),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Row(
//                         children: [
//                           customeCircleAvater(size: 60),
//                           const SizedBox(
//                             width: 14,
//                           ),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 "Jacob Awe",
//                                 style: largeTextStyle.copyWith(fontSize: 20),
//                               ),
//                               Text(
//                                 "awejacob@gmail.com",
//                                 style: smallTextStyle.copyWith(
//                                     color: CustomeColors.lightBlack),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Row(
//                       children: [
//                         Image.asset(CustomeImages.call),
//                         const SizedBox(width: 24),
//                         Image.asset(CustomeImages.msg),
//                       ],
//                     ),
//                     Row(
//                       children: [
//                         Text(
//                           "Delivery Fee:",
//                           style: mediumTextStyle.copyWith(
//                               color: CustomeColors.lightBlack),
//                         ),
//                         const SizedBox(width: 10),
//                         Text(
//                           "Gh20",
//                           style: largeTextStyle.copyWith(
//                               color: const Color(0xffFF4500), fontSize: 20),
//                         )
//                       ],
//                     )
//                   ],
//                 ),
//                 spacer,
//                 Row(
//                   children: [
//                     Expanded(
//                         child: Text(
//                       "4517 Washington Ave. Manchester, Kentucky 39495",
//                       style: mediumTextStyle.copyWith(fontSize: 14),
//                     )),
//                     const SizedBox(
//                       width: 20,
//                     ),
//                     const Text("120KM")
//                   ],
//                 )
//               ],
//             ),
//           ),
//         ),
//         minExtent: 300,
//         maxExtent: MediaQuery.of(context).size.height * 0.3,
//       ),
//     );
//   }

//   loadData() async {
//     await getPolyLines(pickUp: _latLen[0], dropOff: _latLen[1]);

//     for (int i = 0; i < images.length; i++) {
//       final Uint8List markIcons = await getImages(images[i], 100);
//       // makers added according to index
//       _markers.add(Marker(
//         // given marker id
//         markerId: MarkerId(i.toString()),
//         // given marker icon
//         icon: BitmapDescriptor.fromBytes(markIcons),
//         // given position
//         position: _latLen[i],
//         infoWindow: InfoWindow(
//           // given title for marker
//           title: 'Location: $i',
//         ),
//       ));
//       setState(() {
//         _polyline = polyLine;
//       });
//     }
//   }

//   Future<Uint8List> getImages(String path, int width) async {
//     ByteData data = await rootBundle.load(path);
//     ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
//         targetHeight: width);
//     ui.FrameInfo fi = await codec.getNextFrame();
//     return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
//         .buffer
//         .asUint8List();
//   }
// }

// ///
// //  Image.asset(CustomeImages.divider),
// //               Material(
// //                 color: const Color(0xffF7F8FA),
// //                 shape: RoundedRectangleBorder(
// //                     borderRadius: BorderRadius.circular(6)),
// //                 child: TextField(
// //                   decoration: InputDecoration(
// //                       prefixIcon: const Icon(
// //                         FeatherIcons.search,
// //                         color: CustomeColors.lightBlack,
// //                       ),
// //                       hintText: "Search rider",
// //                       hintStyle: smallTextStyle.copyWith(
// //                           fontWeight: FontWeight.normal,
// //                           color: CustomeColors.lightBlack),
// //                       // filled: true,
// //                       border: InputBorder.none),
// //                 ),
// //               ),
// //               const SizedBox(
// //                 height: 21,
// //
// //           ),
// ///

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
      wayPoints.add( WayPoint(
      name: "Location", latitude: widget.from.latitude, longitude: widget.from.longitude, isSilent: false));
      wayPoints.add(WayPoint(
      name: "Destination",
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
    return Scaffold(
     
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
          Container(
            color: Theme.of(context).cardColor,
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                // CommonButton(onPressed: (){},title: "Start Trip",),
                SafeArea(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: OrderButton(
                          title: "Start Route",
                          textColor: black,
                          borderColor: black,
                          onTap: _routeBuilt && !_isNavigating
                              ? () {
                                  _controller?.startNavigation();
                                }
                              : null,
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: OrderButton(
                          title: "End Route",
                          textColor: black,
                          borderColor: black,
                          onTap: _isNavigating
                              ? () {
                                  _controller?.finishNavigation();
                                }
                              : null,
                        ),
                      ),
                    ],
                  ),
                ),
              
              ],
            ),
          ),
        ]),
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
          _scaleDialog();
          if (kDebugMode) {
            print("asbHJFBDSHJBFJDSBFJBDSFJBDSJFBS");
          }
        });
        break;
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
    // GoogleMapController googleMapController = await _controller.future;
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

