import 'package:campy/components/components.dart';
import 'package:campy/components/contstants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddPlaceType extends StatefulWidget {
  const AddPlaceType({Key? key}) : super(key: key);

  @override
  State<AddPlaceType> createState() => _AddPlaceTypeState();
}

class _AddPlaceTypeState extends State<AddPlaceType> {
  Components components = Components();
  Constants constants = Constants();
  List<bool> placeTypesList = [false, false, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    double sizeModifier = MediaQuery.of(context).size.width;
    var route = ModalRoute.of(context);
    if (route == null) return CircularProgressIndicator();
    Map data = route.settings.arguments as Map;
    String placeName = data['placeName'];

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
                      components.UniqueTextStyle('Choose the '),
                      components.yellowUnderlinedText('type', 36),
                    ],
                  ),
                  components.UniqueTextStyle('of this place?'),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'You can choose more than one options.',
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 25,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              placeTypesList[0] = !placeTypesList[0];
                            });
                          },
                          child: Text(
                            'Facility',
                            style: GoogleFonts.quicksand(
                                color: constants.darkGreyColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 20),
                          ),
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            minimumSize: Size(50, 60),
                            shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: constants.darkGreyColor,
                                  width: sizeModifier * 0.006,
                                ),
                                borderRadius: BorderRadius.circular(8)),
                            primary: placeTypesList[0]
                                ? constants.limeGreen
                                : Colors.transparent,
                          ),
                        ),
                      ),
                      Spacer(
                        flex: 2,
                      ),
                      Expanded(
                        flex: 25,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              placeTypesList[1] = !placeTypesList[1];
                            });
                          },
                          child: Text(
                            'Sea-side',
                            style: GoogleFonts.quicksand(
                                color: constants.darkGreyColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 18),
                          ),
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            minimumSize: Size(50, 60),
                            shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: constants.darkGreyColor,
                                  width: sizeModifier * 0.006,
                                ),
                                borderRadius: BorderRadius.circular(8)),
                            primary: placeTypesList[1]
                                ? constants.limeGreen
                                : Colors.transparent,
                          ),
                        ),
                      ),
                      Spacer(
                        flex: 2,
                      ),
                      Expanded(
                        flex: 25,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              placeTypesList[2] = !placeTypesList[2];
                            });
                          },
                          child: Text(
                            'Forest',
                            style: GoogleFonts.quicksand(
                                color: constants.darkGreyColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 20),
                          ),
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            minimumSize: Size(50, 60),
                            shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: constants.darkGreyColor,
                                  width: sizeModifier * 0.006,
                                ),
                                borderRadius: BorderRadius.circular(8)),
                            primary: placeTypesList[2]
                                ? constants.limeGreen
                                : Colors.transparent,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 25,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              placeTypesList[3] = !placeTypesList[3];
                            });
                          },
                          child: Text(
                            'Bay',
                            style: GoogleFonts.quicksand(
                                color: constants.darkGreyColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 20),
                          ),
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            minimumSize: Size(50, 60),
                            shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: constants.darkGreyColor,
                                  width: sizeModifier * 0.006,
                                ),
                                borderRadius: BorderRadius.circular(8)),
                            primary: placeTypesList[3]
                                ? constants.limeGreen
                                : Colors.transparent,
                          ),
                        ),
                      ),
                      Spacer(
                        flex: 2,
                      ),
                      Expanded(
                        flex: 25,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              placeTypesList[4] = !placeTypesList[4];
                            });
                          },
                          child: Text(
                            'Hill',
                            style: GoogleFonts.quicksand(
                                color: constants.darkGreyColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 20),
                          ),
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            minimumSize: Size(50, 60),
                            shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: constants.darkGreyColor,
                                  width: sizeModifier * 0.006,
                                ),
                                borderRadius: BorderRadius.circular(8)),
                            primary: placeTypesList[4]
                                ? constants.limeGreen
                                : Colors.transparent,
                          ),
                        ),
                      ),
                      Spacer(
                        flex: 2,
                      ),
                      Expanded(
                        flex: 25,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              placeTypesList[5] = !placeTypesList[5];
                            });
                          },
                          child: Text(
                            'Nat. Park',
                            style: GoogleFonts.quicksand(
                                color: constants.darkGreyColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 16),
                          ),
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            minimumSize: Size(50, 60),
                            shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: constants.darkGreyColor,
                                  width: sizeModifier * 0.006,
                                ),
                                borderRadius: BorderRadius.circular(8)),
                            primary: placeTypesList[5]
                                ? constants.limeGreen
                                : Colors.transparent,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/addPlacePricing',
                              arguments: {
                                'placeTypeList': placeTypesList,
                                'placeName' : placeName
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
        ));
  }
}
