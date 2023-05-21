import 'package:campy/components/components.dart';
import 'package:campy/components/contstants.dart';
import 'package:campy/register/CampyRegister.dart';
import 'package:campy/services/AuthService.dart';
import 'package:flutter/material.dart';

class ProfileDelete extends StatelessWidget {
   ProfileDelete({Key? key}) : super(key: key);

  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    Components components = Components();
    Constants constants = Constants();
    CampyRegister campyRegister = CampyRegister();
    double sizeModifier = MediaQuery.of(context).size.width;


    return Scaffold(
      appBar: AppBar(
        backgroundColor: constants.darkGreyColor,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text('Profile',
          style: components.fontStyle700,
        ),
      ),
      body: Padding(
        padding: components.presetPaddingEdgeInsectsHorizontal(context),
        child: Column(
          children: [
            Expanded(child: components.ImageUsername('assets/deleteAccount.png'),flex: 10,),
            Spacer(flex: 10 ,),
            Expanded(
              flex: 6,
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                noooButton(campyRegister, sizeModifier, constants, context),
                deleteButton(campyRegister, sizeModifier, constants, context),
              ],
            ),),
            Spacer(flex: 2,)
          ],
        ),
      ),
    );
  }

  ElevatedButton deleteButton(CampyRegister campyRegister, double sizeModifier, Constants constants, BuildContext context) {
    return ElevatedButton(
            child: campyRegister.inButtonText(sizeModifier, constants.darkGreyColor, 'Delete'),
            onPressed: () async {
              await authService.userInstance.currentUser!.delete();
              Navigator.pushNamedAndRemoveUntil(context, '/mainNavigationScreen', (route) => false);

            },
            style: ElevatedButton.styleFrom(
              minimumSize: Size(50, 50),
              shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: constants.darkGreyColor,
                    width: sizeModifier * 0.006,
                  ),
                  borderRadius: BorderRadius.circular(10)),
              primary: Colors.white,
            ),
          );
  }

  ElevatedButton noooButton(CampyRegister campyRegister, double sizeModifier, Constants constants, BuildContext context) {
    return ElevatedButton(
            child: campyRegister.inButtonText(sizeModifier, constants.darkGreyColor, 'Noooo!'),
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
                minimumSize: Size(50, 50),
                shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),side: BorderSide(
                  color: constants.darkGreyColor,
                  width: sizeModifier * 0.006
                )),
                primary: constants.greenColor),
          );
  }
}
