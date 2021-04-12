import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'home/bottom_sheet.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Set<Marker> _markers = {};
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  Completer<GoogleMapController> _controllerGoogleMap = Completer();
  GoogleMapController newGoogleMapController;

  Position currentPosition;
  var geoLocator = Geolocator();

  double bottumPaddingOfMap = 0.0;

  void locatPosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;

    LatLng latLngPosition = LatLng(position.latitude, position.longitude);
    CameraPosition cameraPosition =
        new CameraPosition(target: latLngPosition, zoom: 14);

    newGoogleMapController = await _controllerGoogleMap.future;

    newGoogleMapController
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  @override
  void initState() {
    locatPosition();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
              padding: EdgeInsets.only(bottom: bottumPaddingOfMap),
              mapType: MapType.normal,
              myLocationEnabled: true,
              zoomGesturesEnabled: true,
              zoomControlsEnabled: true,
              //myLocationButtonEnabled: true,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controllerGoogleMap.complete(controller);
                setState(() {
                  bottumPaddingOfMap = 220.0;
                });
                locatPosition();
              },
            ),
            //Top Container
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      //Left Icon Clumn
                      Column(
                        children: [
                          Icon(
                            Icons.location_history,
                            color: Colors.grey,
                          ),
                          Container(
                            color: Colors.grey,
                            width: 1.5,
                            height: 30,
                          ),
                          //Divider(height: 60, color: Colors.red),
                          Icon(
                            Icons.location_on,
                            color: Colors.red,
                          ),
                        ],
                      ),

                      //Righ From TO Clumn
                      Padding(
                        padding: const EdgeInsets.only(left: 2),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                //From Location
                                Text(
                                  'From:',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 12),
                                  child: Text(
                                    'Down Twon Cairo',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Colors.grey),
                                  ),
                                ),
                              ],
                            ),

                            //LINE
                            Divider(
                              height: 15,
                            ),
                            Container(
                              color: Colors.grey,
                              width: 300,
                              height: 3,
                            ),
                            Divider(
                              height: 15,
                            ),

                            //To Location
                            Row(
                              children: [
                                Text(
                                  'To:',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 12),
                                  child: Text(
                                    'Nile Ritz-Carlton',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Colors.grey),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
//Bottom sheet
            CarBottomSheet()
          ],
        ),
      ),
    );
  }
}
