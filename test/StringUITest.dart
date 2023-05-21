import 'package:campy/components/components.dart';
import 'package:campy/components/contstants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StringUITest extends StatefulWidget {
  const StringUITest({Key? key}) : super(key: key);

  @override
  State<StringUITest> createState() => _StringUITestState();
}

class _StringUITestState extends State<StringUITest> {
  Components components = Components();
  Constants constants = Constants();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: components.presetPaddingEdgeInsectsHorizontal(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'You have to',
              style: GoogleFonts.quicksand(
                  color: constants.darkGreyColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 36),
            ),
            Row(
              children: [
                Text(
                  'create a ',
                  style: GoogleFonts.quicksand(
                      color: constants.darkGreyColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 32),
                ),
                Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: constants.limeGreen,
                            border: Border.symmetric(
                              horizontal: BorderSide(
                                  width: 6.0, color: constants.limeGreen),
                              vertical: BorderSide(
                                  width: 56.0, color: constants.limeGreen),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'profile',
                      style: GoogleFonts.quicksand(
                          color: constants.darkGreyColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 36),
                    )
                  ],
                )
              ],
            ),
            Text(
              'for yourself.',
              style: GoogleFonts.quicksand(
                  color: constants.darkGreyColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 36),
            )
          ],
        ),
      ),
    ));
  }
}
