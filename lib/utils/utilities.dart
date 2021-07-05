import 'dart:io';
import 'package:image_picker/image_picker.dart';

class Utils {
  static String getUsername(String email) {
    return "${email.split('@')[0]}";
  }

  static String getInitials(String name) {
    List<String> nameSplit = name.split(" ");
    String firstNameInitial = nameSplit[0][0];
    String lastNameInitial = nameSplit[1][0];
    return firstNameInitial + lastNameInitial;
  }

  //picks the image and compresses it before sending
  static Future<File> pickImage(ImageSource source) async {
    PickedFile file = await ImagePicker().getImage(
        source: source, maxWidth: 500, maxHeight: 500, imageQuality: 85);
    File selectedImage = File(file.path);
    return selectedImage;
  }

  //compresses the image by decoding to bytes, changing dimensions and quality, encoding it back and returning the image with a file path containing a random filename for each image
  // static Future<File> compressImage(File imageToCompress) async {
  //   final tempDir = await getTemporaryDirectory();
  //   final path = tempDir.path;
  //   int rand = Random().nextInt(10000);

  //   Im.Image image = Im.decodeImage(imageToCompress.readAsBytesSync());
  //   Im.copyResize(image, width: 500, height: 500);

  //   return new File('$path/img_$rand.jpg')
  //     ..writeAsBytesSync(Im.encodeJpg(image, quality: 85));
  // }
}
