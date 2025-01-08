// void getDestReceipt(String userId) {
//   db
//       .collection("USERS")
//       .doc(userId)
//       .collection("DEST_TICKET")
//       .get()
//       .then((value) {
//     if (value.docs.isNotEmpty) {
//       destTicketList.clear(); // Clear the old data to avoid duplication
//       for (var element in value.docs) {
//         Map<dynamic, dynamic> ticket = element.data();
//
//         String travelDate = "";
//         if (ticket["DATE"] is Timestamp) {
//           travelDate = (ticket["DATE"] as Timestamp).toDate().toString();
//         } else {
//           travelDate = ticket["DATE"] ?? "";
//         }
//
//         // Safely parse the ticket values
//         int totalTickets = int.tryParse(ticket["TOTAL_TICKET"].toString()) ?? 0;
//         num entryFee =
//             num.tryParse(ticket["DEST_ENTRY_FEE"]?.toString() ?? '0') ?? 0.0;
//         num subTotal =
//             num.tryParse(ticket["SUB_TOTAL"]?.toString() ?? '0') ?? 0.0;
//         num totalPrice =
//             num.tryParse(ticket["TOTAL_PRICE"]?.toString() ?? '0') ?? 0.0;
//
//         destTicketList.add(DestTicketModel(
//           element.id,
//           ticket["DEST_NAME"] ?? "",
//           ticket["DEST_PLACE"] ?? "",
//           ticket["DEST_DISTRICT"] ?? "",
//           travelDate,
//           totalTickets,
//           entryFee,
//           subTotal,
//           totalPrice,
//         ));
//       }
//     }
//   }).catchError((error) {
//     print("Failed to fetch booking data: $error");
//   });
// }



// ----------------------------------confirm--------------------

