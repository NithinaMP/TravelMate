import 'dart:collection';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelmate/constants/globalMethods.dart';
import 'package:travelmate/models/adminModels.dart';

import '../constants/call_functions.dart';
import '../refactors/showBottomSheet.dart';
import '../user/loginScreen.dart';

class MainProvider extends ChangeNotifier {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  firebase_storage.Reference ref = FirebaseStorage.instance.ref("IMAGEURL");

  // -------------------------------ADD DESTINATION-------------------------------------------------------------------------------------------------

  TextEditingController destNameController=TextEditingController();
  TextEditingController destPlaceController=TextEditingController();
  TextEditingController destDistrictController=TextEditingController();
  TextEditingController destDiscriptionController=TextEditingController();
  TextEditingController destEntryFeeController=TextEditingController();


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
  File? addDestFileImage;
  String destFileURL="";
  bool _isSwitched=false;
  bool get isSwitched=>_isSwitched;

  void toggleSwitch(bool value,BuildContext context){
    _isSwitched=value;
    notifyListeners();
    // addDestination(context);
  }


  Future<void> addDestination(BuildContext context,String from,String oldId) async {
    print("adddfunction");

    String id=DateTime.now().microsecondsSinceEpoch.toString();
    HashMap<String,Object> addDest=HashMap();
    addDest["DEST_NAME"]=destNameController.text;
    addDest["DEST_PLACE"]=destPlaceController.text;
    addDest["DEST_DISTRICT"]=destDistrictController.text;
    addDest["DEST_DISCRIPTION"]=destDiscriptionController.text;
    addDest["DEST_SLOT_AVAILABILITY"]=_isSwitched?"Available":"Not Available";
    addDest["DEST_ENTRY_FEE"]=destEntryFeeController.text;


      //check if there s an image file selected
      if (addDestFileImage != null) {
        print("Image selected: ${addDestFileImage?.path}");
        String photoId = DateTime.now().millisecondsSinceEpoch.toString();
        ref = FirebaseStorage.instance.ref().child(photoId);

        //Upload the image to firestore storage
        await ref.putFile(addDestFileImage!).whenComplete(() async {
          await ref.getDownloadURL().then((value) {
            addDest["DEST_IMAGE"] = value;

            notifyListeners();
          });
          notifyListeners();
        });
      }

      //edit the added destination

      if(from=="NEW"){
        addDest["DEST_ID"]=id;
      }
      if(from=="EDIT"){
        db.collection("DESTINATION").doc(oldId).set(addDest,SetOptions(merge: true));
      }
      else{
        db.collection("DESTINATION").doc(id).set(addDest);
      }



      showSnackBar(context, "Destination added successfully");
      print("added dest");

      Navigator.pop(context);




    getDestination();

    notifyListeners();
  }


  void clearDestination(){
    destNameController.clear();
    destPlaceController.clear();
    destDistrictController.clear();
    destDiscriptionController.clear();
    destEntryFeeController.clear();
    addDestFileImage=null;
    destFileURL="";
    _isSwitched=false;
    notifyListeners();
  }
  List<DestinationModel> destinationList=[];
  void getDestination(){
    db.collection("DESTINATION").get().then((value) {
      if(value.docs.isNotEmpty){
        destinationList.clear();
        for(var elemenet in value.docs ){
          Map<String,dynamic>dest=elemenet.data();
          destinationList.add(DestinationModel(
              elemenet.id,
              dest["DEST_NAME"].toString() ?? "",
              dest["DEST_PLACE"].toString() ?? "",
              dest["DEST_DISTRICT"].toString()??"",
              dest["DEST_IMAGE"].toString()??"",
              dest["DEST_DISCRIPTION"].toString()??"",
              dest["DEST_ENTRY_FEE"].toString()??"",
              dest["DEST_SLOT_AVAILABILITY"].toString()??""
          ));
        }


      }
      print("Get destination");
      notifyListeners();
    },);
  }
  
  void deleteDestination(String destId,BuildContext context){
    print("deleteeee");
    db.collection("DESTINATION").doc(destId).delete();
    print("dest deleting--------");
    getDestination();
    notifyListeners();
  }

