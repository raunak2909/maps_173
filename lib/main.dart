import 'package:flutter/material.dart';
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

  Set<Marker> marker = {
    Marker(
        markerId: MarkerId("Marker 1"),
        position: LatLng(26.2978, 73.0180),
        infoWindow: InfoWindow(
          title: "Mehrangarh Fort",
          snippet: "Jodhpur",
          onTap: (){

          },
        )
    ),
    Marker(
      markerId: MarkerId("Marker 2"),
      position: LatLng(27.3978, 73.0180),
    ),
    Marker(
        markerId: MarkerId("Marker 2"),
        position: LatLng(26.3978, 74.0180)
    ),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        markers: marker,
        onTap: (loc){
          marker.add(
              Marker(
                  markerId: MarkerId("New"),
                position: loc
              )
          );
          setState(() {

          });
        },
        initialCameraPosition: CameraPosition(
            target: LatLng(26.2978, 73.0180),
          zoom: 19,
          tilt: 85,
          bearing: 135
        ),
      ),
    );
  }
}


