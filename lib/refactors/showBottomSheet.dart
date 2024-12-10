import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../constants/constant_colors.dart';
import '../provider/mainProvider.dart';

//
// Future<void> getImage(String from, {required ImageSource source}) async {
//   final imagePicker = ImagePicker();
//   final pickedImage = await imagePicker.pickImage(source: source);
//
//   if (pickedImage != null) {
//     await cropImage(pickedImage.path, from);
//   } else {
//     print('No image selected.');
//   }
// }
//
// Future<void> cropImage(String path, String from) async {
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
//     ],
//     uiSettings: [
//       AndroidUiSettings(
//           toolbarTitle: 'Cropper',
//           toolbarColor: Colors.white,
//           toolbarWidgetColor: Colors.black,
//           initAspectRatio: CropAspectRatioPreset.original,
//           lockAspectRatio: false),
//       IOSUiSettings(
//         title: 'Cropper',
//       ),
//     ],
//   );
//
//   if (croppedFile != null) {
//     if (from == "AddEvent") {
//       selectedFile = File(croppedFile.path);
//       // Update your specific logic for AddEvent
//       fileURL = "EventFileUrl"; // Set event-specific file URL logic here
//     } else if (from == "AddDestination") {
//       selectedFile = File(croppedFile.path);
//       // Update your specific logic for AddDestination
//       fileURL = "DestinationFileUrl"; // Set destination-specific file URL logic here
//     }
//     // notifyListeners();
//   }
// }
//

// void showBottomSheet(BuildContext context, String from) {
//   MainProvider mainProvider = Provider.of<MainProvider>(context, listen: false);
//
//   // Function to handle camera and gallery actions
//   void handleImageSelection(String source) {
//     if (source == 'camera') {
//       // Call getImage for "AddEvent" or "AddDestination" depending on the from parameter
//       mainProvider.getImage(from, source: ImageSource.camera);
//     } else if (source == 'gallery') {
//       mainProvider.getImage(from, source: ImageSource.gallery);
//     }
//     Navigator.pop(context); // Close the bottom sheet after selection
//   }
//
//   // Show modal bottom sheet with camera and gallery options
//   showModalBottomSheet(
//     elevation: 10,
//     backgroundColor: Colors.white,
//     shape: const RoundedRectangleBorder(
//       borderRadius: BorderRadius.only(
//         topLeft: Radius.circular(10.0),
//         topRight: Radius.circular(10.0),
//       ),
//     ),
//     context: context,
//     builder: (BuildContext bc) {
//       return Wrap(
//         children: <Widget>[
//           ListTile(
//             leading: Icon(
//               Icons.camera_enhance_sharp,
//               color: cstOrange1,
//             ),
//             title: const Text('Camera'),
//             onTap: () => handleImageSelection('camera'),
//           ),
//           ListTile(
//             leading: Icon(
//               Icons.photo,
//               color: cstOrange1,
//             ),
//             title: const Text('Gallery'),
//             onTap: () => handleImageSelection('gallery'),
//           ),
//         ],
//       );
//     },
//   );
// }
