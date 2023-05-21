
import 'package:campy/components/components.dart';
import 'package:campy/components/contstants.dart';
import 'package:campy/services/AuthService.dart';
import 'package:campy/services/FirestoreService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class LoginPassword extends StatefulWidget {
  const LoginPassword({Key? key}) : super(key: key);

  @override
  _SignInViewState createState() => _SignInViewState();
}

class _SignInViewState extends State<LoginPassword> {
  final formKey = GlobalKey<FormState>();
  AuthService authService = AuthService();
  FirestoreService firestoreService = FirestoreService();
  late String password;


  @override
  Widget build(BuildContext context) {
    //double sizeModifier = MediaQuery.of(context).size.width;
    Components components = Components();
    Constants constants = Constants();
    var route = ModalRoute.of(context);
    if (route == null) return CircularProgressIndicator();
    Map data = route.settings.arguments as Map;
    String emailAddress = data['emailAddress'];

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
                components.ImageUsername('assets/underlinedTextPassword.png'),
                CupertinoTextFormFieldRow(
                  obscureText: true,
                  validator: (value) {
                    if (value != null)  {
                    }
                    if (value == null || value.isEmpty || value.length < 7) {
                      return 'The password must be at least 8 characters';
                    }
                    else{
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.none,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey, width: 2.5)),
                  placeholder: 'Pick a Password',
                  style: components.fontStyle400,
                  onChanged: (value) {
                    password = value;
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                       _login(emailAddress, password);
                       dynamic userID = authService.userInstance.currentUser!.uid;
                           //Navigator.pushNamedAndRemoveUntil(context, '/mainNavigationScreen', (route) => false);
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
                )
              ],
            ),
          ),
        ));
  }

  _login(String email, String password) async {
    final status = await authService.logInUser(email, password,context);
    if (status == AuthResultStatus.successful) {
      // Navigate to success page
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Login Successful')));
      Navigator.pushNamedAndRemoveUntil(context, '/mainNavigationScreen', (route) => false);
    } else {
      final errorMsg = AuthExceptionHandler.generateExceptionMessage(
          status);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$errorMsg')));

    }
  }


}
