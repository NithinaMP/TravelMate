import 'dart:collection';
import 'dart:io';
import 'package:url_launcher/url_launcher.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
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
  // TextEditingController eventDateController = TextEditingController();

  DateTime? _selectedEventDate;

  DateTime? get selectedEventDate => _selectedEventDate;

  void updateEventDate(DateTime date) {
    _selectedEventDate = date;
    notifyListeners();
  }

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

  // ----------------------------------------------------
  DateTime? eventSelectedDate;

  void updateEventSelectedDate(DateTime date) {
    eventSelectedDate = date;
    notifyListeners();
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
    addEvent["EVENT_DATE"] = eventSelectedDate??DateTime.now();

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
    eventSelectedDate=null;
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

            //handle Timestamp conversion for event_date
            String eventDate="";
            if(event["EVENT_DATE"] is Timestamp){
              eventDate=(event["EVENT_DATE"] as Timestamp).toDate().toString();
            }
            else if(event["EVENT_DATE"] is String){
              eventDate=event["EVENT_DATE"];
            }
            eventList.add(EventsModel(
                element.id,
                event["EVENT_NAME"] ?? "",
                event["EVENT_PLACE"] ?? "",
                event["EVENT_DISTRICT"] ?? "",
                event["EVENT_IMAGE"] ?? "",
                event["EVENT_DISCRIPTION"] ?? "",
                // num.parse(event["EVENT_ENTRY_FEE"] ?? ""),
                num.tryParse(event["EVENT_ENTRY_FEE"].toString()) ?? 0,
                event["EVENT_SLOT_AVAILABILITY"] ?? "",
                eventDate)
            );
            // print("$event");
          }
        }
        notifyListeners();
      },
    );
  }
  // void getEvent() {
  //   db.collection("EVENT").get().then(
  //         (value) {
  //       if (value.docs.isNotEmpty) {
  //         eventList.clear();
  //         value.docs.forEach((element) {
  //           try {
  //             Map<String, dynamic> event = element.data();
  //
  //             // Handle Timestamp conversion for EVENT_DATE
  //             String eventDate = "";
  //             if (event["EVENT_DATE"] is Timestamp) {
  //               eventDate = (event["EVENT_DATE"] as Timestamp).toDate().toString();
  //             } else if (event["EVENT_DATE"] is String) {
  //               eventDate = event["EVENT_DATE"];
  //             }
  //
  //             // Add event to the list
  //             eventList.add(EventsModel(
  //               element.id,
  //               event["EVENT_NAME"] ?? "",
  //               event["EVENT_PLACE"] ?? "",
  //               event["EVENT_DISTRICT"] ?? "",
  //               event["EVENT_IMAGE"] ?? "",
  //               event["EVENT_DISCRIPTION"] ?? "",
  //               num.tryParse(event["EVENT_ENTRY_FEE"]?.toString() ?? "") ?? 0,
  //               event["EVENT_SLOT_AVAILABILITY"] ?? "",
  //               eventDate,
  //             ));
  //           } catch (e) {
  //             // Log error details for debugging
  //             print("Error processing event: ${element.id}, Error: $e");
  //           }
  //         });
  //
  //         // Notify listeners about changes
  //         notifyListeners();
  //       }
  //     },
  //   ).catchError((error) {
  //     // Handle Firestore fetch errors
  //     print("Error fetching events: $error");
  //   });
  // }

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


          if(editEvent["EVENT_DATE"]!=null){
            eventSelectedDate=(editEvent["EVENT_DATE"] as Timestamp).toDate();
          }
          else{
            eventSelectedDate=null;///set to null if no date is available
          }
          notifyListeners();
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



