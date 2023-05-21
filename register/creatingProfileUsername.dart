// ignore_for_file: file_names

import 'package:campy/components/components.dart';
import 'package:campy/components/contstants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class CreatingProfileUsername extends StatefulWidget {
  const CreatingProfileUsername({Key? key}) : super(key: key);

  @override
  _SignInViewState createState() => _SignInViewState();
}

class _SignInViewState extends State<CreatingProfileUsername> {
  final formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    double sizeModifier = MediaQuery.of(context).size.width;
    Components components = Components();
    Constants constants = Constants();
    String username = '';
    var route = ModalRoute.of(context);
    if (route == null) return CircularProgressIndicator();
    Map data = route.settings.arguments as Map;
    String name = data['name'];

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
                components.ImageUsername('assets/underlinedTextUsername.png'),
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
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: Colors.grey,
                          width: 2.5
                      )
                  ),
                  placeholder: 'Pick a Username',
                  style: components.fontStyle400,
                  onChanged: (value) {
                    username = value;
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(onPressed: () {
                      if(formKey.currentState!.validate()){


                        Navigator.pushNamed(context, '/emailAddress',
                            arguments: {
                              'name': name,
                              'username' : username,
                            });
                      }else{
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Enter a valid Username')));
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
