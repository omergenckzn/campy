import 'package:campy/MainExploreMap/AddPlace/AddPlaceFood.dart';
import 'package:campy/MainExploreMap/AddPlace/AddPlaceMap.dart';
import 'package:campy/MainExploreMap/AddPlace/AddPlaceName.dart';
import 'package:campy/MainExploreMap/AddPlace/AddPlacePricing.dart';
import 'package:campy/MainExploreMap/AddPlace/AddPlaceToilet.dart';
import 'package:campy/MainExploreMap/AddPlace/AddPlaceType.dart';
import 'package:campy/MainExploreMap/MainExploreMap.dart';
import 'package:campy/explore/explore.dart';
import 'package:campy/profile/ProfileDelete.dart';
import 'package:campy/profile/ProfileSettings.dart';
import 'package:campy/profile/ProfileView.dart';
import 'package:campy/register/CreatingProfileAddress.dart';
import 'package:campy/register/CreatingProfilePassword.dart';
import 'package:campy/register/SignInView.dart';
import 'package:campy/register/login/LoginPassword.dart';
import 'package:campy/register/login/LoginView.dart';
import 'package:campy/services/AuthService.dart';
import 'package:campy/test/PageViewTest.dart';
import 'package:campy/test/StringUITest.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:campy/register/CampyRegister.dart';
import 'package:campy/register/creatingProfileUsername.dart';
import 'package:campy/test/TestPage.dart';
import 'package:permission_handler/permission_handler.dart';

import 'MainExploreMap/AddPlace/AddPlaceImage.dart';
import 'MainExploreMap/AddPlace/AddPlaceWater.dart';


void main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  AuthService authService = AuthService();
  String initialRoute = '';

  if (await Permission.location.request().isGranted) {
    initialRoute = '/mainNavigationScreen';
  }else {
    // You should add a error page for saying the user should give permission
    initialRoute = '/register';
  }


  if(authService.userInstance.currentUser != null) {
    initialRoute = '/mainNavigationScreen';
  }else {
    initialRoute = '/register';
  }


  runApp(MaterialApp(
      theme: ThemeData(fontFamily: 'Sfui'),
      debugShowCheckedModeBanner: false,
      initialRoute: initialRoute,


      routes: {
        '/mainNavigationScreen' : (context) => explore(),
        '/register' : (context) => CampyRegister(),
        '/signIn' : (context) => SignInView(),
        '/username' : (context) => CreatingProfileUsername(),
        '/emailAddress' : (context) => CreatingProfileAddress(),
        '/password' : (context) => CreatingProfilePassword(),
        '/loginEmail' : (context) => LoginEmailAddress(),
        '/loginPassword' : (context) => LoginPassword(),
        '/profileSettings' : (context) => ProfileSettings(),
        '/profileDelete' : (context) => ProfileDelete(),
        '/profileView': (context) => ProfileView(),
        '/test' : (context) => TestPage(),
        '/mapExplore': (context) => MainExploreMap(),
        '/stringTest' : (context) => StringUITest(),
        '/addPlaceName' : (context)  => AddPlaceName(),
        '/addPlaceType' : (context)  => AddPlaceType(),
        '/addPlacePricing' : (context) => AddPlacePricing(),
        '/addPlaceWater' : (context) => AddPlaceWater(),
        '/addPlaceFood' : (context) => AddPlaceFood(),
        '/addPlaceToilet' : (context) => AddPlaceToilet(),
        '/addPlaceImage' : (context) => AddPlaceImage(),
        '/addPlaceMap' : (context) => AddPlaceMap(),
        '/pageViewText': (context) => PageViewTest()

      }
  ));

}


