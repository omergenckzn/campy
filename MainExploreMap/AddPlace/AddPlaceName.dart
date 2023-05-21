import 'package:campy/components/components.dart';
import 'package:campy/components/contstants.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddPlaceName extends StatefulWidget {
  const AddPlaceName({Key? key}) : super(key: key);

  @override
  State<AddPlaceName> createState() => _AddPlaceNameState();
}

class _AddPlaceNameState extends State<AddPlaceName> {
  final formKey = GlobalKey<FormState>();
  Components components  = Components();
  Constants constants = Constants();

  @override
  Widget build(BuildContext context) {
    double sizeModifier = MediaQuery.of(context).size.width;
    String nameOfThisPlace = '';


    return Scaffold(
      appBar: components.AppBar_SpecialText_WithPopButton(context, components, constants, 'Add Place'),
       body: Padding(
         padding: components.paddingSymmetric(context),
         child: Form(
           key: formKey,
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             mainAxisAlignment: MainAxisAlignment.spaceAround,
             children: [
               Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Row(
                     children: [
                       components.UniqueTextStyle('What is the '),
                       components.yellowUnderlinedText('name',42),
                     ],
                   ),
                   components.UniqueTextStyle('of this place?'),
                 ],
               ),
               CupertinoTextFormFieldRow(
                 validator: (value) {
                   if (value != null) {
                     if (value.length < 3) {
                       return 'The place name must be at least 2 characters';
                     }
                   }
                   if (value == null || value.isEmpty) {
                     return 'Place name Cannot be Empty';
                   }
                   return null;

                 },
                 textInputAction: TextInputAction.none,
                 padding: EdgeInsets.symmetric(vertical: 10),
                 decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(10),
                     border: Border.all(
                         color: Colors.grey,
                         width: 3
                     )
                 ),
                 placeholder: 'Enter a place name',
                 style: components.fontStyle400,
                 onChanged: (value) {
                   nameOfThisPlace = value;
                 },
               ),
               Row(
                 mainAxisAlignment: MainAxisAlignment.end,
                 children: [
                   ElevatedButton(
                     onPressed: () {
                       if (formKey.currentState!.validate()) {
                         //we get all the information bout place.
                         Navigator.pushNamed(context, '/addPlaceType',
                             arguments: {
                               'placeName': nameOfThisPlace,
                             });
                       }
                     },
                     child: components.ArrowIcon(),
                     style: ElevatedButton.styleFrom(
                       onSurface: constants.greenColor,
                       primary: constants.darkGreyColor,
                       onPrimary: constants.greenColor,
                       shape: CircleBorder(),
                       padding: EdgeInsets.all(14),
                     ),
                   ),
                 ],
               ),
             ],
           ),
         ),
       )
    );
  }
}
