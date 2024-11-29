import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelmate/admin/adminHomescreen.dart';
import 'package:travelmate/constants/call_functions.dart';
import 'package:travelmate/constants/globalMethods.dart';

import '../user/homeScreen.dart';
import '../user/userBottomScreen.dart';

class LoginProvider extends ChangeNotifier{
  final FirebaseFirestore db = FirebaseFirestore.instance;
  firebase_storage.Reference ref = FirebaseStorage.instance.ref("IMAGEURL");


  // -----------------------ADD REGISTRATION--------------------------------------------------------------

  TextEditingController RegNameController=TextEditingController();
  TextEditingController RegPhoneController=TextEditingController();
  TextEditingController RegPassWordController=TextEditingController();
  TextEditingController RegConfirmPassWordController=TextEditingController();

  Future<void> addRegistraion(BuildContext context) async {

    String id=DateTime.now().microsecondsSinceEpoch.toString();
    HashMap<String,dynamic>addReg=HashMap();
    addReg["REG_ID"]=id;
    addReg["NAME"]=RegNameController.text;
    addReg["PHONE_NUMBER"]=RegPhoneController.text;
    addReg["PASSWORD"]=RegPassWordController.text;
    addReg["CONFIRM_PASSWORD"]=RegConfirmPassWordController.text;
    addReg["TYPE"]="USER";

    db.collection("USERS").doc(id).set(addReg,SetOptions(merge: true));

    SharedPreferences prefs=await SharedPreferences.getInstance();
    await prefs.setString("PHONE_NUMBER", RegPhoneController.text);
    await prefs.setString("PASSWORD", RegPassWordController.text);
    userAuthorized(context, RegPhoneController.text, RegPassWordController.text);

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


  Future<void> userAuthorized(BuildContext context, String? lgPhone, String? lgPassword) async {
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

          if (map["TYPE"].toString() == "ADMIN") {
            callNextReplacement(context, adminhomeWidget());
            print("Navigate to admin screen");
          } else if (map["TYPE"].toString() == "USER") {
            print("Navigate to user side");
            callNextReplacement(context, UserBottomScreen());
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

// Future<void> userAuthorized(BuildContext context,String? lgPhone,String? lgPassword)async {
  //
  //   print("Starting login process");
  //   try{
  //     print("FireStore with Name:$lgPhone and $lgPassword");
  //     db.collection("USERS").where("PHONE_NUMBER",isEqualTo:lgPhone ).where("PASSWORD",isEqualTo: lgPassword).get().then((value) async {
  //       if(value.docs.isNotEmpty){
  //         print("user found---");
  //         SharedPreferences prefs=await SharedPreferences.getInstance();
  //         prefs.setString("_PhoneNumber", lgPhone!);
  //         prefs.setString("_Password", lgPassword!);
  //
  //         Map<dynamic,dynamic> map=value.docs.first.data();
  //         loginId=map["REG_ID"]??"";
  //         loginName=map["NAME"]??"";
  //         loginPassword=map["PASSWORD"]??"";
  //
  //         if(map["TYPE"].toString()=="ADMIN"){
  //           callNextReplacement(context, adminhomeWidget());
  //           print("Navigate to admin Screen");
  //         }
  //         else if(map["TYPE"].toString()=="USER"){
  //           print("navigate to user side");
  //           callNextReplacement(context, UserBottomScreen());
  //         }
  //         else{
  //           print("Invalid User type");
  //           showSnackBarAlert(context, "INVALID USER");
  //         }
  //       }
  //       else{
  //         print("User not found or invalid credentials");
  //         showSnackBarAlert(context, "User not found or invalid credentials");
  //       }
  //     },);
  //
  //   }
  //       catch(e){
  //     print("Error during login $e");
  //       showSnackBarAlert(context, e.toString());
  //       }
  // }

}