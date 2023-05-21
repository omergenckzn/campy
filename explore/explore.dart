// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:campy/MainExploreMap/MainExploreMap.dart';
import 'package:campy/components/components.dart';
import 'package:campy/profile/ProfileView.dart';
import 'package:campy/services/AuthService.dart';
import 'package:campy/services/GeolocatorService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:campy/components/contstants.dart';
import 'package:geolocator/geolocator.dart';


class explore extends StatefulWidget {
  const explore({Key? key}) : super(key: key);

  @override
  _exploreState createState() => _exploreState();
}

class _exploreState extends State<explore> {
  AuthService authService = AuthService();
  Constants constants = Constants();
  Components components = Components();
  GeolocatorService geolocatorService = GeolocatorService();
  int _selectedIndex = 2;
  PageController pageController = PageController(initialPage: 2);
  bool locationStatus = false;


  void onTapped(index) {
    setState(() {
      _selectedIndex = index;
    });
    pageController.jumpToPage(index);
  }


  @override
  Widget build(BuildContext context)  {


    return Scaffold(
      // appBar: components.AppBar_SpecialText(context, components, constants, indexedTitle),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: pageController,
        children: [
          ProfileView(),
          Container(color: Colors.green),
          MainExploreMap(),
          Container(color: Colors.amber,),
          Container(color: Colors.black,)
        ],
      ),
      bottomNavigationBar: uniqueBottomNavigationBar(),
    );
  }

  BottomNavigationBar uniqueBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      backgroundColor: constants.darkGreyColor,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          label: '',
          backgroundColor: Colors.white,
          icon: Icon(
            CupertinoIcons.person_crop_circle,
          ),
        ),
        BottomNavigationBarItem(
          label: '',
          icon: Icon(CupertinoIcons.search),
        ),
        BottomNavigationBarItem(
          label: '',
          icon: Icon(CupertinoIcons.compass),
        ),
        BottomNavigationBarItem(
          label: '',
          icon: Icon(CupertinoIcons.heart_fill),
        ),
        BottomNavigationBarItem(
          label: '',
          icon: Icon(CupertinoIcons.envelope_fill),
        ),
      ],
      selectedItemColor: constants.greenColor,
      unselectedItemColor: constants.plainCoolWhite,
      currentIndex: _selectedIndex,
      onTap: onTapped,
    );
  }
}
