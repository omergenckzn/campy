import 'package:campy/services/ImageUploader.dart';
import 'package:flutter/material.dart';
import 'package:campy/components/components.dart';
import 'package:campy/components/contstants.dart';

class AddPlaceImage extends StatefulWidget {
  const AddPlaceImage({Key? key}) : super(key: key);

  @override
  State<AddPlaceImage> createState() => _AddPlaceImageState();
}

class _AddPlaceImageState extends State<AddPlaceImage> {
  Components components = Components();
  Constants constants = Constants();
  ImageUploader imageUploader = ImageUploader();

  @override
  Widget build(BuildContext context) {
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
                    components.UniqueTextStyle('Show us the '),
                    components.yellowUnderlinedText('pics', 28),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    components.UniqueTextStyle('of this tremendous'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    components.UniqueTextStyle('place...'),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),

              ],
            ),
            SizedBox(),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: constants.darkGreyColor,
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(15),
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Color.fromRGBO(196, 196, 196, 1),
                        size: 35,
                      ),
                      onPressed: () async {
                        String? imagePath =  await imageUploader.getImageFromGallery();
                        Navigator.pushNamed(context, '/addPlaceMap', arguments: {
                          'placeTypeList': placeType,
                          'placeName' : placeName,
                          'placePricing': placePricing,
                          'placeWater' : placeWater,
                          'placeFood' : placeFood,
                          'placeToilet' : placeToilet,
                          'placeImagePath' : imagePath
                        });


                      },
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: constants.darkGreyColor,
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(15),
                      ),
                      child: const Icon(
                        Icons.camera_alt,
                        color: Color.fromRGBO(196, 251, 109, 1),
                        size: 35,
                      ),
                      onPressed: () async {
                        String imagePath = await imageUploader.getImageFromCamera();
                        Navigator.pushNamed(context, '/addPlaceMap', arguments: {
                          'placeTypeList': placeType,
                          'placeName' : placeName,
                          'placePricing': placePricing,
                          'placeWater' : placeWater,
                          'placeFood' : placeFood,
                          'placeToilet' : placeToilet,
                          'placeImagePath' : imagePath
                        });


                      },
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
