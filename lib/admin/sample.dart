// int selectedIndex = -1;
// String destFee = '0'; // Default fee, which will be updated dynamically
//
// // Method to select a member count
// void selectIndex(int index) {
//   selectedIndex = index;
//   notifyListeners(); // Notify listeners to rebuild the UI
// }
//
// // Method to get selected count number
// int get selectedCount =>
//     selectedIndex + 1; // Because index starts from 0, but count starts from 1
//
// // Method to set the destination fee after fetching from Firestore
// void setDestFee(String fee) {
//   destFee = fee;
//   notifyListeners(); // Notify listeners when fee is updated
// }
//
// // Method to get the total fee
// double get totalFee {
//   double entryFee = double.tryParse(destFee) ?? 0.0;
//   return selectedCount * entryFee;
// }
//
// // Method to get GST (assuming GST is 2%)
// double get gst {
//   return totalFee * 0.02; // 2% GST
// }
//
// // Method to get the final total amount
// double get totalAmount {
//   return totalFee + gst;
// }
//
// //for reseting ticket booing
//
// void destResetBooking() {
//   _selectedDate = null;
//   selectedIndex = -1;
//   destFee = '0';
//   notifyListeners();
// }
//
// void eventBooking(
//     String userId,
//     String eventId,
//     String eventName,
//     String eventDistrict,
//     String eventPlace,
//     String eventEntryFee,
//     num totalTickets,
//     num totalAmount,
//     num subTotal,
//     String eventImage,) async {
//   // Check if the userId is empty. If it is, we cannot proceed with the booking
//   if (userId.isEmpty) {
//     print("User id is missing");
//     return;
//   }
//
//   // Check if selectedDate is null. If it is, we cannot proceed without a date
//   if (selectedDate == null) {
//     print("Invalid date selected");
//     return;
//   }
//   String booikngID = DateTime.now().microsecondsSinceEpoch.toString();
//   print("Booking details:");
//   print( "User ID:$userId,Destination Id: $eventId,Selected date :$selectedDate");
//   print("navigate to destination booking");
//
//
//   Map<String, dynamic> eventTicket = Map();
//   eventTicket["BOOKING_ID"] = booikngID;
//   eventTicket["DEST_ID"] = eventId;
//   eventTicket["DEST_NAME"] = eventName;
//   eventTicket["DEST_DISTRICT"] = eventDistrict;
//   eventTicket["DEST_ENTRY_FEE"] = eventEntryFee;
//   eventTicket["DEST_IMAGE"] = eventImage;
//   eventTicket["DEST_PLACE"] = eventPlace;
//   eventTicket["TOTAL_TICKET"] = totalTickets;
//   eventTicket["SUB_TOTAL"] = subTotal;
//   eventTicket["TOTAL_PRICE"] = totalAmount;
//   eventTicket["DATE"] = selectedDate;
//
//
//   //save booking to firestore
//   try {
//     await db .collection("USERS").doc(userId)
//         .collection("EVENT_TICKET") .doc(booikngID)
//         .set(eventTicket);
//     print("userid: $userId");
//
//     print("Booking added successfully");
//
//     destResetBooking();
//
//
//
//   } catch (error) {
//     print("Failed to add booking : $error");
//   }
//   notifyListeners();
// }
//
//
//
//
// // import 'package:flutter/material.dart';
// // import 'package:lottie/lottie.dart';
// // import 'package:provider/provider.dart';
// //
// // import '../constants/call_functions.dart';
// // import '../provider/mainProvider.dart';
// // import '../user/confirmBooking.dart';
// // //
// // void showBottomSheet(BuildContext context, String bookingType,) {
// //   var height = MediaQuery.of(context).size.height;
// //   var width = MediaQuery.of(context).size.width;
// //
// //   showModalBottomSheet(
// //     backgroundColor: Colors.white,
// //     shape: RoundedRectangleBorder(
// //       borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
// //     ),
// //     isScrollControlled: true,
// //     context: context,
// //     builder: (context) {
// //       return Padding(
// //         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
// //         child: Column(
// //           mainAxisSize: MainAxisSize.min,
// //           children: [
// //             SizedBox(height: 10),
// //             Text(
// //               "How many members ?",
// //               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
// //             ),
// //             SizedBox(height: 10),
// //             Lottie.asset("assets/lottie/travel.json", height: 100, width: width),
// //             SizedBox(height: 10),
// //             Center(
// //               child: Column(
// //                 mainAxisAlignment: MainAxisAlignment.center,
// //                 children: [
// //                   Container(
// //                     height: 50, // Adjust the height of the row container
// //                     child: Consumer<MainProvider>(
// //                       builder: (context, dvalue, child) {
// //                         return ListView.builder(
// //                           scrollDirection: Axis.horizontal,
// //                           itemBuilder: (context, index) {
// //                             final selectedIndex = dvalue.selectedIndex;
// //
// //                             return GestureDetector(
// //                               onTap: () {
// //                                 dvalue.selectIndex(index);
// //                                 print("Selected: ${index + 1} seats");
// //                               },
// //                               child: Container(
// //                                 height: 40,
// //                                 width: 50,
// //                                 margin: const EdgeInsets.symmetric(horizontal: 4),
// //                                 padding: const EdgeInsets.all(10),
// //                                 decoration: BoxDecoration(
// //                                   color: selectedIndex == index
// //                                       ? Colors.redAccent
// //                                       : Colors.grey[200],
// //                                   borderRadius: BorderRadius.circular(50),
// //                                 ),
// //                                 child: Center(
// //                                   child: Text(
// //                                     "${index + 1}",
// //                                     style: TextStyle(
// //                                       color: selectedIndex == index
// //                                           ? Colors.white
// //                                           : Colors.black,
// //                                       fontWeight: FontWeight.bold,
// //                                     ),
// //                                   ),
// //                                 ),
// //                               ),
// //                             );
// //                           },
// //                         );
// //                       },
// //                     ),
// //                   ),
// //                   SizedBox(height: 20),
// //                   Consumer<MainProvider>(
// //                     builder: (context, dvalue, child) {
// //                       return ElevatedButton(
// //                         onPressed: dvalue.selectedIndex == -1
// //                             ? null // Button disabled when no number is selected
// //                             : () {
// //                           // Proceed with booking
// //                           print("Navigate to terms and conditions userId");
// //                           Terms_condition(context, dvalue.selectedCount, bookingType);
// //                         },
// //                         style: ElevatedButton.styleFrom(
// //                           minimumSize: Size(double.infinity, 50),
// //                           backgroundColor: dvalue.selectedIndex == -1
// //                               ? Colors.grey // Disabled button color
// //                               : Colors.redAccent, // Active button color
// //                         ),
// //                         child: Text(
// //                           "Select",
// //                           style: TextStyle(
// //                             fontSize: 16,
// //                             fontWeight: FontWeight.bold,
// //                             color: dvalue.selectedIndex == -1
// //                                 ? Colors.black54 // Disabled text color
// //                                 : Colors.white, // Active text color
// //                           ),
// //                         ),
// //                       );
// //                     },
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ],
// //         ),
// //       );
// //     },
// //   );
// // }
// //
// //
// //
// // void Terms_condition(BuildContext context, num selectedCount, String bookingType) {
// //   num totalEntryFee;
// //
// //   if (bookingType == 'destination') {
// //     totalEntryFee = item.destEntryFee * selectedCount; // Destination booking fee
// //   } else {
// //     totalEntryFee = eventItem.entryFee * selectedCount; // Event booking fee
// //   }
// //
// //   showModalBottomSheet(
// //     context: context,
// //     isScrollControlled: true,
// //     backgroundColor: Colors.transparent,
// //     builder: (context) {
// //       return Container(
// //         width: MediaQuery.of(context).size.width,
// //         decoration: BoxDecoration(
// //           color: Colors.white,
// //           borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
// //         ),
// //         child: Padding(
// //           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
// //           child: Column(
// //             mainAxisSize: MainAxisSize.min,
// //             children: [
// //               SizedBox(height: 10),
// //               Text(
// //                 "Terms & conditions",
// //                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
// //               ),
// //               SizedBox(height: 10),
// //               Text(
// //                 "1. All bookings are subject to availability and confirmation.\n"
// //                     "2. Payments must be completed at the time of booking.\n"
// //                     "3. Once a booking is confirmed, it cannot be canceled or refunded unless explicitly mentioned.\n"
// //                     "4. Users are responsible for ensuring the accuracy of the details entered during the booking process.\n"
// //                     "5. TravelMate is not liable for any issues caused by third-party service providers.\n"
// //                     "6. Tickets and bookings are non-transferable unless stated otherwise.\n"
// //                     "7. Event timings, availability, and details are subject to changes by the organizer without prior notice.\n"
// //                     "8. TravelMate reserves the right to cancel or modify a booking if fraud or misuse is detected.\n"
// //                     "9. Any disputes arising from bookings must be addressed as per the laws of Kerala.\n"
// //                     "10. By proceeding, you agree to comply with these terms and conditions.",
// //               ),
// //               SizedBox(height: 20),
// //               ElevatedButton(
// //                 style: ElevatedButton.styleFrom(
// //                   backgroundColor: Colors.red,
// //                   minimumSize: Size(double.infinity, 50),
// //                 ),
// //                 onPressed: () {
// //                   print("Navigate to confirm booking");
// //
// //                   if (bookingType == 'destination') {
// //                     callNext(context, ConfirmBooking(
// //                       userId: userId,
// //                       destId: item.destId,
// //                       destName: item.destName,
// //                       destPlace: item.destPlace,
// //                       destDistrict: item.destDistrict,
// //                       destEntryFee: totalEntryFee.toString(),
// //                       selectedCount: selectedCount.toInt(),
// //                       destImage: item.destImage,
// //                     ));
// //                   } else {
// //                     callNext(context, ConfirmBooking(
// //                       userId: userId,
// //                       eventId: eventItem.eventId,
// //                       eventName: eventItem.eventName,
// //                       eventDate: eventItem.eventDate,
// //                       eventEntryFee: totalEntryFee.toString(),
// //                       selectedCount: selectedCount.toInt(),
// //                       eventImage: eventItem.eventImage,
// //                     ));
// //                   }
// //                 },
// //                 child: Text("Ok", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
// //               ),
// //             ],
// //           ),
// //         ),
// //       );
// //     },
// //   );
// // }
// //
// //
// //
// //
// //
// //
// //
// //
// //
// // // import 'package:flutter/material.dart';
// // //
// // // class SwitchInRowExample extends StatefulWidget {
// // //   @override
// // //   _SwitchInRowExampleState createState() => _SwitchInRowExampleState();
// // // }
// // //
// // // class _SwitchInRowExampleState extends State<SwitchInRowExample> {
// // //   bool isSwitched = false;
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         title: Text("Switch with Status"),
// // //       ),
// // //       body: Padding(
// // //         padding: const EdgeInsets.only(top: 10, left: 11),
// // //         child: Row(
// // //           // mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //           children: [
// // //             Row(
// // //               children: [
// // //                 Icon(
// // //                   Icons.confirmation_num_outlined,
// // //                   color: Colors.brown,
// // //                 ),
// // //                 Padding(
// // //                   padding: const EdgeInsets.all(14.0),
// // //                   child: Text(
// // //                     "Slot Availability",
// // //                     style: TextStyle(
// // //                       color: Colors.white,
// // //                       fontSize: 18,
// // //                       fontFamily: "baloo",
// // //                     ),
// // //                   ),
// // //                 ),
// // //               ],
// // //             ),
// // //             Row(
// // //               children: [
// // //                 Switch(
// // //                   value: isSwitched,
// // //                   onChanged: (value) {
// // //                     setState(() {
// // //                       isSwitched = value;
// // //                     });
// // //                   },
// // //                   activeColor: Colors.green,
// // //                   inactiveThumbColor: Colors.grey,
// // //                   inactiveTrackColor: Colors.white,
// // //                 ),
// // //                 Text(
// // //                   isSwitched ? "Available" : "Not Available",
// // //                   style: TextStyle(
// // //                     color: isSwitched ? Colors.green : Colors.red,
// // //                     fontSize: 16,
// // //                   ),
// // //                 ),
// // //               ],
// // //             ),
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }