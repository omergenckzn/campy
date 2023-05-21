import 'package:flutter/material.dart';
import 'package:campy/components/components.dart';
import 'package:campy/components/contstants.dart';
import 'package:google_fonts/google_fonts.dart';

class AddPlaceToilet extends StatelessWidget {
  const AddPlaceToilet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Components components = Components();
    Constants constants = Constants();
    double sizeModifier = MediaQuery.of(context).size.width;
    var route = ModalRoute.of(context);
    if (route == null) return CircularProgressIndicator();
    Map data = route.settings.arguments as Map;
    String placeName = data['placeName'];
    List placeType = data['placeTypeList'];
    List<dynamic> placePricing = data['placePricing'];
    bool placeWater = data['placeWater'];
    bool placeFood = data['placeFood'];
    bool placeToilet = false;


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
                    components.UniqueTextStyle('Are there any'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    components.UniqueTextStyle('public '),
                    components.yellowUnderlinedText('toilets?', 40),
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
                        placeToilet = false;
                        Navigator.pushNamed(context, '/addPlaceImage', arguments: {
                          'placeTypeList': placeType,
                          'placeName' : placeName,
                          'placePricing': placePricing,
                          'placeWater' : placeWater,
                          'placeFood' : placeFood,
                          'placeToilet' : placeToilet
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
                        placeToilet =  true;
                        Navigator.pushNamed(context, '/addPlaceImage', arguments: {
                          'placeTypeList': placeType,
                          'placeName' : placeName,
                          'placePricing': placePricing,
                          'placeWater' : placeWater,
                          'placeFood' : placeFood,
                          'placeToilet' : placeToilet
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
