import 'package:campy/components/components.dart';
import 'package:campy/components/contstants.dart';
import 'package:campy/services/FirestoreService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {

  late GoogleMapController mapController;
  Components components = Components();
  Constants constants = Constants();
  late dynamic data;
  late Position currentLocation;
  FirestoreService firestoreService = FirestoreService();

  @override
  void initState() {
    super.initState();
    Geolocator.getCurrentPosition().then((currLoc)  {
      setState(() {
        currentLocation = currLoc;
      });
    });
  }


  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    String title = 'Explore';


    

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
            },
            icon: Icon(CupertinoIcons.gear_solid),
          ),
          SizedBox(
            width: 5,
          )
        ],
        title: Text(
          title,
          style: components.fontStyle700,
        ),
        backgroundColor: constants.greyThemeColor,
      ),
      body: SafeArea(
          child: getMarkers(context),
      ),

    );
  }
  Widget getMarkers(context) {
    FirestoreService firestoreService = FirestoreService();

    return StreamBuilder<QuerySnapshot>(
        stream: firestoreService.firebaseFirestoreInstance.collection('locations').snapshots(),
        builder: (context, AsyncSnapshot snapshots) {
          if (snapshots.hasError) {
            return Text('no data');
          } else {
            if (snapshots.hasData) {
              if (snapshots.data != null) {
                List<DocumentSnapshot> locationsList = snapshots.data.docs;

                Iterable myMarkers = Iterable.generate(locationsList.length, (index) {
                  return Marker(
                      markerId: MarkerId(locationsList[index]['id']),
                      position: LatLng(
                        locationsList[index]['lat'],
                        locationsList[index]['lon'],
                      ),
                      infoWindow: InfoWindow(title: locationsList[index]["title"]),
                  );
                });
                return GoogleMap(
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(currentLocation.latitude, currentLocation.longitude),
                    zoom: 10,
                  ),
                  markers: Set.from(myMarkers),
                );

              } else {
                return Center(child: CircularProgressIndicator(),);
              }
            } else {
              return Center(child: CircularProgressIndicator(),);
            }
          }
        });
  }

}