  void editAddedDestination(String destId){
    db.collection("DESTINATION").doc(destId).get().then((value) {
      Map<dynamic,dynamic>editDest=value.data() as Map;
      if(value.exists){
        destNameController.text=editDest["DEST_NAME"].toString()??"";
        destPlaceController.text=editDest["DEST_PLACE"].toString()??"";
        destDistrictController.text=editDest["DEST_DISTRICT"].toString()??"";
        destDiscriptionController.text=editDest["DEST_DISCRIPTION"].toString()??"";
        destEntryFeeController.text=editDest["DEST_ENTRY_FEE"].toString()??"";

      }
    },);
  }


// ------------------------------------------------ADD EVENT----------------------------------------------------------------------

  TextEditingController eventNameController = TextEditingController();
  TextEditingController eventPlaceController = TextEditingController();
  TextEditingController eventDistrictController = TextEditingController();
  TextEditingController eventDiscriptionController = TextEditingController();
  TextEditingController eventEntryFeeController = TextEditingController();

  File? addEventFileImg;
  String eventFileUrl = "";


  Future getEventImggallery() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      cropEventImage(pickedImage.path, "");
    } else {
      print('No image selected.');
    }
  }

  Future getEventImgcamera() async {
    final imgPicker = ImagePicker();
    final pickedImage = await imgPicker.pickImage(source: ImageSource.camera);

    if (pickedImage != null) {
      cropEventImage(pickedImage.path, "");
    } else {
      print('No image selected.');
    }
  }

  Future<void> cropEventImage(String path, String from) async {
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
      addEventFileImg = File(croppedFile.path);
      // print(Registerfileimg.toString() + "fofiifi");
      notifyListeners();
    }
  }


  Future<void> addEvent(BuildContext context,String from,String oldId) async {
    print("adddfunction");

    String id=DateTime.now().microsecondsSinceEpoch.toString();
    HashMap<String,Object> addEvent=HashMap();
    addEvent["EVENT_NAME"]=eventNameController.text;
    addEvent["EVENT_PLACE"]=eventPlaceController.text;
    addEvent["EVENT_DISTRICT"]=eventDistrictController.text;
    addEvent["EVENT_DISCRIPTION"]=eventDiscriptionController.text;
    addEvent["EVENT_SLOT_AVAILABILITY"]=_isSwitched?"Available":"Not Available";
    addEvent["EVENT_ENTRY_FEE"]=eventEntryFeeController.text;
    print("mmmmmmmmmmmmm");

    print("$addEvent");
    //check if there s an image file selected
    if (addEventFileImg != null) {
      print("Image selected: ${addEventFileImg?.path}");
      String photoId = DateTime.now().millisecondsSinceEpoch.toString();
      ref = FirebaseStorage.instance.ref().child(photoId);
      print("wwwwwwweeeeeeeeeee");
      //Upload the image to firestore storage
      try{
        await ref.putFile(addEventFileImg!).whenComplete(() async {
          print("ssssssssssss");
          await ref.getDownloadURL().then((value) {
            addEvent["EVENT_IMAGE"] = value;

            notifyListeners();
          });
          notifyListeners();
        });
      }
      catch(e){
        print("$e jkjkjkjkjjjjjjjjjjjjjjjjjjj");
      }
    }
  print("okk");
    //edit the added destination

    if(from=="NEW"){
      addEvent["EVENT_ID"]=id;
    }
    if(from=="EDIT"){
      db.collection("EVENT").doc(oldId).set(addEvent,SetOptions(merge: true));
    }
    else{
      db.collection("EVENT").doc(id).set(addEvent);
      print("adddddddddddddd");
    }


    getEvent();
    showSnackBar(context, "Event added successfully");
    print("event added");

    Navigator.pop(context);





    notifyListeners();
  }


  void clearEvent(){
    eventNameController.clear();
    eventPlaceController.clear();
    eventDistrictController.clear();
    eventDiscriptionController.clear();
    eventEntryFeeController.clear();
    addEventFileImg=null;
    eventFileUrl="";
    _isSwitched=false;
    notifyListeners();
  }
 List<EventsModel> eventList=[];
 void getEvent(){
   print("getttttttttt");
   db.collection("EVENT").get().then((value) {
     print("eeeeeeeeeeevvvvvvvvvvent");
     if(value.docs.isNotEmpty){
       eventList.clear();
       for(var element in value.docs){
         Map <String ,dynamic> event=element.data();
         eventList.add(EventsModel(
             element.id,
             event["EVENT_NAME"]??"",
             event["EVENT_PLACE"]??"",
             event["EVENT_DISTRICT"]??"",
             event["EVENT_IMAGE"]??"",
             event["EVENT_DISCRIPTION"]??"",
             event["EVENT_ENTRY_FEE"]??"",
             event["EVENT_SLOT_AVAILABILITY"]??""
         ));
         print("$event");
       }
     }
     notifyListeners();
   },);
 }

  void deleteEvent(String eventId,BuildContext context){
    print("deleteeee");
    db.collection("EVENT").doc(eventId).delete();
    print("event deleting--------");
    getEvent();
    notifyListeners();
  }

  void editAddedEvent(String eventId){
    db.collection("EVENT").doc(eventId).get().then((value) {
      Map<dynamic,dynamic>editEvent=value.data() as Map;
      if(value.exists){
        eventNameController.text=editEvent["EVENT_NAME"].toString()??"";
        eventPlaceController.text=editEvent["EVENT_PLACE"].toString()??"";
        eventDistrictController.text=editEvent["EVENT_DISTRICT"].toString()??"";
        eventDiscriptionController.text=editEvent["EVENT_DISCRIPTION"].toString()??"";
        eventEntryFeeController.text=editEvent["EVENT_ENTRY_FEE"].toString()??"";

      }

    },);
  }


  // ---------------------------------LOGOUT_______________________________________________________________________________

  logOutAlert(BuildContext context,) {
    final height = MediaQuery
        .of(context)
        .size
        .height;
    final width = MediaQuery
        .of(context)
        .size
        .width;
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.white,
      scrollable: true,
      title: const Text(
        "Do you want to Logout",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 35,
                width: 100,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.red),
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                ),
                child: TextButton(
                    child: const Text(
                        'No', style: TextStyle(color: Colors.black)),
                    onPressed: () {
                      finish(context);
                      // finish(context);
                    }),
              ),
              Container(
                height: 35,
                width: 100,
                decoration: BoxDecoration(
                  // border: Border.all(color:Colors.yellow),
                  color: Colors.purple,
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                ),
                child: TextButton(
                    child: const Text(
                      'Yes',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      SharedPreferences prefs = await SharedPreferences
                          .getInstance();
                      prefs.clear();
                      // loginphoneController.clear();
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => LoginPage()), (
                          Route<dynamic> route) => false);
                    }),
              ),
            ],
          ),
        ],
      ),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }


// ---------------------------------------------------------------------------------------------
  TextEditingController slotController = TextEditingController();
  void addSlot(){
    String id=DateTime.now().microsecondsSinceEpoch.toString();
    Map<String,dynamic>det=HashMap();
    det["DESIGNATION"] = slotController.text;
    db.collection("Slot").doc(id).set(det);
    notifyListeners();

  }



  // ---------------------------------------------------
  // File? selectedFile;
  // String fileURL = "";
  //
  // // Add this function in your MainProvider class to handle image picking and cropping
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
  // // Assuming you already have the cropImage function here or elsewhere
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
  //     // Save or update the file URL as needed based on `from`
  //     if (from == "AddEvent") {
  //       selectedFile = File(croppedFile.path);
  //       fileURL = "EventFileUrl"; // Set event-specific file URL logic here
  //     } else if (from == "AddDestination") {
  //       selectedFile = File(croppedFile.path);
  //       fileURL = "DestinationFileUrl"; // Set destination-specific file URL logic here
  //     }
  //     // Notify listeners if necessary (for UI updates)
  //     notifyListeners();
  //   }
  // }
}
