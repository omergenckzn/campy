import 'package:campy/components/components.dart';
import 'package:campy/components/contstants.dart';
import 'package:campy/services/AuthService.dart';
import 'package:campy/services/FirestoreService.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  AuthService authService = AuthService();
  FirestoreService firestoreService = FirestoreService();
  String userStatus = '';
  Components components = Components();
  Constants constants = Constants();
  FirebaseStorage storageInstance = FirebaseStorage.instance;
  late dynamic data;

  @override
  Widget build(BuildContext context) {
    double sizeModifier = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar_ProfileView(context, components, constants, 'Profile'),
      body: Padding(
        padding: components.paddingEdgeInsectsVertical(
            context, sizeModifier * 0.0002),
        child: userId(context),
      ),
    );
  }

  AppBar AppBar_ProfileView(BuildContext context, Components components,
      Constants constants, String title) {
    return AppBar(
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () {
            setState(() {});
            Navigator.pushNamed(context, '/profileSettings', arguments: {
              'name': data['name'],
              'username': data['username'],
              'emailAddress': data['emailAddress'],
              'profileImageUrl': data['profileImageUrl'],
              'userId' : data['id'],
              'password' : data['password']
            });
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
    );
  }

  Widget userId(context) {
    bool condition = authService.checkUserLoggedIn();
    double sizeModifier = MediaQuery.of(context).size.width;

    if (condition == true) {
      String uid = authService.userInstance.currentUser!.uid;

      return StreamBuilder(
          stream: firestoreService.firebaseFirestoreInstance
              .collection('users')
              .doc(uid)
              .snapshots(), //firestoreInstance.collection('users').doc(uid).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              data = snapshot.data;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 15,
                    child: Center(
                      child: circleProfileImage(
                          sizeModifier, data['profileImageUrl'], data['name']),
                    ),
                  ),
                  Spacer(
                    flex: 2,
                  ),
                  Expanded(
                    child: Text(
                      data['name'],
                      style: GoogleFonts.quicksand(
                          color: constants.darkGreyColor,
                          fontSize: 32,
                          fontWeight: FontWeight.w700),
                    ),
                    flex: 6,
                  ),
                  Expanded(
                    child: Text(
                      '@${data['username']}',
                      style: GoogleFonts.quicksand(
                          color: constants.darkGreyColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                    flex: 4,
                  ),
                  Spacer(),
                  Expanded(
                    child: Placeholder(),
                    flex: 32,
                  ),
                ],
              );
            } else {
              return Text('Error');
            }
          });
    } else {
      return Text('Null');
    }
  }

  Widget circleProfileImage(double sizeModifier, String url, String name) {
    if (url == '') {
      return Container(
        width: sizeModifier * 0.4,
        height: sizeModifier * 0.4,
        child: Center(
          child: Text(
            name.substring(0, 1).toUpperCase(),
            style: GoogleFonts.quicksand(
                fontWeight: FontWeight.w700,
                fontSize: sizeModifier * 0.25,
                color: constants.darkGreyColor),
          ),
        ),
        decoration: BoxDecoration(
            color: constants.limeGreen,
            shape: BoxShape.circle,
            boxShadow: const [
              BoxShadow(
                spreadRadius: 1,
                blurRadius: 20,
                color: Color.fromRGBO(0, 0, 0, 0.25),
              )
            ]),
      );
    } else {
      return Material(
        borderRadius: BorderRadius.circular(1000),
        elevation: 20,
        child: CircleAvatar(
          foregroundImage: NetworkImage(data['profileImageUrl']),
          radius: sizeModifier * 0.17,
          backgroundColor: constants.limeGreen,
        ),
      );
    }
  }
}
