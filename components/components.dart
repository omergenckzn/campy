// ignore_for_file: non_constant_identifier_names

import 'package:campy/components/contstants.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

class Components {
  Constants constants = Constants();
  final fontStyle700 =
      GoogleFonts.quicksand(fontWeight: FontWeight.w700, fontSize: 20);
  final fontStyle400 = GoogleFonts.quicksand(
    fontWeight: FontWeight.w400, fontSize: 22
  );
  EdgeInsets paddingEdgeInsectsHorizontal(BuildContext context, double ratio) =>
      EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * ratio);
  EdgeInsets paddingEdgeInsectsVertical(BuildContext context, double ratio) =>
      EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.width * ratio);
  EdgeInsets presetPaddingEdgeInsectsHorizontal(BuildContext context) =>
      EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.07);
  EdgeInsets paddingEdgeInsectsAll(BuildContext context) =>
      EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.03);
  EdgeInsets paddingSymmetric(BuildContext context) =>
      EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.07);


  AppBar AppBar_SpecialText(BuildContext context, Components components,
      Constants constants, String title) {
    return AppBar(
      centerTitle: true,
      title: Text(
        title,
        style: components.fontStyle700,
      ),
      backgroundColor: constants.greyThemeColor,
    );
  }

  AppBar AppBar_SpecialText_WithPopButton(BuildContext context,
      Components components, Constants constants, String title) {
    return AppBar(
      centerTitle: true,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(CupertinoIcons.chevron_back),
      ),
      title: Text(
        title,
        style: components.fontStyle700,
      ),
      backgroundColor: constants.greyThemeColor,
    );
  }

  Row ImageUsername(String route) {
    return Row(
      children: [
        Image.asset(route),
      ],
    );
  }

  Icon ArrowIcon() => Icon(
        Icons.arrow_right_alt_sharp,
        size: 35,
      );

  Stack yellowUnderlinedText(String title, double width) {
    return Stack(
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
                  horizontal:
                      BorderSide(width: 6.0, color: constants.limeGreen),
                  vertical: BorderSide(width: width, color: constants.limeGreen),
                ),
              ),
            ),
          ],
        ),
        Text(
          title,
          style: GoogleFonts.quicksand(
              color: constants.darkGreyColor,
              fontWeight: FontWeight.w700,
              fontSize: 32),
        )
      ],
    );
  }

  Text UniqueTextStyle(content) {
    return Text(
      content,
      style: GoogleFonts.quicksand(
          color: constants.darkGreyColor,
          fontWeight: FontWeight.w700,
          fontSize: 32),
    );
  }
  Text UniqueTextStyleWithSizeModifier(String content,double size) {
    return Text(
      content,
      style: GoogleFonts.quicksand(
          color: constants.darkGreyColor,
          fontWeight: FontWeight.w700,
          fontSize: size),
    );
  }

  Text UniqueTextStyleWithSizeModifierW500(String content,double size) {
    return Text(
      content,
      style: GoogleFonts.quicksand(
          color: constants.darkGreyColor,
          fontWeight: FontWeight.w500,
          fontSize: size),
    );
  }


  Stack smallYellowUnderLinedText(String title, double width) {
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              height: 11,
            ),
            Container(
              decoration: BoxDecoration(
                color: constants.limeGreen,
                border: Border.symmetric(
                  horizontal:
                  BorderSide(width: 3, color: constants.limeGreen),
                  vertical: BorderSide(width: width, color: constants.limeGreen),
                ),
              ),
            ),
          ],
        ),
        Text(
          title,
          style: GoogleFonts.quicksand(
              color: constants.darkGreyColor,
              fontWeight: FontWeight.w700,
              fontSize: 16),
        )
      ],
    );
  }



}
