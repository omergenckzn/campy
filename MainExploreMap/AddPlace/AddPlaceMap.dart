import 'dart:io';

import 'package:campy/components/components.dart';
import 'package:campy/components/contstants.dart';
import 'package:campy/services/FirestoreService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddPlaceMap extends StatefulWidget {
  const AddPlaceMap({Key? key}) : super(key: key);

  @override
  State<AddPlaceMap> createState() => _MainExploreMapState();
}

class _MainExploreMapState extends State<AddPlaceMap> {
  late BitmapDescriptor pinLocationIcon;
  late dynamic data;
  late var currloc;
  late GoogleMapController mapController;
  late var customIcon;
  FirestoreService firestoreService = FirestoreService();

  @override
  void initState() {
    super.initState();
    setCustomMarker();
    Geolocator.getCurrentPosition().then((currLoc) {
      setState(() {
        currloc = currLoc;
      });
    });


  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void setCustomMarker() async {
    customIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 5, size: Size.fromRadius(20)),
        'assets/locationpingicon.png');
  }


  @override
  Widget build(BuildContext context) {
    Components components = Components();
    Constants constants = Constants();

    var route = ModalRoute.of(context);
    if (route == null) return CircularProgressIndicator();
    Map data = route.settings.arguments as Map;
    String placeName = data['placeName'];
    List placeType = data['placeTypeList'];
    List<dynamic> placePricing = data['placePricing'];
    bool placeWater = data['placeWater'];
    bool placeFood = data['placeFood'];
    bool placeToilet = data['placeToilet'];
    var placeImagePath = data['placeImagePath'];

    print(placeName);
    print(placeType);
    print(placePricing);
    print(placeWater);
    print(placeFood);
    print(placeToilet);
    print(placeImagePath);





    return Scaffold(
        appBar: components.AppBar_SpecialText(
            context, components, constants, 'Explore'),
        body: FutureBuilder(
            future: Geolocator.isLocationServiceEnabled(),
            builder: (BuildContext context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.hasError) {
                  return Text('Please Check Your Location Service');
                } else {
                  if (snapshot.data == true) {

                    return Stack(
                      children: [
                        StreamBuilder<QuerySnapshot>(
                            stream: firestoreService.firebaseFirestoreInstance
                                .collection('locations')
                                .snapshots(),
                            builder: (context, AsyncSnapshot snapshots) {
                              if (snapshots.hasError) {
                                return Text('No Data');
                              } else {
                                if (snapshot.hasData) {
                                  if (snapshots.data != null) {


                                    List<DocumentSnapshot> locationsList =
                                        snapshots.data.docs;

                                    Iterable myMarkers = Iterable.generate(
                                        locationsList.length, (index) {
                                      return Marker(
                                        onTap: () {
                                          print(locationsList[index]['lat']);
                                        },
                                        markerId: MarkerId(
                                            locationsList[index]['id']),
                                        icon: customIcon,
                                        position: LatLng(
                                          locationsList[index]['lat'],
                                          locationsList[index]['lon'],
                                        ),
                                        infoWindow: InfoWindow(
                                            title: locationsList[index]
                                                ["title"]),
                                      );
                                    });

                                    return FutureBuilder(
                                        future: Geolocator.getCurrentPosition()
                                            .then((value) => currloc = value),
                                        builder: (context, futureSnapshots) {
                                          if (futureSnapshots.hasData) {
                                            if (futureSnapshots.hasError) {
                                              return Center(
                                                  child:
                                                      CircularProgressIndicator());
                                            } else {
                                              setState(() {
                                                showDialog(
                                                    context: context,
                                                    builder: (BuildContext context) {
                                                      if (Platform.isIOS) {
                                                        return AlertDialog(
                                                          title:
                                                          const Text('Can you locate the place'),
                                                          content: const Text(
                                                              'If not please continue'),
                                                          actions: [
                                                            CupertinoDialogAction(
                                                              child: Text('OK'),
                                                              onPressed: () async {
                                                                Navigator.of(context).pop();

                                                              },
                                                            )
                                                          ],
                                                        );
                                                      } else {
                                                        return AlertDialog(
                                                          title:
                                                          const Text('Can you locate the place'),
                                                          content: const Text(
                                                              'If not please continue'),
                                                          actions: [
                                                            TextButton(
                                                                onPressed: () async {
                                                                  Navigator.of(context).pop();

                                                                },
                                                                child: Text('OK'))
                                                          ],
                                                        );
                                                      }
                                                    });
                                              });
                                              return GoogleMap(
                                                zoomControlsEnabled: false,
                                                myLocationEnabled: true,
                                                onMapCreated: _onMapCreated,
                                                initialCameraPosition:
                                                    CameraPosition(
                                                  target: LatLng(
                                                      currloc.latitude,
                                                      currloc.longitude),
                                                  zoom: 10,
                                                ),
                                                markers: Set.from(myMarkers),
                                              );
                                              
                                            }
                                          } else {
                                            return Center(
                                                child:
                                                    CircularProgressIndicator());
                                          }
                                        });
                                  } else {
                                    return CircularProgressIndicator();
                                  }
                                } else {
                                  return CircularProgressIndicator();
                                }
                              }
                            }),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding:
                                  components.paddingEdgeInsectsAll(context),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: constants.darkGreyColor,
                                      shape: const CircleBorder(),
                                      padding: const EdgeInsets.all(15),
                                    ),
                                    child: const Icon(
                                      Icons.arrow_right_alt_sharp,
                                      color: Color.fromRGBO(196, 251, 109, 1),
                                      size: 40,
                                    ),
                                    onPressed: () {


                                    },
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.03,
                            )
                          ],
                        ),
                      ],
                    );
                  } else {
                    return Text('Please Check Your Location Service');
                  }
                }
              } else {
                return Text('Please Check Your Location Service');
              }
            }));

  }
}
