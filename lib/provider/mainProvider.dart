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
import 'package:travelmate/constants/constant_colors.dart';
import 'package:travelmate/constants/globalMethods.dart';
import 'package:travelmate/models/adminModels.dart';

import '../constants/call_functions.dart';
import '../models/userModel.dart';
import '../refactors/showBottomSheet.dart';
import '../user/loginScreen.dart';

class MainProvider extends ChangeNotifier {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  firebase_storage.Reference ref = FirebaseStorage.instance.ref("IMAGEURL");

  // -------------------------------ADD DESTINATION-------------------------------------------------------------------------------------------------

  TextEditingController destNameController = TextEditingController();
  TextEditingController destPlaceController = TextEditingController();
  TextEditingController destDistrictController = TextEditingController();
  TextEditingController destDiscriptionController = TextEditingController();
  TextEditingController destEntryFeeController = TextEditingController();
  TextEditingController destBestTimeController = TextEditingController();

  Future getDestImggallery() async {
    final imagePicker = ImagePicker();
    final pickedImage =
    await imagePicker.pickImage(source: ImageSource.gallery);

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
      addDestFileImage = File(croppedFile.path);
      // print(Registerfileimg.toString() + "fofiifi");
      notifyListeners();
    }
  }

  File? addDestFileImage;
  String destFileURL = "";
  bool _isSwitched = false;

  bool get isSwitched => _isSwitched;

  void toggleSwitch(bool value, BuildContext context) {
    _isSwitched = value;
    notifyListeners();
    // addDestination(context);
  }

  Future<void> addDestination(BuildContext context, String from,
      String oldId) async {
    print("adddfunction");

    String id = DateTime
        .now()
        .microsecondsSinceEpoch
        .toString();
    HashMap<String, Object> addDest = HashMap();
    addDest["DEST_NAME"] = destNameController.text;
    addDest["DEST_PLACE"] = destPlaceController.text;
    addDest["DEST_DISTRICT"] = destDistrictController.text;
    addDest["DEST_DISCRIPTION"] = destDiscriptionController.text;
    addDest["DEST_BEST_TIME"] = destBestTimeController.text;
    addDest["DEST_SLOT_AVAILABILITY"] =
    _isSwitched ? "Available" : "Not Available";
    addDest["DEST_ENTRY_FEE"] = destEntryFeeController.text;

    //check if there s an image file selected
    if (addDestFileImage != null) {
      print("Image selected: ${addDestFileImage?.path}");
      String photoId = DateTime
          .now()
          .millisecondsSinceEpoch
          .toString();
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

    if (from == "NEW") {
      addDest["DEST_ID"] = id;
    }
    if (from == "EDIT") {
      db
          .collection("DESTINATION")
          .doc(oldId)
          .set(addDest, SetOptions(merge: true));
    } else {
      db.collection("DESTINATION").doc(id).set(addDest);
    }

    showSnackBar(context, "Destination added successfully");
    print("added dest");

    Navigator.pop(context);

    getDestination();

    notifyListeners();
  }

  void clearDestination() {
    destNameController.clear();
    destPlaceController.clear();
    destDistrictController.clear();
    destBestTimeController.clear();
    destDiscriptionController.clear();
    destEntryFeeController.clear();
    addDestFileImage = null;
    destFileURL = "";
    _isSwitched = false;
    notifyListeners();
  }

  List<DestinationModel> destinationList = [];

  void getDestination() {
    db.collection("DESTINATION").get().then(
          (value) {
        if (value.docs.isNotEmpty) {
          destinationList.clear();
          for (var elemenet in value.docs) {
            Map<String, dynamic> dest = elemenet.data();
            destinationList.add(DestinationModel(
                elemenet.id,
                dest["DEST_NAME"].toString() ?? "",
                dest["DEST_PLACE"].toString() ?? "",
                dest["DEST_DISTRICT"].toString() ?? "",
                dest["DEST_BEST_TIME"].toString() ?? "",
                dest["DEST_IMAGE"].toString() ?? "",
                dest["DEST_DISCRIPTION"].toString() ?? "",
                num.tryParse(dest["DEST_ENTRY_FEE"].toString()) ?? 0,
                // dest["DEST_ENTRY_FEE"]??"",
                dest["DEST_SLOT_AVAILABILITY"].toString() ?? ""));
          }
        }
        // print("Get destination");
        notifyListeners();
      },
    );
  }

  void deleteDestination(String destId, BuildContext context) {
    print("deleteeee");
    db.collection("DESTINATION").doc(destId).delete();
    print("dest deleting--------");
    getDestination();
    notifyListeners();
  }

  void editAddedDestination(String destId) {
    db.collection("DESTINATION").doc(destId).get().then(
          (value) {
        Map<dynamic, dynamic> editDest = value.data() as Map;
        if (value.exists) {
          destNameController.text = editDest["DEST_NAME"].toString() ?? "";
          destPlaceController.text = editDest["DEST_PLACE"].toString() ?? "";
          destDistrictController.text =
              editDest["DEST_DISTRICT"].toString() ?? "";
          destDistrictController.text =
              editDest["DEST_BEST_TIME"].toString() ?? "";
          destDiscriptionController.text =
              editDest["DEST_DISCRIPTION"].toString() ?? "";
          destEntryFeeController.text =
              editDest["DEST_ENTRY_FEE"].toString() ?? "";
        }
      },
    );
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
    final pickedImage =
    await imagePicker.pickImage(source: ImageSource.gallery);

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
      addEventFileImg = File(croppedFile.path);
      // print(Registerfileimg.toString() + "fofiifi");
      notifyListeners();
    }
  }

  Future<void> addEvent(BuildContext context, String from, String oldId) async {
    print("adddfunction");

    String id = DateTime
        .now()
        .microsecondsSinceEpoch
        .toString();
    HashMap<String, Object> addEvent = HashMap();
    addEvent["EVENT_NAME"] = eventNameController.text;
    addEvent["EVENT_PLACE"] = eventPlaceController.text;
    addEvent["EVENT_DISTRICT"] = eventDistrictController.text;
    addEvent["EVENT_DISCRIPTION"] = eventDiscriptionController.text;
    addEvent["EVENT_SLOT_AVAILABILITY"] =
    _isSwitched ? "Available" : "Not Available";
    addEvent["EVENT_ENTRY_FEE"] = eventEntryFeeController.text;

    print("$addEvent");
    //check if there s an image file selected
    if (addEventFileImg != null) {
      print("Image selected: ${addEventFileImg?.path}");
      String photoId = DateTime
          .now()
          .millisecondsSinceEpoch
          .toString();
      ref = FirebaseStorage.instance.ref().child(photoId);
      //Upload the image to firestore storage
      try {
        await ref.putFile(addEventFileImg!).whenComplete(() async {
          await ref.getDownloadURL().then((value) {
            addEvent["EVENT_IMAGE"] = value;

            notifyListeners();
          });
          notifyListeners();
        });
      } catch (e) {
        print("$e jkjkjkjkjjjjjjjjjjjjjjjjjjj");
      }
    }
    print("okk");
    //edit the added destination

    if (from == "NEW") {
      addEvent["EVENT_ID"] = id;
    }
    if (from == "EDIT") {
      db.collection("EVENT").doc(oldId).set(addEvent, SetOptions(merge: true));
    } else {
      db.collection("EVENT").doc(id).set(addEvent);
      print("adddddddddddddd");
    }

    getEvent();
    showSnackBar(context, "Event added successfully");
    print("event added");

    Navigator.pop(context);

    notifyListeners();
  }

  void clearEvent() {
    eventNameController.clear();
    eventPlaceController.clear();
    eventDistrictController.clear();
    eventDiscriptionController.clear();
    eventEntryFeeController.clear();
    addEventFileImg = null;
    eventFileUrl = "";
    _isSwitched = false;
    notifyListeners();
  }

  List<EventsModel> eventList = [];

  void getEvent() {
    db.collection("EVENT").get().then(
          (value) {
        if (value.docs.isNotEmpty) {
          eventList.clear();
          for (var element in value.docs) {
            Map<String, dynamic> event = element.data();
            eventList.add(EventsModel(
                element.id,
                event["EVENT_NAME"] ?? "",
                event["EVENT_PLACE"] ?? "",
                event["EVENT_DISTRICT"] ?? "",
                event["EVENT_IMAGE"] ?? "",
                event["EVENT_DISCRIPTION"] ?? "",
                event["EVENT_ENTRY_FEE"] ?? "",
                event["EVENT_SLOT_AVAILABILITY"] ?? ""));
            // print("$event");
          }
        }
        notifyListeners();
      },
    );
  }

  void deleteEvent(String eventId, BuildContext context) {
    print("deleteeee");
    db.collection("EVENT").doc(eventId).delete();
    print("event deleting--------");
    getEvent();
    notifyListeners();
  }

  void editAddedEvent(String eventId) {
    db.collection("EVENT").doc(eventId).get().then(
          (value) {
        Map<dynamic, dynamic> editEvent = value.data() as Map;
        if (value.exists) {
          eventNameController.text = editEvent["EVENT_NAME"].toString() ?? "";
          eventPlaceController.text = editEvent["EVENT_PLACE"].toString() ?? "";
          eventDistrictController.text =
              editEvent["EVENT_DISTRICT"].toString() ?? "";
          eventDiscriptionController.text =
              editEvent["EVENT_DISCRIPTION"].toString() ?? "";
          eventEntryFeeController.text =
              editEvent["EVENT_ENTRY_FEE"].toString() ?? "";
        }
      },
    );
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
                  border: Border.all(color: cstOrange1),
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                ),
                child: TextButton(
                    child:
                    const Text('No', style: TextStyle(color: Colors.black)),
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
                  color: cstOrange1,
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
                      SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                      prefs.clear();
                      // loginphoneController.clear();
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => LoginPage()),
                              (Route<dynamic> route) => false);
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

  void addSlot() {
    String id = DateTime
        .now()
        .microsecondsSinceEpoch
        .toString();
    Map<String, dynamic> det = HashMap();
    det["DESIGNATION"] = slotController.text;
    db.collection("Slot").doc(id).set(det);
    notifyListeners();
  }

