import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapPages extends StatefulWidget {
  const MapPages({super.key});

  @override
  State<MapPages> createState() => _MapPagesState();
}

class _MapPagesState extends State<MapPages> {
  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();
  Location _locationController = new Location();
  static const LatLng _pGooglePlex = LatLng(24.9778111, 67.0298876);
  static const LatLng _pApplePark = LatLng(24.9778111, 67.0298876);
  LatLng? _currentP = null;
  Map<PolylineId, Polyline> polylines = {};

  final String googleAPIKey = "AIzaSyCUY6VAILtkGzGr3bHVL-BK5YQNESabsAw";
  @override
  void initState() {
    super.initState();
    getLocationUpdates().then((_) => {
          getPolyLinePoints()
              .then((coordinates) => {generatePolylinesFromPoints(coordinates)})
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentP == null
          ? const Center(
              child: Text("Loading..."),
            )
          : GoogleMap(
              onMapCreated: ((GoogleMapController controller) =>
                  _mapController.complete(controller)),
              initialCameraPosition:
                  CameraPosition(target: _pGooglePlex, zoom: 18),
              markers: {
                Marker(
                    markerId: MarkerId("_currentLocation"),
                    icon: BitmapDescriptor.defaultMarker,
                    position: _currentP!),
                Marker(
                    markerId: MarkerId("_sourceLocation"),
                    icon: BitmapDescriptor.defaultMarker,
                    position: _pGooglePlex),
                Marker(
                    markerId: MarkerId("_destinationLocation"),
                    icon: BitmapDescriptor.defaultMarker,
                    position: _pApplePark)
              },
              polylines: Set<Polyline>.of(polylines.values),
            ),
    );
  }

  Future<List<LatLng>> getPolyLinePoints() async {
    List<LatLng> polyLineCoordinates = [];
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleApiKey: googleAPIKey,
      request: PolylineRequest(
          origin: PointLatLng(_pGooglePlex.latitude, _pGooglePlex.longitude),
          destination: PointLatLng(_pApplePark.latitude, _pApplePark.longitude),
          mode: TravelMode.driving),
    );
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polyLineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      print(result.errorMessage);
    }
    return polyLineCoordinates;
  }

  Future<void> _cameraToPosition(LatLng pos) async {
    final GoogleMapController controller = await _mapController.future;
    CameraPosition _newCameraPosition = CameraPosition(target: pos, zoom: 16);
    await controller
        .animateCamera(CameraUpdate.newCameraPosition(_newCameraPosition));
  }

  Future<void> getLocationUpdates() async {
    bool _serviceEnabled;
    PermissionStatus _PermissonGranted;
    _serviceEnabled = await _locationController.serviceEnabled();
    if (_serviceEnabled) {
      _serviceEnabled = await _locationController.requestService();
    } else {
      return;
    }
    _PermissonGranted = await _locationController.hasPermission();
    if (_PermissonGranted == PermissionStatus.denied) {
      _PermissonGranted = await _locationController.requestPermission();
      if (_PermissonGranted != PermissionStatus.granted) {
        return;
      }
    }
    _locationController.onLocationChanged
        .listen((LocationData currentLocation) {
      if (currentLocation.latitude != null &&
          currentLocation.longitude != null) {
        setState(() {
          _currentP =
              LatLng(currentLocation.latitude!, currentLocation.longitude!);
          _cameraToPosition(_currentP!);
        });
      }
    });
  }

  void generatePolylinesFromPoints(List<LatLng> PolyLineCoordinates) async {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id,
        color: Colors.black,
        points: PolyLineCoordinates,
        width: 8);
    setState(() {
      polylines[id] = polyline;
    });
  }
}
