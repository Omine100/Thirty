import 'package:flutter/material.dart';
import 'package:picker/picker.dart';
import 'package:path/path.dart' as path;
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';
import 'dart:io';

import 'package:thirty/services/cloudFirestore.dart';

class MediaManagement {
  //CLASS INTIALIZATION
  CloudFirestore cloudFirestore = new CloudFirestore();
  Picker picker = new Picker();

  //MECHANICS: Gets image from camera or from gallery
  //DESCRIPTION: We can have a button on the home.dart page come up with a dialog
  //          to choice between 'gallery' or 'camera' and then send it over here.
  //          Once the image has been chosen, we call a function to upload it to
  //          the FirebaseStorage
  //BOOLEAN INPUT: 'isCamera' if true then load camera, else load gallery
  //STATE INPUT: 'state' for setState()
  //OUTPUT: Calls camera or gallery application and then calls cloudFirestore
  //    function to save in the appropriate area
  Future getImage(BuildContext context, bool isCamera, State state) async {
    try {
      final pickedFile = await Picker.pickImage(
          source: isCamera ? ImageSource.camera : ImageSource.gallery,
          imageQuality: 100);
      final String fileName = path.basename(pickedFile.path);
      File imageFile = File(pickedFile.path);
      await cloudFirestore.createImageData(fileName, imageFile);
      state.setState(() {});
    } catch (e) {
      print(e);
    }
  }

  //MECHANICS: Save and share image
  //DESCRIPTION: Takes imageURL, saves it, and then allows for the user to share
  //          it with some preset information
  //OUTPUT: Image share
  Future<Null> saveAndShare(String imageURL) async {
    if (Platform.isAndroid) {
      var url = imageURL;
      var response = await get(Uri.parse(imageURL));
      final documentDirectory = (await getExternalStorageDirectory()).path;
      File imageFile = new File('$documentDirectory/flutter.png');
      imageFile.writeAsBytesSync(response.bodyBytes);
      Share.shareFile(imageFile,
          subject: "Thought you might like!", text: "What do you think?");
    }
  }
}
