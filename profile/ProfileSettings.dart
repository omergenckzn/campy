import 'dart:io';

import 'package:campy/components/components.dart';
import 'package:campy/components/contstants.dart';
import 'package:campy/register/CampyRegister.dart';
import 'package:campy/services/FireStorageService.dart';
import 'package:campy/services/FirestoreService.dart';
import 'package:campy/services/ImageUploader.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileSettings extends StatefulWidget {
  const ProfileSettings({Key? key}) : super(key: key);

  @override
  _ProfileSettingsState createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  Components components = Components();
  Constants constants = Constants();
  CampyRegister campyRegister = CampyRegister();
  bool _isVisible = false;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var route = ModalRoute.of(context);
    if (route == null) return CircularProgressIndicator();
    Map data = route.settings.arguments as Map;
    String name = data['name'];
    String url = data['profileImageUrl'];
    String emailAddress = data['emailAddress'];
    String username = data['username'];
    String id = data['userId'];
    String password = data['password'];
    double sizeModifier = MediaQuery.of(context).size.width;


    FireStorageService storageService = FireStorageService();
    FirestoreService firestoreService = FirestoreService();



    return Scaffold(
      appBar: AppBarProfileSettings(),
      body: Padding(
        padding: components.paddingEdgeInsectsVertical(
            context, sizeModifier * 0.0002),
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                fit: StackFit.loose,
                children: [
                  circleProfileImage(sizeModifier, url, name,url),
                  Positioned(
                    top: sizeModifier * 0.29,
                    left: sizeModifier * 0.25,
                    child: ElevatedButton(
                      onPressed: () {
                        ImageUploader imageUploader = ImageUploader();
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              if (Platform.isIOS) {
                                return AlertDialog(
                                  title:
                                      const Text('Change Your Profile Image'),
                                  content: const Text(
                                      'Pick image from gallery or take a photo'),
                                  actions: [
                                    CupertinoDialogAction(
                                      child: Text('Gallery'),
                                      onPressed: () async {
                                        String imagePath =  await imageUploader.getImageFromGallery();
                                        setState(() {
                                          _isVisible = true;
                                        });
                                        if(imagePath != null) {
                                          String downloadUrl = await storageService.uploadFile(imagePath, data['userId']);
                                          await firestoreService.uploadImageUrl(downloadUrl, data['userId']);
                                          _isVisible = false;
                                          Navigator.pushNamedAndRemoveUntil(context, '/profileView', (route) => false);

                                        }else{
                                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Something went wrong')));
                                          Navigator.pop(context);
                                        }
                                      },
                                    ),
                                    CupertinoDialogAction(
                                      child: Text('Camera'),
                                      onPressed: () async {
                                        String imagePath = await imageUploader.getImageFromCamera();
                                        setState(() {
                                          _isVisible = true;
                                        });
                                        // ignore: unnecessary_null_comparison
                                        if (imagePath != null) {
                                          String downloadUrl = await storageService.uploadFile(imagePath, data['userId']);
                                          await firestoreService.uploadImageUrl(downloadUrl, data['userId']);
                                          _isVisible = false;
                                          Navigator.pushNamedAndRemoveUntil(context, '/profileView', (route) => false);

                                        }else {
                                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Something went wrong')));
                                          Navigator.pop(context);
                                        }

                                      },
                                    )
                                  ],
                                );
                              } else {
                                return AlertDialog(
                                  title:
                                      const Text('Change Your Profile Image'),
                                  content: const Text(
                                      'Pick image from gallery or take a photo'),
                                  actions: [
                                    TextButton(
                                        onPressed: () async {
                                          String imagePath =  await imageUploader.getImageFromGallery();
                                          setState(() {
                                            _isVisible = true;
                                          });
                                         // ignore: unnecessary_null_comparison
                                         if(imagePath != null) {
                                           String downloadUrl = await storageService.uploadFile(imagePath, data['userId']);
                                           await firestoreService.uploadImageUrl(downloadUrl, data['userId']);
                                            _isVisible = false;
                                            Navigator.pushNamedAndRemoveUntil(context, '/profileView', (route) => false);

                                         }else{
                                           ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Something went wrong')));
                                           Navigator.pop(context);
                                         }
                                        },
                                        child: Text('Gallery')),
                                    TextButton(
                                        onPressed: () async {
                                          String imagePath = await imageUploader.getImageFromCamera();
                                          setState(() {
                                            _isVisible = true;
                                          });
                                          // ignore: unnecessary_null_comparison
                                          if (imagePath != null) {
                                            String downloadUrl = await storageService.uploadFile(imagePath, data['userId']);
                                           await firestoreService.uploadImageUrl(downloadUrl, data['userId']);
                                            _isVisible = false;
                                            Navigator.pushNamedAndRemoveUntil(context, '/profileView', (route) => false);

                                          }else {
                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Something went wrong')));
                                            Navigator.pop(context);
                                          }

                                        },
                                        child: Text('Camera'))
                                  ],
                                );
                              }
                            });
                      },
                      child: Icon(
                        Icons.camera_alt,
                        color: constants.limeGreen,
                        size: 17,
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: constants.darkGreyColor,
                          shape: CircleBorder(
                              side: BorderSide(
                            color: Colors.white,
                            width: 1.5,
                          ))),
                    ),
                  ),
                  Visibility(child: CircularProgressIndicator(), visible: _isVisible,),
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Form(
                key: formKey,
                child: Padding(
                  padding:
                      components.presetPaddingEdgeInsectsHorizontal(context),
                  child: SingleChildScrollView(
                    physics: ClampingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: sizeModifier * 0.03,
                            ),
                            Text(
                              'Edit your name',
                              style: GoogleFonts.quicksand(
                                  fontWeight: FontWeight.w400, fontSize: 16),
                            ),
                          ],
                        ),
                        CupertinoTextFormFieldRow(
                          validator: (value) {
                            if(value != null) {
                              if(value.length < 2){
                                return 'The Name must be at least 2 characters';
                              }
                            }
                            if(value == null || value.isEmpty){
                              return 'Please Enter Your Name';
                            }
                            return null;
                          },
                          textInputAction: TextInputAction.none,
                          padding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: constants.darkGreyColor, width: 1.8),
                          ),
                          placeholder: name,
                          style: components.fontStyle400,
                          onChanged: (value) {
                            username = value;
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: sizeModifier * 0.03,
                            ),
                            Text(
                              'Edit your username',
                              style: GoogleFonts.quicksand(
                                  fontWeight: FontWeight.w400, fontSize: 16),
                            ),
                          ],
                        ),
                        CupertinoTextFormFieldRow(
                          validator: (value) {
                            if(value != null) {
                              if(value.length < 5){
                                return 'The username must be at least 6 characters';
                              }
                            }
                            if(value == null || value.isEmpty){
                              return 'Please Enter Valid Username';
                            }
                            return null;
                          },
                          textInputAction: TextInputAction.none,
                          padding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: constants.darkGreyColor, width: 1.8),
                          ),
                          placeholder: data['username'],
                          style: components.fontStyle400,
                          onChanged: (value) {
                            name = value;
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: sizeModifier * 0.03,
                            ),
                            Text(
                              'Edit your email',
                              style: GoogleFonts.quicksand(
                                  fontWeight: FontWeight.w400, fontSize: 16),
                            ),
                          ],
                        ),
                        CupertinoTextFormFieldRow(
                          validator: (value) {
                            if (EmailValidator.validate(emailAddress)) {
                              return null;
                            } else {
                              return 'Please Enter A Valid Email';
                            }
                          },
                          textInputAction: TextInputAction.none,
                          padding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: constants.darkGreyColor, width: 1.8),
                          ),
                          placeholder: emailAddress,
                          style: components.fontStyle400,

                          onChanged: (value) {
                            emailAddress = value;
                          },
                        ),
                        SizedBox(
                          height: 70,
                        ),
                        ElevatedButton(
                          child: campyRegister.inButtonText(
                              sizeModifier, constants.darkGreyColor, 'Save!'),
                          onPressed: () async {
                            if(formKey.currentState!.validate()) {
                             await firestoreService.addUpdateUser(id, name, username, password, emailAddress);
                             ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('You successfully update your credentials')));
                             setState(() {

                             });
                             Navigator.pushNamedAndRemoveUntil(context, '/mainNavigationScreen', (route) => false);

                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Something went wrong. Please Try Aagain ')));
                              setState(() {
                              });

                            }
                          },
                          style: ElevatedButton.styleFrom(
                              minimumSize: Size(50, 50),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(
                                      color: constants.darkGreyColor,
                                      width: sizeModifier * 0.006)),
                              primary: constants.greenColor),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  AppBar AppBarProfileSettings() {
    return AppBar(
      backgroundColor: constants.darkGreyColor,
      centerTitle: true,
      leading: IconButton(
        icon: Icon(Icons.chevron_left_outlined),
        iconSize: 30,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Text(
        'Profile',
        style: components.fontStyle700,
      ),
      actions: [
        IconButton(
            iconSize: 20,
            onPressed: () {
              Navigator.pushNamed(context, '/profileDelete');
            },
            icon: Icon(Icons.close)),
        SizedBox(
          width: 5,
        )
      ],
    );
  }

  Widget circleProfileImage(double sizeModifier, String url, String name,String imageUrl) {
    if (url == '') {
      return Container(
        width: sizeModifier * 0.4,
        height: sizeModifier * 0.4,
        child: Center(
          child: Text(
            name.substring(0, 1).toUpperCase(),
            style: GoogleFonts.quicksand(
                fontWeight: FontWeight.w700,
                fontSize: sizeModifier * 0.24,
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
          foregroundImage: NetworkImage(imageUrl),
          radius: sizeModifier * 0.19,
          backgroundColor: constants.limeGreen,
        ),
      );
    }
  }
}