//
// class ConfirmBooking extends StatelessWidget {
//   final String userId,
//       bookingId,
//       Name,
//       Place,
//       District,
//       EntryFee,
//       Image;
//   String from;
//   final int selectedCount;
//
//   ConfirmBooking({
//     super.key,
//     required this.userId,
//     required this.bookingId,
//
//     required this.Name,
//     required this.Place,
//     required this.District,
//     required this.EntryFee,
//     required this.Image,
//     required this.selectedCount,
//     required this.from
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final num unitPrice = num.tryParse(EntryFee) ?? 0;
//     final num totalFee = unitPrice * selectedCount;
//     final num gst = totalFee * 0.02;
//     final num totalAmount = totalFee + gst;
//
//     final double height = MediaQuery.of(context).size.height;
//     final double width = MediaQuery.of(context).size.width;
//
//     // ///Dynamically determine the bookingId based on 'from'
//     // final String bookingId=from=="Destination"?destId:eventID;
//
//     return Scaffold(
//       backgroundColor: const Color(0xffe6f7f5),
//       appBar: AppBar(
//         title: Text(from=="Destination"?"Confirm Destination Booking":"Confirm Event Booking", style: TextStyle(color: Colors.white)),
//         // centerTitle: true,
//         backgroundColor: Colors.black,
//       ),
//       body: Column(
//         children: [
//           const SizedBox(height: 10),
//           _BookingDetails(bookingId:bookingId),
//           // _BookingDetails(
//           //   name: Name,
//           //   place: Place,
//           //   district: District,
//           //   selectedCount: selectedCount,
//           //   isEventBooking: from=="Event",
//           //   bookingId: '',
//           // ),
//           _CancellationPolicy(height: height, width: width),
//           _PaymentSummary(
//             height: height,
//             width: width,
//             unitPrice: unitPrice,
//             totalFee: totalFee,
//             gst: gst,
//             totalAmount: totalAmount,
//           ),
//           _ConsentText(height: height, width: width),
//           const Spacer(),
//           _BottomBar(
//             width: width,
//             totalAmount: totalAmount,
//             onContinue: () => _handleContinue(context, totalFee, totalAmount),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _handleContinue(BuildContext context, num totalFee, num totalAmount) {
//     final selectedDate = context.read<MainProvider>().selectedDate;
//     if (selectedDate == null&&from=="Destination") {
//       showSnackBarAlert(context, "Please select a date before proceeding");
//     } else {
//       callNext(
//         context,
//         PaymentScreen(
//           userId: userId,
//           bookingId: bookingId,
//           Name: Name,
//           Place: Place,
//           District: District,
//           EntryFee: EntryFee,
//           destImage: Image,
//           selectedCount: selectedCount,
//           totalAmount: totalAmount,
//           subTotal: totalFee,
//         ),
//       );
//     }
//   }
// }
// class _BookingDetails extends StatelessWidget {
//
//   String bookingId;
//   final bool isEventBooking;
//
//
//   _BookingDetails({
//     required this.bookingId,
//     this.isEventBooking=false,// Defaults to false (destination booking)
//
//   });
//
//   Future<Map<String,dynamic>> _fetchBookingDetails()async{
//     try{
//       final  collectionName=isEventBooking?"EVENT":"DESTINATION";
//       final snapshot=await FirebaseFirestore.instance.collection(collectionName).doc(bookingId).get();
//
//
//       if(snapshot.exists){
//         return snapshot.data()!;
//       }
//       else{
//         throw Exception("Booking not found");
//       }
//     }
//     catch(e){
//       throw Exception("Error fetching booking details : $e");
//     }
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<Map<String,dynamic>>(
//         future: _fetchBookingDetails(),
//         builder: (context,snapshot) {
//
//           if(snapshot.connectionState==ConnectionState.waiting){
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//
//           if(snapshot.hasError){
//             return Center(
//               child: Text("Error :${snapshot.error}"),
//             );
//           }
//
//           if(!snapshot.hasError||snapshot.data==null){
//             return const Center(
//               child:
//               Text("No booking details available"),
//             );
//           }
//
//           final bookingData=snapshot.data!;
//           final name=isEventBooking
//               ?bookingData["EVENT_NAME"]??"Unknown"
//               :bookingData["DEST_NAME"]??"UnKnown";
//           final place = isEventBooking
//               ? bookingData['EVENT_PLACE'] ?? 'Unknown'
//               : bookingData['DEST_PLACE'] ?? 'Unknown';
//           final district = isEventBooking
//               ? bookingData['EVENT_DISTRICT'] ?? 'Unknown'
//               : bookingData['DEST_DISTRICT'] ?? 'Unknown';
//           final selectedCount = isEventBooking
//               ? bookingData['EVENT_SLOT_AVAILABILITY'] ?? 0
//               : bookingData['DEST_SLOT_AVAILABILITY'] ?? 0;
//           final eventDate = isEventBooking
//               ? (bookingData['EVENT_DATE'] as Timestamp?)?.toDate()
//               : null;
//
//           return Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8.0),
//             child: Container(
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.grey.shade200),
//                 color: Colors.white,
//                 borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
//               ),
//               padding: const EdgeInsets.all(15),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(name),
//                       RichText(
//                           text: TextSpan(
//                               text: "Total members:",
//                               style: TextStyle(fontWeight: FontWeight.w600,color: Colors.black),
//                               children: [
//                                 TextSpan(
//                                   text: " $selectedCount",style: TextStyle(fontWeight: FontWeight.bold,color: cstRed),)
//
//                               ]
//                           )
//                       ),
//
//                     ],
//                   ),
//                   Text("$place, $district"),
//
//                   SizedBox(height: 5,),
//                   ///for event booking
//                   if(isEventBooking && eventDate!=null)
//                     Row(
//                       children: [
//                         Icon(Icons.calendar_today,size: 18,),
//                         SizedBox(width: 5,),
//                         RichText(
//                             text: TextSpan(
//                                 text: "Event Date:",
//                                 style: TextStyle(fontWeight: FontWeight.w600,color: Colors.black),
//                                 children: [
//                                   TextSpan(
//                                     text: "${DateFormat("EEEE,MMMM d,y").format(DateTime.now())}",style: TextStyle(fontWeight: FontWeight.bold,color: cstRed),)
//
//                                 ]
//                             )
//                         ),
//                         // Text("Event Date: ${DateFormat("dd-MM-yyyy").format(DateTime.now())},",style: TextStyle(fontSize: 14,color: cstRed,fontWeight: FontWeight.bold),),
//                       ],
//                     ),
//
//                   ///for destination booking
//
//
//                   if(!isEventBooking)
//
//                     Consumer<MainProvider>(
//                       builder: (context, dValue, child) {
//                         final selectedDate=dValue.selectedDate;
//
//                         return Row(
//                           children: [
//                             Icon(Icons.calendar_today),
//                             GestureDetector(
//                               onTap: () async{
//                                 DateTime? pickedDate=await showDatePicker(
//                                   context: context,
//                                   initialDate: DateTime.now(),
//                                   firstDate: DateTime.now(),
//                                   lastDate: DateTime(2100),
//                                 );
//
//                                 if(pickedDate!=null){
//                                   dValue.setSelectedDate(pickedDate);
//                                 }
//                               },
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                     color: Colors.yellow
//                                 ),
//                                 child: Text(
//                                   selectedDate!=null
//                                       ?DateFormat('dd-MM-yyy').format(selectedDate)
//                                       :"Select Date",
//                                   style: TextStyle(fontSize: 16,color: Colors.black),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         );
//
//                         //
//                         // if (isEventBooking && eventDate != null) {
//                         //   formattedDate = DateFormat('dd-MM-yyyy').format(eventDate!);
//                         // } else if (!isEventBooking) {
//                         //   final selectedDate = dValue.selectedDate;
//                         //   formattedDate = selectedDate != null
//                         //       ? DateFormat('dd-MM-yyyy').format(selectedDate)
//                         //       : "Select Date";
//                         // } else {
//                         //   formattedDate = "No date available";
//                         // }
//                         //
//                         // return Column(
//                         //   crossAxisAlignment: CrossAxisAlignment.start,
//                         //   children: [
//                         //     Row(
//                         //       children: [
//                         //         const Icon(Icons.calendar_today, size: 20, color: Colors.blue),
//                         //         const SizedBox(width: 10),
//                         //         Text(
//                         //           formattedDate,
//                         //           style: const TextStyle(fontSize: 16, color: Colors.blue),
//                         //         ),
//                         //       ],
//                         //     ),
//                         //     const SizedBox(height: 10),
//                         //     // Show calendar picker only for destination bookings
//                         //     if (!isEventBooking)
//                         //       GestureDetector(
//                         //         onTap: () async {
//                         //           DateTime? pickedDate = await showDatePicker(
//                         //             context: context,
//                         //             initialDate: DateTime.now(),
//                         //             firstDate: DateTime.now(),
//                         //             lastDate: DateTime(2100),
//                         //           );
//                         //           if (pickedDate != null) {
//                         //             dValue.setSelectedDate(pickedDate);
//                         //           }
//                         //         },
//                         //         child: Container(
//                         //           padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
//                         //           decoration: BoxDecoration(
//                         //             border: Border.all(color: Colors.blue),
//                         //             borderRadius: BorderRadius.circular(5),
//                         //           ),
//                         //           child: const Text(
//                         //             "Select Date",
//                         //             style: TextStyle(fontSize: 16, color: Colors.blue),
//                         //           ),
//                         //         ),
//                         //       ),
//                         //   ],
//                         // );
//                       },
//                     ),
//                 ],
//               ),
//             ),
//           );
//         }
//     );
//   }
// }