//   // ------------------------------------------DESTINATION Make ticket booking----------------------------------------------------------------------------------

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

  ///new code for addin ticket in both collection
  void destinationBooking(
      String userId,
      String destId,
      String destName,
      String destDistrict,
      String destPlace,
      String destEntryFee,
      num totalTickets,
      num totalAmount,
      num subTotal,
      String destImage) async {

    if (userId.isEmpty) {
      print("User id is missing");
      return;
    }

    if (selectedDate == null) {
      print("Invalid date selected");
      return;
    }

    String formattedDate = DateFormat("EEEE,MMMM,dd,yyyy").format(selectedDate!);
    String bookingID = DateTime.now().microsecondsSinceEpoch.toString();

    print("Booking details:");
    print("User ID: $userId, Destination ID: $destId, Selected date: $selectedDate");
    print("Navigating to destination booking...");

    Map<String, dynamic> bookingData = {
      "BOOKING_ID": bookingID,
      "USER_ID": userId,
      "DEST_ID": destId,
      "DEST_NAME": destName,
      "DEST_DISTRICT": destDistrict,
      "DEST_ENTRY_FEE": destEntryFee,
      "DEST_IMAGE": destImage,
      "DEST_PLACE": destPlace,
      "TOTAL_TICKET": totalTickets,
      "SUB_TOTAL": subTotal,
      "TOTAL_PRICE": totalAmount,
      "DATE": formattedDate,
    };

    try {
      // Save booking inside the user's DEST_TICKET collection
      await db.collection("USERS").doc(userId)
          .collection("DEST_TICKET").doc(bookingID)
          .set(bookingData);

      // Save booking in the separate BOOKINGS collection
      // await db.collection("BOOKINGS").doc(bookingID).collection("DEST_BOOKINGS").doc(destId).set(bookingData);
      await db.collection("BOOKINGS").doc(bookingID).set(bookingData);
      // ✅ 3️⃣ Save booking inside the event’s collection for counting
      await db.collection("DESTINATION").doc(destId).collection("BOOKINGS").doc(bookingID).set(bookingData);

      print("Booking added successfully to both USERS/DEST_TICKET and BOOKINGS collections.");

      destResetBooking();
      getDestReceipt(userId);
    } catch (error) {
      print("Failed to add booking: $error");
    }
    notifyListeners();
  }



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


  // -----------------------------------------GET EVENT Ticket----------------------------------

  int selectedEventIndex = -1;
  String eventFee = '0'; // Default fee, which will be updated dynamically

// Method to select a member count
  void selectEventIndex(int index) {
    selectedEventIndex = index;
    notifyListeners(); // Notify listeners to rebuild the UI
  }

// Method to get selected count number
  int get selectedEventCount =>
      selectedEventIndex + 1; // Because index starts from 0, but count starts from 1

// Method to set the destination fee after fetching from Firestore
  void setEventFee(String fee) {
    eventFee = fee;
    notifyListeners(); // Notify listeners when fee is updated
  }

// Method to get the total fee
  double get totalEventFee {
    double entryFee = double.tryParse(eventFee) ?? 0.0;
    return selectedEventCount * entryFee;
  }

// // Method to get GST (assuming GST is 2%)
//   double get gst {
//     return totalFee * 0.02; // 2% GST
//   }

// Method to get the final total amount
  double get totalEventAmount {
    return totalFee + gst;
  }

