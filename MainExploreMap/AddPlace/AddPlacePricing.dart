import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../components/components.dart';
import '../../components/contstants.dart';

class AddPlacePricing extends StatefulWidget {
  const AddPlacePricing({Key? key}) : super(key: key);

  @override
  State<AddPlacePricing> createState() => _AddPlacePricingState();
}

class _AddPlacePricingState extends State<AddPlacePricing> {

  /// The APP NEEDS THE CLEAR CHOICE SELECTION BUTTON
  Components components = Components();
  Constants constants = Constants();
  List placePricing = [false,false,false];




  @override
  Widget build(BuildContext context) {
    double sizeModifier = MediaQuery.of(context).size.width;
    var route = ModalRoute.of(context);
    if (route == null) return CircularProgressIndicator();
    Map data = route.settings.arguments as Map;
    String placeName = data['placeName'];
    List placeType = data['placeTypeList'];


    return Scaffold(
      appBar: components.AppBar_SpecialText_WithPopButton(context, components, constants, 'Add Place'),
      body: Padding(
        padding: components.paddingSymmetric(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    components.UniqueTextStyle('Are there any'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    components.yellowUnderlinedText('pricing?', 55),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'You can choose one or not.',
                  style: GoogleFonts.quicksand(
                      fontSize: 16, fontWeight: FontWeight.w600),
                )
              ],
            ),
            SizedBox(),
            Stack(
              children: [
                Positioned(
                  left: 10,
                  bottom: 20,
                  child: Container(
                    color: constants.darkGreyColor,
                    width: 320,
                    height: 7,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          placePricing = [true,false,false];
                        });
                        print(placePricing);
                      },
                      child: Text(
                        '\$',
                        style: GoogleFonts.quicksand(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),

                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        onSurface: Colors.transparent,
                        primary: placePricing[0]
                            ? constants.limeGreen
                            : Colors.white,
                        onPrimary: constants.darkGreyColor,
                        shape: CircleBorder(side: BorderSide(
                          color: constants.darkGreyColor,
                          width: 3.5
                        )),
                        padding: EdgeInsets.all(15),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          placePricing = [false,true,false];
                        });
                        print(placePricing);
                      },
                      child: Text(
                        '\$\$',
                        style: GoogleFonts.quicksand(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),

                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        primary: placePricing[1]
                            ? constants.limeGreen
                            : Colors.white,
                        onPrimary: constants.darkGreyColor,
                        shape: CircleBorder(side: BorderSide(
                            color: constants.darkGreyColor,
                            width: 3.5
                        )),
                        padding: EdgeInsets.all(15),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          placePricing = [false,false,true];
                          print(placePricing);
                        });
                      },
                      child: Text(
                        '\$\$\$',
                        style: GoogleFonts.quicksand(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),

                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        primary: placePricing[2]
                            ? constants.limeGreen
                            : Colors.white,
                        onPrimary: constants.darkGreyColor,
                        shape: CircleBorder(side: BorderSide(
                            color: constants.darkGreyColor,
                            width: 3.5
                        )),
                        padding: EdgeInsets.all(15),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/addPlaceWater',
                            arguments: {
                              'placeTypeList': placeType,
                              'placeName' : placeName,
                              'placePricing': placePricing
                            });

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
          ],
        ),
      ),
    );
  }
}
