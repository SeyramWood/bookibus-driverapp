import 'dart:async';

import 'package:bookihub/shared/constant/keys.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class RouteMap extends StatefulWidget {
  const RouteMap({super.key});

  @override
  State<RouteMap> createState() => _RouteMapState();
}

class _RouteMapState extends State<RouteMap> {
  final Location _locationController = Location();
  static const LatLng _kGooglePlex = LatLng(5.1115, -1.3064);
  static const LatLng _kend = LatLng(5.2115, -1.2064);
  LatLng? _currentLocation;
  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();
  @override
  void initState() {
    super.initState();
    getLocationUpdates();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: _currentLocation == null
          ? const Center(child: Text('Loading ...'))
          : mounted?GoogleMap(
              initialCameraPosition:
                  const CameraPosition(target: _kGooglePlex, zoom: 13),
              onMapCreated: (controller) => _mapController.complete(controller),
              markers: {
                Marker(
                  markerId: const MarkerId('_currentLocation'),
                  position: _currentLocation!,
                  icon: BitmapDescriptor.defaultMarker,
                ),
                const Marker(
                  markerId: MarkerId('sourceLocation'),
                  position: _kGooglePlex,
                  icon: BitmapDescriptor.defaultMarker,
                ),
                const Marker(
                  markerId: MarkerId('destination'),
                  position: _kend,
                  icon: BitmapDescriptor.defaultMarker,
                ),
              },
            ) :null ); }

  Future<void> cameraPosition(LatLng pos) async {
    final GoogleMapController controller = await _mapController.future;
    await controller.animateCamera(
        CameraUpdate.newCameraPosition(CameraPosition(target: pos, zoom: 13)));
  }

  Future<void> getLocationUpdates() async {
    print('I am here');

    bool isServiceEnabled;
    PermissionStatus persmissionGranted;
    isServiceEnabled = await _locationController.serviceEnabled();
    if (!isServiceEnabled) {
      isServiceEnabled = await _locationController.requestService();
    } else {
      print('I am here to');
      return;
    }

    persmissionGranted = await _locationController.hasPermission();

    if (persmissionGranted == PermissionStatus.denied) {
      persmissionGranted = await _locationController.requestPermission();
      if (persmissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    print('I am here also');

    _locationController.onLocationChanged.listen(
      (currentLocation) {
        if (currentLocation.latitude != null &&
            currentLocation.longitude != null) {
          setState(() {
            _currentLocation =
                LatLng(currentLocation.latitude!, currentLocation.longitude!);
            cameraPosition(_currentLocation!);
          });
        }
      },
    );
  }

  Future<List<LatLng>> getPolylinePoints() async {
    List<LatLng> coordinates = [];
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      Google_Maps_Api_Key,
      PointLatLng(_kGooglePlex.latitude, _kGooglePlex.longitude),
      PointLatLng(_kend.latitude, _kend.longitude),
      travelMode: TravelMode.driving,
    );
    if (result.points.isNotEmpty) {
      for (var pointLatLng in result.points) {
        var newPoint = LatLng(pointLatLng.latitude, 
        pointLatLng.longitude);
        coordinates.add(newPoint);
      }
    } else {
      print(result.errorMessage);
    }
    return coordinates;
  }
}
