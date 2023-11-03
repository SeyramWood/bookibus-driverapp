import 'dart:async';
import 'dart:io';
import 'dart:developer';

import 'package:bookihub/src/shared/constant/colors.dart';
import 'package:bookihub/src/shared/utils/show.snacbar.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

import '../provider/current_location_controller.dart';

class RouteMap extends StatefulWidget {
  const RouteMap({super.key, required this.from, required this.to});
  final LatLng from;
  final LatLng to;

  @override
  State<RouteMap> createState() => _RouteMapState();
}

class _RouteMapState extends State<RouteMap> {
  final Location _locationController = Location();
  static const LatLng _kGoil = LatLng(5.1115, -1.2790);
  static const LatLng _kend = LatLng(5.1345, -1.2500);
  LatLng? _currentLocation;
  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();

  @override
  void initState() {
    super.initState();
    getLocationUpdates().then(
      (_) {
        getPolylinePoints().then(
          (value) => print(value),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ValueListenableBuilder(
            valueListenable: UpdateCurrentLocation(),
            builder: (context, currentLocation, _) {
              return GoogleMap(
                initialCameraPosition:
                    CameraPosition(target: currentLocation, zoom: 8),
                onMapCreated: (controller) {
                  _mapController.complete(controller);
                  cameraPosition(currentLocation);
                },
                zoomGesturesEnabled: true,
                scrollGesturesEnabled: true,
                markers: {
                  Marker(
                    markerId: const MarkerId('_currentLocation'),
                    position: currentLocation,
                    icon: BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueCyan),
                  ),
                  Marker(
                    markerId: const MarkerId('departureLocation'),
                    position: widget.from,
                    icon: BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueGreen),
                  ),
                  Marker(
                      markerId: const MarkerId('destination'),
                      position: widget.to,
                      icon: BitmapDescriptor.defaultMarker),
                },
                // polylines: {
                //   const Polyline(
                //       polylineId: PolylineId('destination'),
                //       points: [_kGoil, _kend])
                // },
              );
            }));
  }

  Future<void> cameraPosition(LatLng pos) async {
    final GoogleMapController controller = await _mapController.future;
    {
      await controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: pos, zoom: 9),
        ),
      );
    }
  }

  Future<void> getLocationUpdates() async {
    {
      bool isServiceEnabled;
      PermissionStatus persmissionGranted;

      isServiceEnabled = await _locationController.serviceEnabled();
      if (!isServiceEnabled) {
        isServiceEnabled = await _locationController.requestService();
      }

      persmissionGranted = await _locationController.hasPermission();
      if (persmissionGranted == PermissionStatus.denied) {
        persmissionGranted = await _locationController.requestPermission();
      }

      _locationController.onLocationChanged.listen(
        (currentLocation) {
          if (currentLocation.latitude != null &&
              currentLocation.longitude != null) {
            if (mounted) {
              UpdateCurrentLocation().cLocation(LatLng(
                  currentLocation.latitude!, currentLocation.longitude!));
            }
          }
        },
      );
    }
  }

  Future<List<LatLng>> getPolylinePoints() async {
    try {
      List<LatLng> coordinates = [];
      PolylinePoints polylinePoints = PolylinePoints();

      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        'AIzaSyDUU4gkWcf_O1o_vq6hh4tlFJHqymjJhxc',
        PointLatLng(_kGoil.latitude, _kGoil.longitude),
        PointLatLng(_kend.latitude, _kend.longitude),
        travelMode: TravelMode.driving,
      );
      log(result.points[0].latitude.toString());

      if (result.points.isNotEmpty) {
        for (var pointLatLng in result.points) {
          var newPoint = LatLng(pointLatLng.latitude, pointLatLng.longitude);
          coordinates.add(newPoint);
        }
      } else {
        print(result.errorMessage);
      }
      return coordinates;
    } on SocketException catch (_) {
      if (mounted) {
        showCustomSnackBar(
            context, 'You are offline. Check your connection.', orange);
      }
      return [];
    } catch (e) {
      log('Error: $e');
      if (mounted) {
        showCustomSnackBar(context, 'Something wrong', orange);
      }
      return [];
    }
  }
}
