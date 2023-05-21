import 'package:campy/services/FireStorageService.dart';
import 'package:campy/services/FirestoreService.dart';

class PlaceSortAndUpload {
  var placeName;
  var placeType ;
  var placePricing;
  var placeWater;
  var placeFood;
  var placeToilet;
  var placeImagePath;
  List<String> placeTypeFinal = [];
  String placePricingFinal = '';
  List<String> tags = [];
  FireStorageService storageService = FireStorageService();
  FirestoreService firestoreService = FirestoreService();
  
  
  createMap(placeName,placeType,placeWater,placeFood, placeToilet, placeImagePath) {
    Map finalMap = { 'placeName': placeName,

    };
  }

  placeTypeSort(placeType) {

    if(placeType[0] = true) {
      placeTypeFinal.add('Facility');
    }
    if(placeType[1] = true) {
      placeTypeFinal.add('Sea-Side');
    }
    if(placeType[2] = true) {
      placeTypeFinal.add('Forest');
    }
    if(placeType[3] = true) {
      placeTypeFinal.add('Bay');
    }
    if(placeType[4] = true) {
      placeTypeFinal.add('Hill');
    }
    if(placeType[5] = true) {
      placeTypeFinal.add('Nat.Park');
    }
  }
  
  String placePricingSort() {
    if(placePricing[0] = true) {
      return placePricingFinal = '\$';
    }
    if(placePricing[1] = true) {
     return placePricingFinal = '\$\$';
    }
    if(placePricing[2] = true) {
      return placePricingFinal = '\$\$\$';
    }else {
     return ''; 
    }
  }
  
  void placeTagsList() {
    if(placeWater) {
      tags.add('hot water');
    }
    if(placeFood) {
      tags.add('food');
    }
    if(placeToilet) {
      tags.add('toilet');
    }
  }

  placeImageUpload() async {
    String downloadUrl = await storageService.uploadFile(placeImagePath, placeName);
    await firestoreService.placeImageUrl(downloadUrl, placeName);

  }




}