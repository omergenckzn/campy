import 'package:geolocator/geolocator.dart';

/// Determine the current position of the device.
///
/// When the location services are not enabled or permissions
/// are denied the `Future` will return an error.

class GeolocatorService {

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }


}

// Future<String> post_firebase_async({String? path , required Product product}) async {
//   final Uri _url = path == null ? currentUrl: Uri.https(_baseUrl, '/$path');
//
//   print('Sending a POST request at $_url');
//
//   final response = await http.post(_url, body: jsonEncode(product.toJson()));
//   if(response.statusCode == 200){
//     final result = jsonDecode(response.body) as Map<String,dynamic>;
//     return result['name'];
//   }
//   else{
//     //throw HttpException(message: 'Failed with ${response.statusCode}');
//     return Future.error("This is the error", StackTrace.fromString("This is its trace"));
//   }
//
// }
// Here is how to call:
//
// final result = await _firebase.post_firebase_async(product: dummyProduct).
// catchError((err){
// print('huhu $err');
// });
