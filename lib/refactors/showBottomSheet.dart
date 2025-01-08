// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';
// import 'package:provider/provider.dart';
// import 'package:travelmate/constants/call_functions.dart';
// import 'package:travelmate/models/adminModels.dart';
//
// import '../admin/sample.dart';
// import '../provider/mainProvider.dart';
//
// // void selectCountBottomSheet(BuildContext context, String from,String userId) {
// //   MainProvider mpro=Provider.of<MainProvider>(context,listen: false);
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
// //               "How many members?",
// //               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
// //             ),
// //             SizedBox(height: 10),
// //             Lottie.asset("assets/lottie/travel.json", height: 100, width: width),
// //
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
// //                       var destItem=dvalue.destTicketList[dvalue.selectedIndex];
// //                       var eventItem=dvalue.eventTicketList[dvalue.selectedIndex];
// //                       return ElevatedButton(
// //                         onPressed: dvalue.selectedIndex == -1
// //                             ? null // Button disabled when no number is selected
// //                             : () {
// //                           // Handle navigation based on the "from" parameter
// //                           if (from == "DestinationScreen") {
// //                             // Navigate to Destination booking screen
// //                             print("Navigating to destination booking with ${dvalue.selectedCount} members.");
// //                             // Call a method for destination booking
// //                             mpro.destinationBooking(
// //                                 userId,
// //                                 destItem.bookingId.toString(),
// //                                 destItem.destName.toString(),
// //                                 destItem.destDistrict.toString(),
// //                                 destItem.destPlace.toString(),
// //                                 destItem.unitPrice.toString(),  // Convert num to String
// //                                 destItem.totalMembers,
// //                                 destItem.totalAmount,
// //                                 destItem.subTotal,
// //                                 destItem.destImage
// //                             );
// //                             // destinationBooking(context, dvalue.selectedCount);
// //                           } else if (from == "EventDetailScreen") {
// //                             // Navigate to Event booking screen
// //                             print("Navigating to event booking with ${dvalue.selectedCount} members.");
// //                             // Call a method for event booking
// //                             mpro.eventBooking(
// //                                 userId,
// //                                 eventItem.bookingId,
// //                                 eventItem.eventName,
// //                                 eventItem.eventDistrict,
// //                                 eventItem.eventPlace,
// //                                 eventItem.unitPrice.toString(),
// //                                 eventItem.totalMembers,
// //                                 eventItem.totalAmount,
// //                                 eventItem.subTotal,
// //                                 eventItem.eventImage
// //                             );
// //                           }
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
// // void selectCountBottomSheet(BuildContext context, String from, String userId) {
// //   MainProvider mpro = Provider.of<MainProvider>(context, listen: false);
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
// //               "How many members?",
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
// //                     height: 50,
// //                     child: Consumer<MainProvider>(
// //                       builder: (context, dvalue, child) {
// //                         return ListView.builder(
// //                           scrollDirection: Axis.horizontal,
// //                           itemCount: 100, // Define the number of options
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
// //                       final isButtonEnabled=dvalue.selectedIndex!=-1;
// //
// //                         return GestureDetector(
// //                           onTap: () {
// //                             showTermsConditionBottomSheet(context: context, selectedCount: selectedCount, userId: userId, destItem: destItem, eventItem: eventItem, onConfirm: onConfirm);
// //                           },
// //                           child: ElevatedButton(
// //                             onPressed: isButtonEnabled?(){
// //                               if (from == "DestinationScreen") {
// //                                 print(
// //                                     "Navigating to destination booking with ${dvalue.selectedCount} members.");
// //                                final destItem=dvalue.destTicketList[dvalue.selectedIndex];
// //                                 mpro.destinationBooking(
// //                                   userId,
// //                                   destItem.bookingId.toString(),
// //                                   destItem.destName.toString(),
// //                                   destItem.destDistrict.toString(),
// //                                   destItem.destPlace.toString(),
// //                                   destItem.unitPrice.toString(),
// //                                   destItem.totalMembers,
// //                                   destItem.totalAmount,
// //                                   destItem.subTotal,
// //                                   destItem.destImage,
// //                                 );
// //                               }
// //                               else if (from == "EventDetailScreen") {
// //                                 print(
// //                                     "Navigating to event booking with ${dvalue
// //                                         .selectedCount} members.");
// //                                 final eventItem=dvalue.eventTicketList[dvalue.selectedIndex];
// //                                 mpro.eventBooking(
// //                                   userId,
// //                                   eventItem.bookingId,
// //                                   eventItem.eventName,
// //                                   eventItem.eventDistrict,
// //                                   eventItem.eventPlace,
// //                                   eventItem.unitPrice.toString(),
// //                                   eventItem.totalMembers,
// //                                   eventItem.totalAmount,
// //                                   eventItem.subTotal,
// //                                   eventItem.eventImage,
// //                                 );
// //                               }
// //                             }:null,// Disable button if no selection is made
// //                             style: ElevatedButton.styleFrom(
// //                               minimumSize: Size(double.infinity, 50),
// //                               backgroundColor: isButtonEnabled?Colors.red:Colors.grey, // Disabled button color
// //                             ),
// //                             child: Text(
// //                               "Select",
// //                               style: TextStyle(
// //                                 fontSize: 16,
// //                                 fontWeight: FontWeight.bold,
// //                                 color: isButtonEnabled?Colors.white:Colors.black54,
// //                               ),
// //                             ),
// //                           ),
// //                         );
// //                     },
// //                   ),
// //
// //                 ],
// //               ),
// //             ),
// //           ],
// //         ),
// //       );
// //     },
// //   );
// // }
// void selectCountBottomSheet(BuildContext context, String from, String userId,dynamic destItem,dynamic eventItem) {
//   MainProvider mpro = Provider.of<MainProvider>(context, listen: false);
//   var height = MediaQuery.of(context).size.height;
//   var width = MediaQuery.of(context).size.width;
//
//   showModalBottomSheet(
//     backgroundColor: Colors.white,
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//     ),
//     isScrollControlled: true,
//     context: context,
//     builder: (context) {
//       return Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             SizedBox(height: 10),
//             Text(
//               "How many members?",
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 10),
//             Lottie.asset("assets/lottie/travel.json", height: 100, width: width),
//             SizedBox(height: 10),
//             Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Container(
//                     height: 50,
//                     child: Consumer<MainProvider>(
//                       builder: (context, dvalue, child) {
//                         return ListView.builder(
//                           scrollDirection: Axis.horizontal,
//                           itemCount: 100, // Define the number of options
//                           itemBuilder: (context, index) {
//                             final selectedIndex = dvalue.selectedIndex;
//
//                             return GestureDetector(
//                               onTap: () {
//                                 dvalue.selectIndex(index);
//                                 print("Selected: ${index + 1} seats");
//                               },
//                               child: Container(
//                                 height: 40,
//                                 width: 50,
//                                 margin: const EdgeInsets.symmetric(horizontal: 4),
//                                 padding: const EdgeInsets.all(10),
//                                 decoration: BoxDecoration(
//                                   color: selectedIndex == index
//                                       ? Colors.redAccent
//                                       : Colors.grey[200],
//                                   borderRadius: BorderRadius.circular(50),
//                                 ),
//                                 child: Center(
//                                   child: Text(
//                                     "${index + 1}",
//                                     style: TextStyle(
//                                       color: selectedIndex == index
//                                           ? Colors.white
//                                           : Colors.black,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             );
//                           },
//                         );
//                       },
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   Consumer<MainProvider>(
//                     builder: (context, dvalue, child) {
//                       final isButtonEnabled = dvalue.selectedIndex != -1;
//
//                       return ElevatedButton(
//                         onPressed: isButtonEnabled ? () {
//                           // Your custom logic on button press
//                           print("Booking details are being processed.");
//                           ///navigate to the terms and conditions bottom sheet
//
//                           finish(context);///close the current bottom sheet
//
//                           showTermsConditionBottomSheet(
//                               context: context,
//                               selectedCount: dvalue.selectedCount,
//                               userId: userId,
//                             from: from,
//                             destItem: from=="Destination"?destItem:null,
//                             eventItem:  from=="Event"?eventItem:null
//
//
//                           );
//                         } : null, // Disable button if no selection is made
//                         style: ElevatedButton.styleFrom(
//                           minimumSize: Size(double.infinity, 50),
//                           backgroundColor: isButtonEnabled ? Colors.red : Colors.grey, // Disabled button color
//                         ),
//                         child: Text(
//                           "Select",
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                             color: isButtonEnabled ? Colors.white : Colors.black54,
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       );
//     },
//   );
// }
//
//
//
// void showTermsConditionBottomSheet({
//   required BuildContext context,
//   required num selectedCount,
//   required String userId,
//   required String from,
//   dynamic  destItem,///Destination object(nullable)
//   dynamic eventItem
//
//
// }) {
//   // Calculate the total entry fee dynamically
//
//   num totalEntryFee=0;
//
//   if(from=="Destination" && destItem!=null){
//     totalEntryFee = (num.tryParse(destItem['DEST_ENTRY_FEE'].toString() )?? 0) * selectedCount;
//   }else if (from=="Event" && eventItem!=null){
//     totalEntryFee=(num.tryParse(eventItem['EVENT_ENTRY_FEE'].toString())??0)*selectedCount;
//   }
//
//   print("Total entry fee: $totalEntryFee");
//
//   showModalBottomSheet(
//     context: context,
//     isScrollControlled: true,
//     backgroundColor: Colors.transparent,
//     builder: (context) {
//       return Container(
//         width: MediaQuery.of(context).size.width, // Full screen width
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//           child: Column(
//             mainAxisSize: MainAxisSize.min, // Adjust to content height
//             children: [
//               SizedBox(height: 10),
//               Text(
//                 "Terms & conditions",
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 10),
//               Text(
//                 "1. All bookings are subject to availability and confirmation.\n"
//                     "2. Payments must be completed at the time of booking.\n"
//                     "3. Once a booking is confirmed, it cannot be canceled or refunded unless explicitly mentioned.\n"
//                     "4. Users are responsible for ensuring the accuracy of the details entered during the booking process.\n"
//                     "5. TravelMate is not liable for any issues caused by third-party service providers.\n"
//                     "6. Tickets and bookings are non-transferable unless stated otherwise.\n"
//                     "7. Event timings, availability, and details are subject to changes by the organizer without prior notice.\n"
//                     "8. TravelMate reserves the right to cancel or modify a booking if fraud or misuse is detected.\n"
//                     "9. Any disputes arising from bookings must be addressed as per the laws of Kerala.\n"
//                     "10. By proceeding, you agree to comply with these terms and conditions.",
//                 style: TextStyle(fontSize: 14),
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.red,
//                   minimumSize: Size(double.infinity, 50),
//                 ),
//                 onPressed: () {
//                   finish(context);
//                   // onConfirm(); // Call the onConfirm function passed from the parent screen
//                 },
//                 child: Text(
//                   "Ok",
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//     },
//   );
// }
