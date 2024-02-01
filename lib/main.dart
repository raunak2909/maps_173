import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Completer<GoogleMapController> mController = Completer<GoogleMapController>();

  Set<Marker> marker = {
    Marker(
        markerId: MarkerId("Marker 1"),
        position: LatLng(26.2978, 73.0180),
        infoWindow: InfoWindow(
          title: "Mehrangarh Fort",
          snippet: "Jodhpur",
          onTap: () {},
        )),
    Marker(
      markerId: MarkerId("Marker 2"),
      position: LatLng(27.3978, 73.0180),
    ),
    Marker(markerId: MarkerId("Marker 2"), position: LatLng(26.3978, 74.0180)),
  };

  @override
  void initState() {
    super.initState();

    getCurrentLoc();
  }

  void getCurrentLoc() async {
    if (await checkIfGetCurrLoc()) {
      var currPos = await Geolocator.getCurrentPosition();
      var currPosition = CameraPosition(
          target: LatLng(currPos.latitude, currPos.longitude), zoom: 19);
      var mapController = await mController.future;
      mapController.animateCamera(CameraUpdate.newCameraPosition(currPosition));
      print('Lat: ${currPos.latitude}, Lng: ${currPos.longitude}');

      /*marker.add(Marker(markerId: MarkerId("New"), position: LatLng(currPos.latitude, currPos.longitude)));
      setState(() {

      });*/
    } else {
      print(
          "Due to some location services errors, we are unable to get your location!");
    }
  }

  Future<bool> checkIfGetCurrLoc() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (serviceEnabled) {
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();

        if (permission == LocationPermission.denied) {
          return false;
        } else if (permission == LocationPermission.deniedForever) {
          return false;
        } else {
          return true;
        }
      } else {
        return true;
      }
    } else {
      print("Location services disabled!");
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        onMapCreated: (loadedController){
          mController.complete(loadedController);
        },
        mapType: MapType.satellite,
        markers: marker,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        onTap: (loc) {
          marker.add(Marker(markerId: MarkerId("New"), position: loc));
          setState(() {});
        },
        initialCameraPosition: CameraPosition(
            target: LatLng(26.2978, 73.0180), zoom: 19, tilt: 85, bearing: 135),
      ),
    );
  }
}
