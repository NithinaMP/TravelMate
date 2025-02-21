import 'dart:collection';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelmate/admin/adminHomescreen.dart';
import 'package:travelmate/constants/call_functions.dart';
import 'package:travelmate/constants/globalMethods.dart';
import 'package:travelmate/models/userModel.dart';
import 'package:travelmate/provider/mainProvider.dart';
import '../user/userBottomScreen.dart';

class LoginProvider extends ChangeNotifier{
  final FirebaseFirestore db = FirebaseFirestore.instance;
  firebase_storage.Reference ref = FirebaseStorage.instance.ref("IMAGEURL");


  // -----------------------ADD REGISTRATION--------------------------------------------------------------

  TextEditingController RegNameController=TextEditingController();
  TextEditingController RegPhoneController=TextEditingController();
  TextEditingController RegPassWordController=TextEditingController();
  TextEditingController RegConfirmPassWordController=TextEditingController();
  TextEditingController RegPlaceController=TextEditingController();
  File? addUsersImage;
  String UsersImageURL = "";
  ///for cirular progress
  bool isSaving = false;
  Future<void> addRegistraion(BuildContext context, String from, String oldid) async {
    try {
      isSaving = true;
      notifyListeners(); // Notify UI to show loading

      String id = oldid;
      HashMap<String, dynamic> addReg = HashMap();

      if (from == "NEW") {
        id = DateTime.now().microsecondsSinceEpoch.toString();
        addReg["REG_ID"] = id;
        addReg["TYPE"] = "USER";
        addReg["PASSWORD"] = RegPassWordController.text;
        addReg["CONFIRM_PASSWORD"] = RegConfirmPassWordController.text;
      }

      addReg["NAME"] = RegNameController.text;
      addReg["PHONE_NUMBER"] = RegPhoneController.text;
      addReg["PLACE"] = RegPlaceController.text;
      loginName = RegNameController.text;
      loginPhone = RegPhoneController.text;
      //
      // if (addUsersImage != null) {
      //   String photoId = DateTime.now().millisecondsSinceEpoch.toString();
      //   ref = FirebaseStorage.instance.ref().child(photoId);
      //   await ref.putFile(addUsersImage!).whenComplete(() async {
      //     await ref.getDownloadURL().then((value) {
      //       addReg["USERS_IMAGE"] = value;
      //     });
      //   });
      // } else if (UsersImageURL != "") {
      //   addReg["USERS_IMAGE"] = UsersImageURL;
      // } else {
      //   addReg["USERS_IMAGE"] = "";
      // }
      if (addUsersImage != null) {
        String photoId = DateTime.now().millisecondsSinceEpoch.toString();
        Reference ref = FirebaseStorage.instance.ref().child(photoId);
        await ref.putFile(addUsersImage!).whenComplete(() async {
          await ref.getDownloadURL().then((value) {
            addReg["USERS_IMAGE"] = value;
            updateProfileImage(value); // Update profile image URL
          });
        });
      }
      await db.collection("USERS").doc(id).set(addReg, SetOptions(merge: true));

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("PHONE_NUMBER", RegPhoneController.text);
      await prefs.setString("PASSWORD", RegPassWordController.text);

      isSaving = false;
      notifyListeners(); // Hide loading indicator

      // Show success snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Profile updated successfully!")),
      );

      // Navigate back
      Navigator.pop(context);

    } catch (e) {
      isSaving = false;
      notifyListeners(); // Hide loading indicator

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to update profile")),
      );
    }
  }

  Future UsersgetImagegallery() async {
    final imagePicker = ImagePicker();
    final pickedImage =
    await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      UserscropImage(pickedImage.path, "");
    } else {
      print('No image selected.');
    }
  }

  Future UsersgetImagecamera() async {
    final imgPicker = ImagePicker();
    final pickedImage = await imgPicker.pickImage(source: ImageSource.camera);

    if (pickedImage != null) {
      UserscropImage(pickedImage.path, "");
    } else {
      print('No image selected.');
    }
  }

  Future<void> UserscropImage(String path, String from) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: path,
      aspectRatioPresets: Platform.isAndroid
          ? [
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
      // print(' TTTy EYFE ' + imagefileList.length.toString());
      addUsersImage = File(croppedFile.path);

      // print(Registerfileimg.toString() + "fofiifi");
      getUser();
      notifyListeners();
    }
  }

  void clearRegistration(){
    RegNameController.clear();
    RegPhoneController.clear();
    RegPassWordController.clear();
    RegConfirmPassWordController.clear();
  }

  String loginName="";
  String loginPhone="";
  String loginPassword="";
  String loginConfirmPassword="";
  String loginId="";
  String loginType="";
  String loginPhoto="";
  String loginPlace="";


  Future<void> userAuthorized(BuildContext context, String? lgPhone, String? lgPassword) async {
    MainProvider mpro = Provider.of<MainProvider>(context, listen: false);
    print("Starting login process");
    try {
      print("Firestore with Phone: $lgPhone and Password: $lgPassword");
      db.collection("USERS")
          .where("PHONE_NUMBER", isEqualTo: lgPhone)
          .where("PASSWORD", isEqualTo: lgPassword)
          .get()
          .then((value) async {
        if (value.docs.isNotEmpty) {
          print("User found");
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString("_PhoneNumber", lgPhone!);
          prefs.setString("_Password", lgPassword!);

          Map<dynamic, dynamic> map = value.docs.first.data();
          loginId = map["REG_ID"] ?? "";
          loginName = map["NAME"] ?? "";
          loginPassword = map["PASSWORD"] ?? "";
          loginType=map["TYPE"]??"";
          loginPhone=map["PHONE_NUMBER"]??"";
          loginPhoto=map["USERS_IMAGE"]??"";
          print("Phone number: ${loginPhone}");

          if (map["TYPE"].toString() == "ADMIN") {
            callNextReplacement(context, adminhomeWidget());
            print("Navigate to admin screen");
          } else if (map["TYPE"].toString() == "USER") {
            print("Navigate to user side");
            mpro.getDestination();
            mpro.getDestination();
            callNextReplacement(context, UserBottomScreen(userId: loginId,));
          } else {
            print("Invalid user type");
            showSnackBarAlert(context, "INVALID USER");
          }
        } else {
          print("User not found or invalid credentials");
          showSnackBarAlert(context, "User not found or invalid credentials");
        }
      });
    } catch (e) {
      print("Error during login $e");
      showSnackBarAlert(context, e.toString());
    }
  }

  void editRegistration(String userID){
    db.collection("USERS").doc(userID).get().then((value) {
      Map<dynamic,dynamic> editreg=value.data() as Map;
      if(value.exists){
        RegNameController.text=editreg["NAME"].toString();
        RegPhoneController.text=editreg["PHONE_NUMBER"].toString();
        RegPlaceController.text=editreg["PLACE"].toString();
        notifyListeners();
      }
    },);
    notifyListeners();
  }

  List<UserModel>userList=[];

  void getUser(){
    db.collection("USERS").get().then((value) {
      if(value.docs.isNotEmpty){
        userList.clear();
        for(var element in value.docs){
          Map<dynamic, dynamic>userdata = element.data();
          userList.add(UserModel(
              element.id,
              userdata["NAME"],
              userdata["PHONE_NUMBER"],
              userdata["USERS_IMAGE"],
              userdata["PLACE"],
          ));
        }
        notifyListeners();
      }
    },);
  }

  void updateProfileImage(String newImageUrl) {
    loginPhoto = newImageUrl;
    notifyListeners();
  }


}

