import 'package:image_picker/image_picker.dart';


class ImageUploader {

  ImagePicker picker = ImagePicker();
  late XFile imageFile;




   Future getImageFromGallery() async {
     XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);
     if(pickedImage == null) {
       return null;
     }else {
       return pickedImage.path;
     }


   }

   Future getImageFromCamera() async {
     XFile? pickedImage = await picker.pickImage(source: ImageSource.camera);
     if(pickedImage == null) {
       return null;
     }else {
       return pickedImage.path;
     }
   }

}