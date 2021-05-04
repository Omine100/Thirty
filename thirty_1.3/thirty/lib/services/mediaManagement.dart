import 'package:flutter/material.dart';
import 'package:picker/picker.dart';
import 'dart:io';

import 'package:thirty/services/cloudFirestore.dart';

//Need to add camera support
//Need to add when you click on an image
//Need to add gallery support
//Need to add when you click on a video

class MediaManagement {
  //CLASS INTIALIZATION
  CloudFirestore cloudFirestore = new CloudFirestore();
  Picker picker = new Picker();

  //Mechanics: Get image
  Future getImage(State state) async {
    final pickedFile = await Picker.pickImage(
        source: ImageSource.camera,
        maxHeight: 480,
        maxWidth: 640,
        imageQuality: 100);
    state.setState(() {
      File _image = File(pickedFile.path);
    });
  }

  //MECHANICS: Calls camera function
  //DESCRIPTION: Sends function to the UI in interfaceStandards.dart
  //OUTPUT: Calls camera application and then calls cloudFirestore function to save
  //    in the appropriate area
  Future callCamera() async {
    var image = await Picker.pickImage(
        source: ImageSource.camera,
        maxHeight: 480,
        maxWidth: 640,
        imageQuality: 75);
    return image;
  }
}
