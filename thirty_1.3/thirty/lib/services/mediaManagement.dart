import 'package:flutter/material.dart';
import 'package:picker/picker.dart';
import 'package:path/path.dart' as path;
import 'dart:io';

import 'package:thirty/services/cloudFirestore.dart';
import 'package:thirty/services/routeNavigation.dart';

//Need to add camera support
//Need to add when you click on an image
//Need to add gallery support
//Need to add when you click on a video

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
          maxHeight: 480,
          maxWidth: 640,
          imageQuality: 100);
      final String fileName = path.basename(pickedFile.path);
      File imageFile = File(pickedFile.path);
      await cloudFirestore.createImageData(fileName, imageFile).then((value) {
        state.setState(() {});
      });
    } catch (e) {
      print(e);
    }
  }
}
