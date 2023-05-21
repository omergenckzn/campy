// ignore_for_file: file_names

import 'package:campy/components/components.dart';
import 'package:campy/components/contstants.dart';
import 'package:campy/services/AuthService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class SignInView extends StatefulWidget {
  const SignInView({Key? key}) : super(key: key);

  @override
  _SignInViewState createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {

  final formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    double sizeModifier = MediaQuery.of(context).size.width;
    Components components = Components();
    Constants constants = Constants();
    FirebaseAuth userInstance = FirebaseAuth.instance;
    AuthService userService = AuthService();
    String name = '';
    /// We are getting persons username in this page

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
                Row(
                  children: [
                    components.ImageUsername('assets/underlinedTextName.png'),
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
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.grey,
                      width: 2.5
                    )
                  ),
                  placeholder: 'Your Name',
                  style: components.fontStyle400,
                  onChanged: (value) {
                    name = value;
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(onPressed: () {
                      if(formKey.currentState!.validate()){

                        Navigator.pushNamed(context, '/username',
                            arguments: {
                              'name': name,
                            });
                      }else{
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Enter a valid Name')));
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
                ),
              ],
            ),
          ),
        ));
  }

}