// Future<void> fetchUserData(String userId) async {
//   DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection("USERS").doc(userId).get();
//   if (userDoc.exists) {
//     loginPhoto = userDoc["USERS_IMAGE"];  // Make sure "photo" key exists
//     loginName = userDoc["NAME"];
//     loginPhone = userDoc["PHONE_NUMBER"];
//     loginPlace = userDoc["PLACE"];
//     notifyListeners(); // Important to trigger UI update
//   }
// }
// Future<void> addRegistraion(BuildContext context) async {
//
//   String id=DateTime.now().microsecondsSinceEpoch.toString();
//   HashMap<String,dynamic>addReg=HashMap();
//   addReg["REG_ID"]=id;
//   addReg["NAME"]=RegNameController.text;
//   addReg["PHONE_NUMBER"]=RegPhoneController.text;
//   addReg["PASSWORD"]=RegPassWordController.text;
//   addReg["CONFIRM_PASSWORD"]=RegConfirmPassWordController.text;
//   addReg["TYPE"]="USER";
//
//   db.collection("USERS").doc(id).set(addReg,SetOptions(merge: true));
//
//   SharedPreferences prefs=await SharedPreferences.getInstance();
//   await prefs.setString("PHONE_NUMBER", RegPhoneController.text);
//   await prefs.setString("PASSWORD", RegPassWordController.text);
//   userAuthorized(context, RegPhoneController.text, RegPassWordController.text);
//
// }

// Future<void> addRegistraion(BuildContext context,String from,String oldid) async {
//
//   String id=oldid;
//   HashMap<String,dynamic>addReg=HashMap();
//   if(from=="NEW"){
//     id=DateTime.now().microsecondsSinceEpoch.toString();
//     addReg["REG_ID"]=id;
//     addReg["TYPE"]="USER";
//     addReg["PASSWORD"]=RegPassWordController.text;
//     addReg["CONFIRM_PASSWORD"]=RegConfirmPassWordController.text;
//   }
//
//   addReg["NAME"]=RegNameController.text;
//   addReg["PHONE_NUMBER"]=RegPhoneController.text;
//   addReg["PLACE"]=RegPlaceController.text;
//   loginName=RegNameController.text;
//   loginPhone=RegPhoneController.text;
//   // loginPhoto=
//
//
//   if (addUsersImage != null) {
//     String photoId = DateTime
//         .now()
//         .millisecondsSinceEpoch
//         .toString();
//     ref = FirebaseStorage.instance.ref().child(photoId);
//     await ref.putFile(addUsersImage!).whenComplete(() async {
//       await ref.getDownloadURL().then((value) {
//         addReg["USERS_IMAGE"] = value;
//       },);
//     },);
//   }
//   else if (UsersImageURL != "") {
//     addReg["USERS_IMAGE"] = UsersImageURL;
//   }
//
//   else {
//     addReg["USERS_IMAGE"] = "";
//   }
//
//
//
//
//
//   db.collection("USERS").doc(id).set(addReg,SetOptions(merge: true));
//
//
//   SharedPreferences prefs=await SharedPreferences.getInstance();
//   await prefs.setString("PHONE_NUMBER", RegPhoneController.text);
//   await prefs.setString("PASSWORD", RegPassWordController.text);
//   userAuthorized(context, RegPhoneController.text, RegPassWordController.text);
//   notifyListeners();
//
// }
