// ignore_for_file: file_names

import 'package:campy/components/components.dart';
import 'package:campy/components/contstants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:email_validator/email_validator.dart';

class CreatingProfileAddress extends StatefulWidget {
  const CreatingProfileAddress({Key? key}) : super(key: key);

  @override
  _SignInViewState createState() => _SignInViewState();
}

class _SignInViewState extends State<CreatingProfileAddress> {
  final formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    double sizeModifier = MediaQuery.of(context).size.width;
    Components components = Components();
    Constants constants = Constants();
    var route = ModalRoute.of(context);
    if (route == null) return CircularProgressIndicator();
    Map data = route.settings.arguments as Map;
    String name = data['name'];
    String username = data['username'];
    String emailAddress = '';


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
                components.ImageUsername('assets/underlinedTextAddress.png'),
                CupertinoTextFormFieldRow(
                  validator: (value) {
                    if(EmailValidator.validate(emailAddress)){
                     return null;
                    }else {
                      return 'Please Enter A Valid Email';
                    }
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
                  placeholder: 'Enter your Email Address',
                  style: components.fontStyle400,
                  onChanged: (value) {
                    emailAddress = value;
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(onPressed: () {
                      if(formKey.currentState!.validate()){

                        Navigator.pushNamed(context, '/password',
                            arguments: {
                              'name': name,
                              'username' : username,
                              'emailAddress' : emailAddress,
                            });
                      }else{
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Enter a valid Email')));
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