//for reseting ticket booing

  void eventResetBooking() {
    _selectedDate = null;
    selectedEventIndex = -1;
    eventFee = '0';
    notifyListeners();
  }





  void eventBooking(
      String userId,
      String eventId,
      String eventName,
      String eventDistrict,
      String eventPlace,
      String eventEntryFee,
      num totalTickets,
      num totalAmount,
      num subTotal,
      String eventImage,
      String eventDate, // Already in "Thursday, December, 26, 2024" format
      ) async {
    print("Received event date in eventBooking: $eventDate");

    // Check if the userId or eventDate is empty
    if (userId.isEmpty || eventDate.isEmpty) {
      print("Error: user id or Event date is missing or invalid");
      return;
    }

    String bookingID = DateTime.now().microsecondsSinceEpoch.toString();
    print("Event Booking details:");
    print("User ID: $userId, Destination Id: $eventId, Selected date: $eventDate");
    print("Navigate to event booking");

    Map<String, dynamic> eventTicket = {};
    eventTicket["BOOKING_ID"] = bookingID;
    eventTicket["EVENT_ID"] = eventId;
    eventTicket["EVENT_NAME"] = eventName;
    eventTicket["EVENT_DISTRICT"] = eventDistrict;
    eventTicket["EVENT_ENTRY_FEE"] = eventEntryFee;
    eventTicket["EVENT_IMAGE"] = eventImage;
    eventTicket["EVENT_PLACE"] = eventPlace;
    eventTicket["TOTAL_TICKET"] = totalTickets;
    eventTicket["SUB_TOTAL"] = subTotal;
    eventTicket["TOTAL_PRICE"] = totalAmount;
    eventTicket["DATE"] = eventDate; // Directly store the formatted date

    // Save booking to Firestore
    try {
      await db
          .collection("USERS")
          .doc(userId)
          .collection("EVENT_TICKET")
          .doc(bookingID)
          .set(eventTicket);
      print("User ID: $userId");
      // Save the same booking in a global BOOKINGS collection
      // await db.collection("BOOKINGS").doc(bookingID).collection("EVENT_BOOKINGS").doc(eventId).set(eventTicket);
      await db.collection("BOOKINGS").doc(bookingID).set(eventTicket);
      print("Booking added successfully");
      // ✅ 3️⃣ Save booking inside the event’s collection for counting
      await db.collection("EVENT").doc(eventId).collection("BOOKINGS").doc(bookingID).set(eventTicket);

      destResetBooking();
    } catch (error) {
      print("Failed to add booking: $error");
    }

    notifyListeners();
  }



  /// get event ticket------------------------------------------------------------------



  List<EventTicketModel> eventTicketList=[];
  Future<void> getEventReceipt(String userId) async {
    isLoading = true; // Indicate loading starts
    notifyListeners();

    try {
      var querySnapshot = await FirebaseFirestore.instance
          .collection("USERS")
          .doc(userId)
          .collection("EVENT_TICKET")
          .orderBy("DATE", descending: true) // Order by date
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        eventTicketList = querySnapshot.docs.map((doc) {
          Map<String, dynamic> ticket = doc.data() as Map<String, dynamic>;
          String travelDate = ticket["DATE"] is Timestamp
              ? (ticket["DATE"] as Timestamp).toDate().toString()
              : ticket["DATE"] ?? "";

          return EventTicketModel(
            doc.id,
            ticket["EVENT_NAME"] ?? "",
            ticket["EVENT_PLACE"] ?? "",
            ticket["EVENT_DISTRICT"] ?? "",
            travelDate,
            int.tryParse(ticket["TOTAL_TICKET"].toString()) ?? 0,
            num.tryParse(ticket["EVENT_ENTRY_FEE"]?.toString() ?? '0') ?? 0.0,
            num.tryParse(ticket["SUB_TOTAL"]?.toString() ?? '0') ?? 0.0,
            num.tryParse(ticket["TOTAL_PRICE"]?.toString() ?? '0') ?? 0.0,
            ticket["EVENT_IMAGE"]??"",
          );
        }).toList();
      } else {
        eventTicketList.clear(); // Clear list if no bookings found
      }
    } catch (error) {
      print("Error fetching tickets: $error");
    }

    isLoading = false; // Indicate loading ends
    notifyListeners();
  }

  ///for favourite destination

  bool isLiked=false;
  void toggleFavorite(String userId, String destId, BuildContext context) {

    // Toggle the like state and update the wishlist accordingly
    isLiked = !isLiked;

    // Get the user document
    db.collection("USERS").doc(userId).get().then((value) {
      if (value.exists) {
        //get the current wishlist

        List<dynamic> currentWishlist = value.data()?["WISHLIST"] ?? [];

        if (currentWishlist.contains(destId)) {
          // if the product is already in the wishlist, remove it
          db.collection("USERS").doc(userId).update({
            "WISHLIST": FieldValue.arrayRemove([destId])
          });
          // Remove from favourite_product field in the product collection

          db.collection("DESTINATION").doc(destId).update({
            "FAVOURITED_USER": FieldValue.arrayRemove([userId])
          });
          // logPro.favProductIdList.remove(productId);

          // value.removeFromWishList(widget.item.productName);
          const snackBar = SnackBar(content: Text("Removed from wishlist"));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
        else {
          // If the product is not in the wishlist, add it
          db.collection("USERS").doc(userId).set({
            "WISHLIST": FieldValue.arrayUnion([destId])
          }, SetOptions(merge: true));

          // Add the product to the FAVOURITED_PRODUCT field in the PRODUCT collection
          db.collection("DESTINATION").doc(destId).set({
            "FAVOURITED_USER": FieldValue.arrayUnion([userId])
          }, SetOptions(merge: true));

          // logPro.favProductIdList.add(productId);
          const snackBar = SnackBar(content: Text("Added to wishlist"));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
        // Add the product to the WISHLIST field in USERS collection


        notifyListeners(); // Notify listeners after the changes
      }
    });
  }

    List<DestinationModel>wishList=[];

  Future<void> getFavorite(String userId) async {
    print("get product function started");
    await db.collection("USERS").doc(userId).get().then((value) async {
      if (value.exists) {
        wishList.clear();
        Map<dynamic, dynamic>wishMap = value.data() as Map;
        List<dynamic> fav = wishMap["WISHLIST"] ?? [];
        for (var ele in fav) {
          String proId = ele.toString();
          await db.collection("DESTINATION").doc(proId).get().then((value) {
            if (value.exists) {
              Map<dynamic, dynamic>map = value.data() as Map;
              wishList.add(DestinationModel(
                  value.id,
                  map["DEST_NAME"].toString()??"",
                  map["DEST_PLACE"].toString()??"",
                  map["DEST_DISTRICT"].toString()??"",
                  map["DEST_BEST_TIME"].toString()??"",
                  map["DEST_IMAGE"].toString()??"",
                  map["DEST_DISCRIPTION"].toString()??"",
                  num.tryParse(map["DEST_ENTRY_FEE"].toString()) ?? 0,
                 map["DEST_SLOT_AVAILABILITY"].toString()??""

              )
              );

            }
          },);
        }
        notifyListeners();
      }
    },);
  }
// carousel-------------------
  int _activeIndex = 0;

  int get activeIndex => _activeIndex;

  void setActiveIndex(int index) {
    _activeIndex = index;
    notifyListeners(); // Notify listeners about the change
  }



  ///for homescreen destination serach
  List<DestinationModel>filteredDestinationList=[];
  // Function to update filtered list
  void updateFilteredDestinations(List<DestinationModel> filteredDestinations) {
    filteredDestinationList = filteredDestinations;
    notifyListeners();
  }
// Function to reset to the full destination list
  void resetToFullList() {
    filteredDestinationList = destinationList;
    notifyListeners();
  }

  ///for event serach
  List<EventsModel>filteredeventList=[];
  // Function to update filtered list
  void updateFilteredEvents(List<EventsModel> filteredEvents) {
    filteredeventList = filteredEvents;
    notifyListeners();
  }
// Function to reset to the full destination list
  void resetToEventFullList() {
    filteredeventList = eventList;
    notifyListeners();
  }


  ///for google map
  Future<void> launchGoogleMaps() async {
    const String googleMapsUrl = "https://www.google.com/maps";

    if (await canLaunch(googleMapsUrl)) {
      await launch(googleMapsUrl);
    } else {
      throw "Could not open the map.";
    }
  }

  ///for cirular progress
  bool isSaving = false;
  void startLoading() {
    isSaving = true;
    notifyListeners();
  }

  void stopLoading() {
    isSaving = false;
    notifyListeners();
  }


 ///  Fetch Total Bookings Count
  int _totalBookings = 0;
  List<Map<String, dynamic>> eventBookingsList = [];

  int get totalEventBookings => _totalBookings;
  List<Map<String, dynamic>> get bookings => eventBookingsList;

  // Fetch total bookings count
  Future<void> fetchTotalBookings(String eventId) async {
    try {
      QuerySnapshot snapshot = await db.collection("EVENT")
          .doc(eventId)
          .collection("BOOKINGS")
          .get();

      _totalBookings = snapshot.size;
      notifyListeners();
    } catch (e) {
      print("Error fetching booking count: $e");
    }
  }
  ///Fetch All Booking Details When Tapped
  Future<List<Map<String, dynamic>>> getEventBookings(String eventId) async {
    List<Map<String, dynamic>> bookingList = [];
    try {
      QuerySnapshot snapshot = await db.collection("EVENT")
          .doc(eventId)
          .collection("BOOKINGS")
          .get();

      for (var doc in snapshot.docs) {
        bookingList.add(doc.data() as Map<String, dynamic>);
      }
      return bookingList;
    } catch (e) {
      print("Error fetching bookings: $e");
      return [];
    }
  }
  List<EventTicketModel>getAllEventBookingsList=[];
  void getAllEventBookings() async {
    QuerySnapshot value = await db.collection("EVENT").doc().collection("BOOKINGS").get();

    if (value.docs.isNotEmpty) {
      getAllEventBookingsList.clear();

      for (var element in value.docs) {
        Map<dynamic, dynamic> eBook = element.data() as Map;
        getAllEventBookingsList.add(EventTicketModel(
          element.id,
          eBook["EVENT_NAME"] ?? "",
          eBook["EVENT_PLACE"] ?? "",
          eBook["EVENT_DISTRICT"] ?? "",
          eBook["EVENT_DATE"] ?? "",
          eBook["TOTAL_TICKET"] ?? 0, // Ensure it's an int
          eBook["EVENT_ENTRY_FEE"] ?? 0,
          eBook["SUB_TOTAL"] ?? 0,
          eBook["TOTAL_PRICE"] ?? 0,
          eBook["EVENT_IMAGE"] ?? "",
        ));
      }
    }

    notifyListeners();  // Ensure UI rebuilds after data update
    print("Total event bookings added into booking collection");
  }


  List<Map<String, dynamic>> _destinationBookings = [];
  List<Map<String, dynamic>> _eventBookings = [];

  List<Map<String, dynamic>> get destinationBookings => _destinationBookings;
  List<Map<String, dynamic>> get eventBookings => _eventBookings;

  /// Fetch all destination bookings
  Future<void> loadDestinationBookings() async {
    try {
      QuerySnapshot querySnapshot = await db.collection("BOOKINGS").get();
      _destinationBookings = querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .where((booking) => booking.containsKey("DEST_ID"))
          .toList();
      notifyListeners();
    } catch (e) {
      print("Error loading destination bookings: $e");
    }
  }

  /// Fetch all event bookings
  Future<void> loadEventBookings() async {
    try {
      QuerySnapshot querySnapshot = await db.collection("BOOKINGS").get();
      _eventBookings = querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .where((booking) => booking.containsKey("EVENT_ID"))
          .toList();
      notifyListeners();
    } catch (e) {
      print("Error loading event bookings: $e");
    }
  }
  // List<EventTicketModel> loadAllEventBookingsList=[];
  // void loadAllEventBookings(){
  //   db.collection("BOOKINGS").get().then((value) {
  //     if(value.docs.isNotEmpty){
  //       print("Came in if loop");
  //       loadAllEventBookingsList.clear();
  //       for(var element in value.docs){
  //         print("Came in for loop");
  //         Map<String, dynamic> ebook = element.data();
  //         String travelDate = ebook["DATE"] is Timestamp
  //             ? (ebook["DATE"] as Timestamp).toDate().toString()
  //             : ebook["DATE"] ?? "";
  //         loadAllEventBookingsList.add(EventTicketModel(
  //           element.id,
  //           ebook["EVENT_NAME"] ?? "",
  //           ebook["EVENT_PLACE"] ?? "",
  //           ebook["EVENT_DISTRICT"] ?? "",
  //           travelDate,
  //           int.tryParse(ebook["TOTAL_TICKET"].toString()) ?? 0,
  //           num.tryParse(ebook["EVENT_ENTRY_FEE"]?.toString() ?? '0') ?? 0.0,
  //           num.tryParse(ebook["SUB_TOTAL"]?.toString() ?? '0') ?? 0.0,
  //           num.tryParse(ebook["TOTAL_PRICE"]?.toString() ?? '0') ?? 0.0,
  //           ebook["EVENT_IMAGE"]??"",
  //         ));
  //       }
  //       notifyListeners();
  //       print("Exit");
  //     }
  //     notifyListeners();
  //   },);
  // }
  //
  //
  // List<DestTicketModel> loadAllDestBookingsList=[];
  // void loadAllDestBookings(){
  //   db.collection("BOOKINGS").get().then((value) {
  //     if(value.docs.isNotEmpty){
  //       print("Came in  dest if loop");
  //       loadAllDestBookingsList.clear();
  //       for(var element in value.docs){
  //         print("Came in  dest for loop");
  //         Map<String, dynamic> ebook = element.data();
  //         String travelDate = ebook["DATE"] is Timestamp
  //             ? (ebook["DATE"] as Timestamp).toDate().toString()
  //             : ebook["DATE"] ?? "";
  //         loadAllDestBookingsList.add(DestTicketModel(
  //           element.id,
  //           ebook["DEST_NAME"] ?? "",
  //           ebook["DEST_PLACE"] ?? "",
  //           ebook["DEST_DISTRICT"] ?? "",
  //           travelDate,
  //           int.tryParse(ebook["TOTAL_TICKET"].toString()) ?? 0,
  //           num.tryParse(ebook["DEST_ENTRY_FEE"]?.toString() ?? '0') ?? 0.0,
  //           num.tryParse(ebook["SUB_TOTAL"]?.toString() ?? '0') ?? 0.0,
  //           num.tryParse(ebook["TOTAL_PRICE"]?.toString() ?? '0') ?? 0.0,
  //           ebook["DEST_IMAGE"]??"",
  //         ));
  //       }
  //       notifyListeners();
  //       print(" dest Exit");
  //     }
  //     notifyListeners();
  //   },);
  // }
  List<EventTicketModel> loadAllEventBookingsList = [];
  List<DestTicketModel> loadAllDestBookingsList = [];

  // Helper method to parse date
  String parseDate(dynamic dateField) {
    if (dateField is Timestamp) {
      return dateField.toDate().toString();
    }
    return dateField?.toString() ?? "";
  }

  // Helper method to parse numeric values
  num parseNumeric(dynamic value, [num defaultValue = 0]) {
    return num.tryParse(value?.toString() ?? '') ?? defaultValue;
  }

  // Load all bookings with type checking
  Future<void> loadAllBookings() async {
    try {
      final snapshot = await db.collection("BOOKINGS").get();

      if (snapshot.docs.isEmpty) return;

      loadAllEventBookingsList.clear();
      loadAllDestBookingsList.clear();

      for (var doc in snapshot.docs) {
        final data = doc.data();
        final bookingType = determineBookingType(data);

        if (bookingType == BookingType.event) {
          loadAllEventBookingsList.add(createEventBooking(doc.id, data));
        } else if (bookingType == BookingType.destination) {
          loadAllDestBookingsList.add(createDestBooking(doc.id, data));
        }
      }

      notifyListeners();
    } catch (e) {
      print('Error loading bookings: $e');
      // Handle error appropriately
    }
  }

  // Helper to determine booking type
  BookingType determineBookingType(Map<String, dynamic> data) {
    // Check for event-specific fields
    if (data.containsKey("EVENT_NAME") && data.containsKey("EVENT_PLACE")) {
      return BookingType.event;
    }
    // Check for destination-specific fields
    if (data.containsKey("DEST_NAME") && data.containsKey("DEST_PLACE")) {
      return BookingType.destination;
    }
    // Default to event if can't determine (you might want to handle this differently)
    return BookingType.event;
  }

  // Create event booking from data
  EventTicketModel createEventBooking(String id, Map<String, dynamic> data) {
    return EventTicketModel(
      id,
      data["EVENT_NAME"] ?? "",
      data["EVENT_PLACE"] ?? "",
      data["EVENT_DISTRICT"] ?? "",
      parseDate(data["DATE"]),
      int.tryParse(data["TOTAL_TICKET"]?.toString() ?? "0") ?? 0,
      parseNumeric(data["EVENT_ENTRY_FEE"]),
      parseNumeric(data["SUB_TOTAL"]),
      parseNumeric(data["TOTAL_PRICE"]),
      data["EVENT_IMAGE"] ?? "",
    );
  }

  // Create destination booking from data
  DestTicketModel createDestBooking(String id, Map<String, dynamic> data) {
    return DestTicketModel(
      id,
      data["DEST_NAME"] ?? "",
      data["DEST_PLACE"] ?? "",
      data["DEST_DISTRICT"] ?? "",
      parseDate(data["DATE"]),
      int.tryParse(data["TOTAL_TICKET"]?.toString() ?? "0") ?? 0,
      parseNumeric(data["DEST_ENTRY_FEE"]),
      parseNumeric(data["SUB_TOTAL"]),
      parseNumeric(data["TOTAL_PRICE"]),
      data["DEST_IMAGE"] ?? "",
    );
  }
}

// First, let's create an enum to distinguish between booking types
enum BookingType {
  event,
  destination
}