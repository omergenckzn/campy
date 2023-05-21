// ignore_for_file: file_names
import 'package:campy/components/components.dart';
import 'package:campy/components/contstants.dart';
import 'package:campy/services/AuthService.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CampyRegister extends StatelessWidget {
  CampyRegister({Key? key}) : super(key: key);
  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {


    double sizeModifier = MediaQuery.of(context).size.width;
    Components components = Components();
    Constants constants = Constants();
    TextStyle defaultStyle = GoogleFonts.quicksand(
        fontWeight: FontWeight.w500, fontSize: sizeModifier * 0.036);
    TextStyle linkStyle = GoogleFonts.quicksand(
        fontWeight: FontWeight.w500,
        fontSize: sizeModifier * 0.036,
        color: constants.greenColor);

    return Stack(
      children: [
        campFireImage(),
        Padding(
          padding: components.paddingEdgeInsectsHorizontal(context, 0.01),
          child: Padding(
            padding: components.paddingEdgeInsectsHorizontal(context, 0.07),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Spacer(
                    flex: 55,
                  ),
                  Expanded(
                    flex: 18,
                    child: campyTextWidget(sizeModifier, constants),
                  ),
                  Expanded(
                    child: textWidget(sizeModifier),
                    flex: 10,
                  ),
                  Spacer(
                    flex: 12,
                  ),
                  Expanded(
                    flex: 50,
                    child: buttonColumnList(context, sizeModifier, constants),
                  ),
                  Expanded(
                    child: Padding(
                      padding: components.paddingEdgeInsectsHorizontal(
                          context, sizeModifier * 0.00008),
                      child: termsAndConditionsText(defaultStyle, linkStyle),
                    ),
                    flex: 18,
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  RichText termsAndConditionsText(TextStyle defaultStyle, TextStyle linkStyle) {
    return RichText(
      text: TextSpan(
        style: defaultStyle,
        children: <TextSpan>[
          TextSpan(text: '  By signing up on Campy, you agree to our '),
          TextSpan(
              text: 'Terms and Conditions, Privacy Policies',
              style: linkStyle,
              recognizer: TapGestureRecognizer()..onTap = () {}),
          TextSpan(text: ' and '),
          TextSpan(
              text: 'Community Guidelines (EULA)',
              style: linkStyle,
              recognizer: TapGestureRecognizer()..onTap = () {}),
        ],
      ),
    );
  }

  Column buttonColumnList(
      BuildContext context, double sizeModifier, Constants constants) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        registerButtonWidget(context, sizeModifier, constants),
        registerButtonWidgetTransparentLogin(
            context, sizeModifier, constants, 'Login'),
        registerButtonWidgetTransparentGuest(sizeModifier, constants, 'Guest'),
      ],
    );
  }

  ElevatedButton registerButtonWidgetTransparentGuest(
      double sizeModifier, Constants constants, data) {
    return ElevatedButton(
      child: inButtonText(sizeModifier, constants.greenColor, data),
      onPressed: () {
        authService.userInstance.signOut().then((value) => print('SignOut'));
      },
      style: ElevatedButton.styleFrom(
        minimumSize: Size(50, 50),
        shape: RoundedRectangleBorder(
            side: BorderSide(
              color: constants.greenColor,
              width: sizeModifier * 0.006,
            ),
            borderRadius: BorderRadius.circular(10)),
        primary: Colors.transparent,
      ),
    );
  }

  ElevatedButton registerButtonWidgetTransparentLogin(
      BuildContext context, double sizeModifier, Constants constants, data) {
    return ElevatedButton(
      child: inButtonText(sizeModifier, constants.greenColor, data),
      onPressed: () {
        Navigator.pushNamed(context, '/loginEmail');
      },
      style: ElevatedButton.styleFrom(
        minimumSize: Size(50, 50),
        shape: RoundedRectangleBorder(
            side: BorderSide(
              color: constants.greenColor,
              width: sizeModifier * 0.006,
            ),
            borderRadius: BorderRadius.circular(10)),
        primary: Colors.transparent,
      ),
    );
  }

  ElevatedButton registerButtonWidget(
      BuildContext context, double sizeModifier, Constants constants) {
    return ElevatedButton(
      child: inButtonText(sizeModifier, Colors.black, 'Sign Up'),
      onPressed: () {
        Navigator.pushNamed(context, '/signIn');
      },
      style: ElevatedButton.styleFrom(
          minimumSize: Size(50, 50),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          primary: constants.greenColor),
    );
  }

  Text inButtonText(double sizeModifier, Color color, data) => Text(
        data,
        style: GoogleFonts.quicksand(
            fontWeight: FontWeight.w700,
            fontSize: sizeModifier * 0.05,
            color: color),
      );

  Row textWidget(double sizeModifier) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Find the best of camping.',
          style: TextStyle(
              color: Color.fromRGBO(238, 238, 238, 1),
              fontSize: sizeModifier * 0.065),
        ),
      ],
    );
  }

  Opacity campFireImage() {
    return Opacity(
      opacity: 0.25,
      child: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/firepic.png"),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Center campyTextWidget(double sizeModifier, Constants constants) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          campyText(sizeModifier, constants, 'Cam', constants.greenColor),
          campyText(sizeModifier, constants, 'py', constants.blueColor)
        ],
      ),
    );
  }

  Text campyText(
      double sizeModifier, Constants constants, String data, Color color) {
    return Text(
      data,
      style: GoogleFonts.quicksand(
          fontWeight: FontWeight.w700,
          fontSize: sizeModifier * 0.14,
          color: color),
    );
  }
}