//   // ------------------------------------------Make ticket booking----------------------------------------------------------------------------------

  //for selecte the date from calnder.

  DateTime? _selectedDate;

  DateTime? get selectedDate => _selectedDate;

  void setSelectedDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  int selectedIndex = -1;
  String destFee = '0'; // Default fee, which will be updated dynamically

  // Method to select a member count
  void selectIndex(int index) {
    selectedIndex = index;
    notifyListeners(); // Notify listeners to rebuild the UI
  }

  // Method to get selected count number
  int get selectedCount =>
      selectedIndex + 1; // Because index starts from 0, but count starts from 1

  // Method to set the destination fee after fetching from Firestore
  void setDestFee(String fee) {
    destFee = fee;
    notifyListeners(); // Notify listeners when fee is updated
  }

  // Method to get the total fee
  double get totalFee {
    double entryFee = double.tryParse(destFee) ?? 0.0;
    return selectedCount * entryFee;
  }

  // Method to get GST (assuming GST is 2%)
  double get gst {
    return totalFee * 0.02; // 2% GST
  }

  // Method to get the final total amount
  double get totalAmount {
    return totalFee + gst;
  }

  //for reseting ticket booing

  void destResetBooking() {
    _selectedDate = null;
    selectedIndex = -1;
    destFee = '0';
    notifyListeners();
  }

  void destinationBooking(String userId,
      String destId,
      String destName,
      String destDistrict,
      String destPlace,
      String destEntryFee,
      num totalTickets,
      num totalAmount,
      num subTotal,
      String destImage,) async {
    // Check if the userId is empty. If it is, we cannot proceed with the booking
    if (userId.isEmpty) {
      print("User id is missing");
      return;
    }

    // Check if selectedDate is null. If it is, we cannot proceed without a date
    if (selectedDate == null) {
      print("Invalid date selected");
      return;
    }
    String booikngID = DateTime
        .now()
        .microsecondsSinceEpoch
        .toString();
    print("Booking details:");
    print(
        "User ID:$userId,Destination Id: $destId,Selected date :$selectedDate");
    print("navigate to destination booking");
    HashMap<String, dynamic> destTicket = HashMap();
    destTicket["BOOKING_ID"] = booikngID;
    destTicket["DEST_ID"] = destId;
    destTicket["DEST_NAME"] = destName;
    destTicket["DEST_DISTRICT"] = destDistrict;
    destTicket["DEST_ENTRY_FEE"] = destEntryFee;
    destTicket["DEST_IMAGE"] = destImage;
    destTicket["DEST_PLACE"] = destPlace;
    destTicket["TOTAL_TICKET"] = totalTickets;
    destTicket["SUB_TOTAL"] = subTotal;
    destTicket["TOTAL_PRICE"] = totalAmount;
    destTicket["DATE"] = selectedDate;
    try {
      await db
          .collection("USERS")
          .doc(userId)
          .collection("DEST_TICKET")
          .doc(booikngID)
          .set(destTicket);
      print("userid: $userId");

      print("Booking added successfully");

      destResetBooking();

      getDestReceipt(userId);
    } catch (error) {
      print("Failed to add booking : $error");
    }
    notifyListeners();
  }


  // ----------------------------GET DESTINATION TICKET----------------------------------


  List<DestTicketModel> destTicketList = [];
  bool isLoading = false;

  Future<void> getDestReceipt(String userId) async {
    isLoading = true; // Indicate loading starts
    notifyListeners();

    try {
      var querySnapshot = await FirebaseFirestore.instance
          .collection("USERS")
          .doc(userId)
          .collection("DEST_TICKET")
          .orderBy("DATE", descending: true) // Order by date
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        destTicketList = querySnapshot.docs.map((doc) {
          Map<String, dynamic> ticket = doc.data() as Map<String, dynamic>;
          String travelDate = ticket["DATE"] is Timestamp
              ? (ticket["DATE"] as Timestamp).toDate().toString()
              : ticket["DATE"] ?? "";

          return DestTicketModel(
            doc.id,
            ticket["DEST_NAME"] ?? "",
            ticket["DEST_PLACE"] ?? "",
            ticket["DEST_DISTRICT"] ?? "",
            travelDate,
            int.tryParse(ticket["TOTAL_TICKET"].toString()) ?? 0,
            num.tryParse(ticket["DEST_ENTRY_FEE"]?.toString() ?? '0') ?? 0.0,
            num.tryParse(ticket["SUB_TOTAL"]?.toString() ?? '0') ?? 0.0,
            num.tryParse(ticket["TOTAL_PRICE"]?.toString() ?? '0') ?? 0.0,
            ticket["DEST_IMAGE"]??"",
          );
        }).toList();
      } else {
        destTicketList.clear(); // Clear list if no bookings found
      }
    } catch (error) {
      print("Error fetching tickets: $error");
    }

    isLoading = false; // Indicate loading ends
    notifyListeners();
  }

  // -----------------------------------------GET EVENT----------------------------------



}