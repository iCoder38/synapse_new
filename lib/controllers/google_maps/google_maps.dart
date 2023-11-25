import 'dart:async';

import 'dart:math' as math;

import 'package:geolocator/geolocator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:synapse_new/controllers/screens/utils/utils.dart';

class GoogleMapsScreen extends StatefulWidget {
  const GoogleMapsScreen({super.key});

  @override
  State<GoogleMapsScreen> createState() => _GoogleMapsScreenState();
}

class _GoogleMapsScreenState extends State<GoogleMapsScreen> {
  //
  late LatLng _center;
  late Position currentLocation;
  //
  Completer<GoogleMapController> controller = Completer();
  //
  static const LatLng _center2 = LatLng(45.521563, -122.677433);

  // new lat long location
  LatLng initialLocation = const LatLng(37.422131, -122.084801);
  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;
  //
  // void _onMapCreated(GoogleMapController controller) {
  // _controller.complete(controller);
  // }

  //
  // void _getUserLocation() async {
  //   var position = await GeolocatorPlatform.instance
  //       .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

  //   setState(() {
  //     currentPostion = LatLng(position.latitude, position.longitude);
  //   });
  // }

  // Future<Position> locateUser() async {
  //   return Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.high);
  // }

  // getUserLocation() async {
  //   currentLocation = await locateUser();
  //   setState(() {
  //     _center = LatLng(currentLocation.latitude, currentLocation.longitude);
  //   });
  //   print('center $_center');
  // }

  @override
  void initState() {
    // getLocation();
    addCustomIcon();
    super.initState();
  }

  void addCustomIcon() {
    BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      "assets/images/attendance_icon.pn",
    ).then(
      (icon) {
        setState(() {
          markerIcon = icon;
        });
      },
    );
  }

  void getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    if (kDebugMode) {
      print('==================================');
      print('==================================');
      print(position.latitude);
      print(position.longitude);
      print('==================================');
      print('==================================');
    }
    //
    //
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: text_bold_roboto(
          //
          'Event location',
          Colors.black,
          16.0,
        ),
        backgroundColor: Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
            .withOpacity(1.0),
      ),
      // body:

      /*GoogleMap(
        initialCameraPosition: CameraPosition(
          target: initialLocation,
          zoom: 14,
        ),
        markers: {
          Marker(
            markerId: const MarkerId("marker1"),
            position: const LatLng(37.422131, -122.084801),
            draggable: true,
            onDragEnd: (value) {
              // value is the new position
            },
            icon: markerIcon,
          ),
          // const Marker(
          //   markerId: const MarkerId("marker2"),
          //   position: const LatLng(37.415768808487435, -122.08440050482749),
          // ),
        },
      ),*/
    );
    /*Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: text_bold_comforta(
          'Event location',
          Colors.white,
          16.0,
        ),
        backgroundColor: Colors.green[700],
      ),
      body: GoogleMap(
        // onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: initialLocation,
          zoom: 11.0,
        ),
      ),
    );*/
  }
}
