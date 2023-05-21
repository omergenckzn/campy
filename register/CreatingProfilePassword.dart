// ignore_for_file: file_names

import 'dart:io';

import 'package:campy/components/components.dart';
import 'package:campy/components/contstants.dart';
import 'package:campy/services/AuthService.dart';
import 'package:campy/services/FirestoreService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class CreatingProfilePassword extends StatefulWidget {
  const CreatingProfilePassword({Key? key}) : super(key: key);

  @override
  _SignInViewState createState() => _SignInViewState();
}

class _SignInViewState extends State<CreatingProfilePassword> {
  final formKey = GlobalKey<FormState>();
  AuthService authService = AuthService();
  FirestoreService firestoreService = FirestoreService();
  late String password;


  @override
  Widget build(BuildContext context) {
    //double sizeModifier = MediaQuery.of(context).size.width;
    Components components = Components();
    Constants constants = Constants();
    var route = ModalRoute.of(context);
    if (route == null) return CircularProgressIndicator();
    Map data = route.settings.arguments as Map;
    String name = data['name'];
    String username = data['username'];
    String emailAddress = data['emailAddress'];

    return Scaffold(
        appBar: components.AppBar_SpecialText(
            context, components, constants, 'Creating Profile'),
        body: Padding(
          padding: components.presetPaddingEdgeInsectsHorizontal(context),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                components.ImageUsername('assets/underlinedTextPassword.png'),
              CupertinoTextFormFieldRow(
                obscureText: true,
                validator: (value) {
                  if (value != null) {
                    if (value.length < 7) {
                      return 'The password must be at least 8 characters';
                    }
                  }
                  if (value == null || value.isEmpty) {
                    return 'Password Cannot be Empty';
                  }
                  return null;
                },
                textInputAction: TextInputAction.none,
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey, width: 2.5)),
                placeholder: 'Pick a Password',
                style: components.fontStyle400,
                onChanged: (value) {
                  password = value;
                },
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      //we get all the information bout user. Then we will register the user in db and create a basket with unique id.
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            if (Platform.isIOS) {
                              return AlertDialog(
                                title: const Text(
                                    'You will be registered in Campy.'),
                                content: const Text('Do you accept?'),
                                actions: [
                                  CupertinoDialogAction(
                                    child: Text('Yes'),
                                    onPressed: () async {
                                      //Creating user and registering
                                      await _createAccount(name, username, password, emailAddress);
                                    },
                                  ),
                                  CupertinoDialogAction(
                                    child: Text('No'),
                                    onPressed: () {
                                      Navigator.pushNamedAndRemoveUntil(context, '/register', (route) => false);
                                    },
                                  )
                                ],
                              );
                            } else {
                              return AlertDialog(
                                title: const Text(
                                    'You will be registered in Campy.'),
                                content: const Text('Do you accept?'),
                                actions: [
                                  TextButton(
                                      onPressed: () async {
                                        //Creating user and registering

                                       await _createAccount(name, username, password, emailAddress);

                                      }, child: Text('Yes')),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pushNamedAndRemoveUntil(context, '/register', (route) => false);
                                      },
                                      child: Text('No'))
                                ],
                              );
                            }
                          });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Enter a valid Password')));
                    }
                  },
                  child: components.ArrowIcon(),
                  style: ElevatedButton.styleFrom(
                    onSurface: constants.greenColor,
                    primary: constants.darkGreyColor,
                    onPrimary: constants.greenColor,
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(12),
                  ),
                ),
              ],
            )
              ],
            ),
          ),
        ));
  }

  _createAccount(name, username, password, emailAddress) async {
    final status = await authService.createUser(emailAddress, password);
    if (status == AuthResultStatus.successful) {
      // Navigate to success page
      await _login(emailAddress, password);
      String id = authService.userInstance.currentUser!.uid;
      firestoreService.addUpdateUser(id, name, username, password, emailAddress);
      Navigator.pushNamedAndRemoveUntil(context, '/mainNavigationScreen', (route) => false);


    } else {
      final errorMsg = AuthExceptionHandler.generateExceptionMessage(
          status);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$errorMsg')));
    }
  }

  _login(String email, String password) async {
    final status = await authService.logInUser(email, password,context);
    if (status == AuthResultStatus.successful) {
      // Navigate to success page
    } else {
      final errorMsg = AuthExceptionHandler.generateExceptionMessage(
          status);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$errorMsg')));

    }
  }



}
