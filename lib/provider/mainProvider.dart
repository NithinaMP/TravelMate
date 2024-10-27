import 'dart:collection';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class MainProvider extends ChangeNotifier {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  firebase_storage.Reference ref = FirebaseStorage.instance.ref("IMAGEURL");

  TextEditingController destNameController=TextEditingController();
  TextEditingController destPlaceController=TextEditingController();
  TextEditingController destDistrictController=TextEditingController();
  TextEditingController destDiscriptionController=TextEditingController();
  TextEditingController entryFeeController=TextEditingController();

  File? addDestFileImage;
  String destFileURL="";
  Future getDestImggallery() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      cropImage(pickedImage.path, "");
    } else {
      print('No image selected.');
    }
  }

  Future getDestImgcamera() async {
    final imgPicker = ImagePicker();
    final pickedImage = await imgPicker.pickImage(source: ImageSource.camera);

    if (pickedImage != null) {
      cropImage(pickedImage.path, "");
    } else {
      print('No image selected.');
    }
  }

  Future<void> cropImage(String path, String from) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: path,
      aspectRatioPresets: Platform.isAndroid ? [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9,
      ]
          : [
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio5x3,
        CropAspectRatioPreset.ratio5x4,
        CropAspectRatioPreset.ratio7x5,
        CropAspectRatioPreset.ratio16x9,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.white,
            toolbarWidgetColor: Colors.black,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        )
      ],
    );
    if (croppedFile != null) {
      addDestFileImage = File(croppedFile.path);
      // print(Registerfileimg.toString() + "fofiifi");
      notifyListeners();
    }
  }

  Future<void> addDestination() async {

    String id=DateTime.now().microsecondsSinceEpoch.toString();
    HashMap<String,Object> addDest=HashMap();
    addDest["DEST_NAME"]=destNameController.text;
    addDest["DEST_PLACE"]=destPlaceController.text;
    addDest["DEST_DISTRICT"]=destDistrictController.text;
    addDest["DEST_DISCRIPTION"]=destDiscriptionController.text;
    addDest["DEST_ENTRYFEE"]=entryFeeController.text;
    if (addDestFileImage != null) {
      String photoId = DateTime.now().millisecondsSinceEpoch.toString();
      ref = FirebaseStorage.instance.ref().child(photoId);
      await ref.putFile(addDestFileImage!).whenComplete(() async {
        await ref.getDownloadURL().then((value) {
          addDest["DEST_IMAGE"] = value;

          notifyListeners();
        });
        notifyListeners();
      });
    }

    db.collection("DESTINATION").doc(id).set(addDest);
    notifyListeners();
  }



  //
  // TextEditingController eventNameContoller = TextEditingController();
  // TextEditingController eventPlaceController = TextEditingController();
  // TextEditingController eventTicketPriceContoller = TextEditingController();
  // TextEditingController eventDurationContoller = TextEditingController();
  //
  // File? addEventImg;
  // String productFileUrl = "";
  //
  // @override
  // void dispose() {
  //   // Dispose controllers when no longer needed to avoid memory leaks
  //   eventNameContoller.dispose();
  //   eventPlaceController.dispose();
  //   eventTicketPriceContoller.dispose();
  //   eventDurationContoller.dispose();
  //   super.dispose();
  // }
  //
  // Future<void> getImggallery() async {
  //   final imagePicker = ImagePicker();
  //   final pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);
  //   if (pickedImage != null) {
  //     cropImage(pickedImage.path);
  //   } else {
  //     print('No image selected.');
  //   }
  // }
  //
  // Future<void> getImgcamera() async {
  //   final imgPicker = ImagePicker();
  //   final pickedImage = await imgPicker.pickImage(source: ImageSource.camera);
  //   if (pickedImage != null) {
  //     cropImage(pickedImage.path);
  //   } else {
  //     print('No image selected.');
  //   }
  // }
  //
  // Future<void> cropImage(String path) async {
  //   final croppedFile = await ImageCropper().cropImage(
  //     sourcePath: path,
  //     aspectRatioPresets: Platform.isAndroid
  //         ? [
  //       CropAspectRatioPreset.square,
  //       CropAspectRatioPreset.ratio3x2,
  //       CropAspectRatioPreset.original,
  //       CropAspectRatioPreset.ratio4x3,
  //       CropAspectRatioPreset.ratio16x9,
  //     ]
  //         : [
  //       CropAspectRatioPreset.original,
  //       CropAspectRatioPreset.square,
  //       CropAspectRatioPreset.ratio3x2,
  //       CropAspectRatioPreset.ratio4x3,
  //       CropAspectRatioPreset.ratio5x3,
  //       CropAspectRatioPreset.ratio5x4,
  //       CropAspectRatioPreset.ratio7x5,
  //       CropAspectRatioPreset.ratio16x9,
  //       CropAspectRatioPreset.ratio16x9,
  //     ],
  //     uiSettings: [
  //       AndroidUiSettings(
  //         toolbarTitle: 'Cropper',
  //         toolbarColor: Colors.white,
  //         toolbarWidgetColor: Colors.black,
  //         initAspectRatio: CropAspectRatioPreset.original,
  //         lockAspectRatio: false,
  //       ),
  //       IOSUiSettings(
  //         title: 'Cropper',
  //       ),
  //     ],
  //   );
  //   if (croppedFile != null) {
  //     addEventImg = File(croppedFile.path);
  //     notifyListeners();
  //   }
  // }
  //
  // Future<void> addEvent() async {
  //   if (eventNameContoller.text.isEmpty ||
  //       eventPlaceController.text.isEmpty ||
  //       eventTicketPriceContoller.text.isEmpty ||
  //       eventDurationContoller.text.isEmpty) {
  //     print("Please fill all the fields.");
  //     return;
  //   }
  //
  //   print("Event Adding Process Started");
  //
  //   // Generate unique ID for the event
  //   String id = DateTime.now().microsecondsSinceEpoch.toString();
  //
  //   // Create a HashMap for storing event details
  //   HashMap<String, Object> addevent = HashMap();
  //   addevent["EVENT_NAME"] = eventNameContoller.text;
  //   addevent["EVENT_PLACE"] = eventPlaceController.text;
  //   addevent["TICKET_PRICE"] = eventTicketPriceContoller.text;
  //   addevent["DURATION"] = eventDurationContoller.text;
  //
  //   // Upload image if it exists
  //   if (addEventImg != null) {
  //     print("Image Upload Process Started");
  //     String photoId = DateTime.now().millisecondsSinceEpoch.toString();
  //     ref = FirebaseStorage.instance.ref().child(photoId);
  //
  //     await ref.putFile(addEventImg!).whenComplete(() async {
  //       await ref.getDownloadURL().then((value) {
  //         addevent["PHOTO"] = value;
  //         print("Image Uploaded Successfully, Download URL: $value");
  //         notifyListeners();
  //       });
  //     });
  //   } else {
  //     print("No image selected for the event.");
  //   }
  //
  //   // Add event details to Firestore
  //   await db.collection("ADD_EVENT").doc(id).set(addevent).then((_) {
  //     print("Event Added Successfully to Firestore with ID: $id");
  //   }).catchError((error) {
  //     print("Failed to add event: $error");
  //   });
  //
  //   notifyListeners();
  // }
}
