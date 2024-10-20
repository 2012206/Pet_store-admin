import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class FoodController extends GetxController{

  File? image;
  final ImagePicker picker = ImagePicker();
  Future<void> pickImage() async{
    final XFile? pickedImage =
    await picker.pickImage(
        imageQuality: 10,
        source: ImageSource.gallery);
    if (pickedImage != null) {
      image = File(pickedImage.path);
      update();
      refresh();

    }
  }

  // Function to upload image to Firebase Storage
  Future<String> uploadImage(File imageFile, String folderName) async {
    try{
      final imgRef = FirebaseStorage.instance
          .ref()
          .child("$folderName/${imageFile.path.split("/").last}.png");

      Uint8List data = await imageFile.readAsBytes();
      final uploadTask = imgRef.putData(data);

      String url = "";

      // Wait for the upload task to complete
      await uploadTask.whenComplete(() async {
        final urlDownload = await imgRef.getDownloadURL();
        debugPrint('Download Link: $urlDownload');

        if (urlDownload.isNotEmpty) {
          url = urlDownload;
        }
      });

      return url;
    }catch(e){
      throw Exception("error in uploaidng image $e");
    }
  }


}