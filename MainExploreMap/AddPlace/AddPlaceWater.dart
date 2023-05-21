import 'package:campy/components/components.dart';
import 'package:campy/components/contstants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddPlaceWater extends StatefulWidget {
  const AddPlaceWater({Key? key}) : super(key: key);

  @override
  State<AddPlaceWater> createState() => _AddPlaceWaterState();
}

class _AddPlaceWaterState extends State<AddPlaceWater> {
  Components components = Components();
  Constants constants = Constants();

  @override
  Widget build(BuildContext context) {
    double sizeModifier = MediaQuery.of(context).size.width;
    var route = ModalRoute.of(context);
    if (route == null) return CircularProgressIndicator();
    Map data = route.settings.arguments as Map;
    String placeName = data['placeName'];
    List placeType = data['placeTypeList'];
    List<dynamic> placePricing = data['placePricing'];
    bool placeWater = false;


    return Scaffold(
      appBar: components.AppBar_SpecialText_WithPopButton(
          context, components, constants, 'Add Place'),
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
                    components.UniqueTextStyle('Are there any hot'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    components.yellowUnderlinedText('water?', 55),
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
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        placeWater = false;
                        Navigator.pushNamed(context, '/addPlaceFood', arguments: {
                          'placeTypeList': placeType,
                          'placeName' : placeName,
                          'placePricing': placePricing,
                          'placeWater' : placeWater,
                        });
                        
                      },
                      child: Text(
                        'No',
                        style: GoogleFonts.quicksand(
                            color: constants.darkGreyColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 16),
                      ),
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          minimumSize: Size(120, 60),
                          shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: constants.darkGreyColor,
                                width: sizeModifier * 0.006,
                              ),
                              borderRadius: BorderRadius.circular(8)),
                          shadowColor: Colors.transparent,
                          primary: Colors.transparent,
                          onSurface: constants.limeGreen,
                          onPrimary: constants.limeGreen),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        placeWater  = true;

                        Navigator.pushNamed(context, '/addPlaceFood', arguments: {
                          'placeTypeList': placeType,
                          'placeName' : placeName,
                          'placePricing': placePricing,
                          'placeWater' : true,
                        });
                        
                        
                      },
                      child: Text(
                        'Yes',
                        style: GoogleFonts.quicksand(
                            color: constants.darkGreyColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 16),
                      ),
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          minimumSize: Size(120, 60),
                          shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: constants.darkGreyColor,
                                width: sizeModifier * 0.006,
                              ),
                              borderRadius: BorderRadius.circular(8)),
                          shadowColor: Colors.transparent,
                          primary: Colors.transparent,
                          onSurface: constants.limeGreen,
                          onPrimary: constants.limeGreen),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
