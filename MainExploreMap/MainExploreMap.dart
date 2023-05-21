import 'package:campy/components/components.dart';
import 'package:campy/components/contstants.dart';
import 'package:campy/services/AuthService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../services/FirestoreService.dart';

import 'package:map_launcher/map_launcher.dart' as ML;

class MainExploreMap extends StatefulWidget {
  const MainExploreMap({Key? key}) : super(key: key);

  @override
  State<MainExploreMap> createState() => _MainExploreMapState();
}

class _MainExploreMapState extends State<MainExploreMap> {
  late BitmapDescriptor pinLocationIcon;
  Components components = Components();
  Constants constants = Constants();
  late dynamic data;
  late var currloc;
  late GoogleMapController mapController;
  FirestoreService firestoreService = FirestoreService();
  late var customIcon;
  AuthService authService = AuthService();


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
                                          showModalBottomSheet(
                                              context: context,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  20),
                                                          topRight:
                                                              Radius.circular(
                                                                  20))),
                                              builder: (context) => buildSheet(
                                                  locationsList[index],
                                                  context));
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
                                      Icons.add,
                                      color: Color.fromRGBO(196, 196, 196, 1),
                                      size: 40,
                                    ),
                                    onPressed: () {},
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

  Widget buildSheet(var locationData, context) {
    var userColRef =
        firestoreService.firebaseFirestoreInstance.collection('users');
    PageController pageController = PageController();
    List _conditionsList = locationData['conditions'];

    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Spacer(),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(57, 62, 70, 0.4),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  width: 44,
                  height: 4.5,
                )
              ],
            ),
          ),
          Expanded(
            flex: 8,
            child: Padding(
              padding: components.presetPaddingEdgeInsectsHorizontal(context),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  components.UniqueTextStyleWithSizeModifierW500(
                      locationData['title'], 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      placeTypeYellowText(locationData),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 40,
            child: Stack(
              alignment: AlignmentDirectional.topStart,
              children: [
                Container(
                    height: MediaQuery.of(context).size.width * 0.8,
                    width: MediaQuery.of(context).size.width * 2,
                    child: PageView.builder(
                      controller: pageController,
                      itemBuilder: (context, int itemIndex) {
                        return Image.network(
                            locationData['imageUrlList'][itemIndex + 1]);
                      },
                      itemCount: locationData['imageUrlList'][0],
                    )),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: 80,
                      child: Center(
                        child: SmoothPageIndicator(
                          controller: pageController,
                          effect: SlideEffect(
                            dotColor: constants.darkGreyColor,
                            activeDotColor: constants.limeGreen,
                          ),
                          count: locationData['imageUrlList'][0],
                          onDotClicked: (index) => pageController.animateToPage(
                              index,
                              duration: Duration(milliseconds: 250),
                              curve: Curves.bounceOut),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            flex: 8,
            child: Padding(
              padding: components.presetPaddingEdgeInsectsHorizontal(context),
              child: Row(
                children: [
                  Expanded(
                    flex: 8,
                    child: SizedBox(
                      child: Center(
                        child: ListView.builder(
                            itemBuilder: (context, index) {
                              return Text(
                                locationData['conditions'][index] + ' · ',
                                style: GoogleFonts.quicksand(
                                    fontWeight: FontWeight.normal,
                                    height: 2.3,
                                    fontSize: 16),
                              );
                            },
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: _conditionsList.length),
                      ),
                    ),
                  ),
                  Spacer(),
                  Expanded(
                    flex: 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            LikeButton(locationData['id']),
                            IconButton(
                              onPressed: () async {
                                final availableMaps =
                                    await MapLauncher.installedMaps;

                                await availableMaps.first.showMarker(
                                    coords: Coords(locationData['lat'],
                                        locationData['lon']),
                                    title: locationData['title'],
                                    description: locationData['id']);
                              },
                              icon: Icon(CupertinoIcons.arrow_swap),
                              iconSize: 30,
                            )
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );



  }
  Widget LikeButton(String placeId) {
    bool condition = authService.checkUserLoggedIn();
    if(condition) {
     String userUid =  authService.userInstance.currentUser!.uid;
     var streamFile = firestoreService.firebaseFirestoreInstance.collection('users').doc(userUid).snapshots();
     return StreamBuilder(
         stream: streamFile,
         builder: (context, snapshot) {
           if(snapshot.hasError) {
             //User data fetch is gone wrong error handle
             return IconButton(onPressed: (){
             }, icon: Icon(Icons.favorite));
           } else{
             if(snapshot.hasData) {
               if(data != null) {
                 var favLoc = data['favoriteLocations'] as List;
                 if(favLoc.contains(placeId)) {
                   return IconButton(onPressed: (){}, icon: Icon(Icons.favorite,color: constants.limeGreen,));
                 }else {
                  return IconButton(onPressed: (){}, icon: Icon(Icons.favorite,color: constants.darkGreyColor,));
                 }
               } else {
                 var data = [];
                 return Placeholder();
               }
             }else {
               //docs have not data
               return Placeholder();
             }
           }

     });
    }else {
      return IconButton(onPressed:(){
        //Tell user that you should login for it
        print("You should log in");

      }, icon: Icon(Icons.favorite));
    }
  }
}

Widget placeTypeYellowText(locationData) {
  Components components = Components();

  if (locationData['tags'][0] == 'Facility') {
    return components.smallYellowUnderLinedText('Facility', 30);
  }
  if (locationData['tags'][0] == 'Sea-side') {
    return components.smallYellowUnderLinedText('Sea-side', 30);
  }
  if (locationData['tags'][0] == 'Forest') {
    return components.smallYellowUnderLinedText('Forest', 22);
  }
  if (locationData['tags'][0] == 'Bay') {
    return components.smallYellowUnderLinedText('Bay', 15);
  }
  if (locationData['tags'][0] == 'Hill') {
    return components.smallYellowUnderLinedText('Hill', 12);
  }
  if (locationData['tags'][0] == 'Nat. Park') {
    return components.smallYellowUnderLinedText('Nat. Park', 32);
  } else {
    return CircularProgressIndicator();
  }
}
