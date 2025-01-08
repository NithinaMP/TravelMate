// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import '../constants/call_functions.dart';
// import '../constants/globalMethods.dart';
// import '../provider/mainProvider.dart';
// import '../user/payment.dart';
//
//
// class ConfirmBooking extends StatelessWidget {
//   final String userId,
//       destId,
//       Name,
//       Place,
//       District,
//       EntryFee,
//       Image;
//   final int selectedCount;
//
//   const ConfirmBooking({
//     super.key,
//     required this.userId,
//     required this.destId,
//     required this.Name,
//     required this.Place,
//     required this.District,
//     required this.EntryFee,
//     required this.Image,
//     required this.selectedCount,
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
//     return Scaffold(
//       backgroundColor: const Color(0xffe6f7f5),
//       appBar: AppBar(
//         title: const Text("Confirm booking", style: TextStyle(color: Colors.white)),
//         centerTitle: true,
//         backgroundColor: Colors.black,
//       ),
//       body: Column(
//         children: [
//           const SizedBox(height: 10),
//           _BookingDetails(
//             destName: Name,
//             destPlace: Place,
//             destDistrict: District,
//             selectedCount: selectedCount,
//           ),
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
//     if (selectedDate == null) {
//       showSnackBarAlert(context, "Please select a date before proceeding");
//     } else {
//       callNext(
//         context,
//         PaymentScreen(
//           userId: userId,
//           destId: destId,
//           destName: Name,
//           destPlace: Place,
//           destDistrict: District,
//           destEntryFee: EntryFee,
//           destImage: Image,
//           selectedCount: selectedCount,
//           totalAmount: totalAmount,
//           subTotal: totalFee,
//         ),
//       );
//     }
//   }
// }
//
// // Widgets Broken into Reusable Components
//
// class _BookingDetails extends StatelessWidget {
//   final String destName, destPlace, destDistrict;
//   final int selectedCount;
//
//   const _BookingDetails({
//     required this.destName,
//     required this.destPlace,
//     required this.destDistrict,
//     required this.selectedCount,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 8.0),
//       child: Container(
//         decoration: BoxDecoration(
//           border: Border.all(color: Colors.grey.shade200),
//           color: Colors.white,
//           borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
//         ),
//         padding: const EdgeInsets.all(15),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(destName),
//                 Text("Total members: $selectedCount"),
//               ],
//             ),
//             Text("$destPlace, $destDistrict"),
//             Consumer<MainProvider>(
//               builder: (context, dValue, child) {
//                 final selectedDate = dValue.selectedDate;
//                 String formattedDate = selectedDate != null
//                     ? DateFormat('dd-MM-yyyy').format(selectedDate)
//                     : "Select Date";
//
//                 return GestureDetector(
//                   onTap: () async {
//                     DateTime? pickedDate = await showDatePicker(
//                       context: context,
//                       initialDate: DateTime.now(),
//                       firstDate: DateTime.now(),
//                       lastDate: DateTime(2100),
//                     );
//                     if (pickedDate != null) {
//                       dValue.setSelectedDate(pickedDate);
//                     }
//                   },
//                   child: Row(
//                     children: [
//                       const Icon(Icons.calendar_today),
//                       const SizedBox(width: 8),
//                       Text(formattedDate, style: const TextStyle(color: Colors.blue)),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class _CancellationPolicy extends StatelessWidget {
//   final double height, width;
//
//   const _CancellationPolicy({required this.height, required this.width});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 8.0),
//       child: Container(
//         height: height / 8.5,
//         width: width,
//         decoration: BoxDecoration(
//           color: const Color(0xffc0fce3),
//           borderRadius: const BorderRadius.vertical(bottom: Radius.circular(10)),
//           border: Border.all(color: Colors.grey.shade200),
//         ),
//         padding: const EdgeInsets.all(10),
//         child: const Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text("Cancellation Available"),
//             Text("This venue supports booking cancellation. To know more view",
//                 style: TextStyle(fontSize: 11)),
//             Text("cancellation policy", style: TextStyle(color: Colors.blue)),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class _PaymentSummary extends StatelessWidget {
//   final double height, width;
//   final num unitPrice, totalFee, gst, totalAmount;
//
//   const _PaymentSummary({
//     required this.height,
//     required this.width,
//     required this.unitPrice,
//     required this.totalFee,
//     required this.gst,
//     required this.totalAmount,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 8.0),
//       child: Container(
//         height: height / 5,
//         width: width,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(10),
//           border: Border.all(color: Colors.grey.shade200),
//         ),
//         padding: const EdgeInsets.all(10),
//         child: Column(
//           children: [
//             _summaryRow("Entry Fee", unitPrice),
//             _summaryRow("Total", totalFee),
//             _summaryRow("GST(2%)", gst),
//             const Divider(),
//             _summaryRow("Amount to pay", totalAmount),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _summaryRow(String title, num value) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(title),
//         Text("₹ ${value.toStringAsFixed(2)}"),
//       ],
//     );
//   }
// }
//
// class _ConsentText extends StatelessWidget {
//   final double height, width;
//
//   const _ConsentText({required this.height, required this.width});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 8.0),
//       child: Container(
//         height: height / 14,
//         width: width,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(10),
//           border: Border.all(color: Colors.grey.shade200),
//         ),
//         padding: const EdgeInsets.all(10),
//         child: const Text(
//           "By proceeding, I express my consent to complete this transaction.",
//           style: TextStyle(fontSize: 10.35),
//         ),
//       ),
//     );
//   }
// }
//
// class _BottomBar extends StatelessWidget {
//   final double width;
//   final num totalAmount;
//   final VoidCallback onContinue;
//
//   const _BottomBar({
//     required this.width,
//     required this.totalAmount,
//     required this.onContinue,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//       decoration: const BoxDecoration(
//         color: Colors.white,
//         border: Border(top: BorderSide(color: Colors.black12, width: 1)),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text("Total: ₹ ${totalAmount.toStringAsFixed(2)}",
//               style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//           ElevatedButton(
//             style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
//             onPressed: onContinue,
//             child: const Text("Continue", style: TextStyle(color: Colors.white)),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
//


// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:travelmate/provider/mainProvider.dart';
//
// class SampleOne extends StatefulWidget {
//   const SampleOne({super.key});
//
//   @override
//   State<SampleOne> createState() => _SampleOneState();
// }
//
// class _SampleOneState extends State<SampleOne> {
//   bool isChecked = false;
//   String? selectDesignation;
//   final List<String> designation = ["Available", "Not Available"];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Dropdown"),
//       ),
//       body: Column(
//         children: [
//           Consumer<MainProvider>(
//             builder: (context,value,child) {
//               return Container(
//                 height: 100,
//                 decoration: BoxDecoration(
//                   color: Colors.green,
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: DropdownButtonFormField<String>(
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderSide: BorderSide.none, // No border when focused
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderSide: BorderSide.none, // No border when enabled
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     labelText: "Designation",
//                     labelStyle: TextStyle(
//                         fontSize: 15,
//                         color: Colors.white,
//                         fontFamily: "muktaregular"),
//                     contentPadding:
//                     EdgeInsets.symmetric(horizontal: 10, vertical: 15),
//                   ),
//                   value: selectDesignation,
//                   style: TextStyle(
//                       fontSize: 15,
//                       color: Colors.white,
//                       fontFamily: "muktaregular"),
//                   dropdownColor: Colors.purple, // Dropdown color
//                   items: designation.map((String designation) {
//                     return DropdownMenuItem<String>(
//                       value: designation,
//                       child: Text(designation),
//                     );
//                   }).toList(),
//                   onChanged: (String? newValue) {
//                     if (newValue != null) {
//                       setState(() {
//                         selectDesignation = newValue;
//                         value.slotController.text =
//                             newValue; // Update the controller here
//                       });
//                     }
//                   },
//                   icon: Padding(
//                     padding: const EdgeInsets.only(right: 10),
//                     child: Icon(
//                       Icons.arrow_drop_down,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               );
//             }
//           ),
//
//           Consumer<MainProvider>(
//             builder: (context,val,child) {
//               return ElevatedButton(onPressed: () {
//                 val.addSlot();
//               }, child: Text("Done"));
//             }
//           )
//         ],
//       ),
//     );
//   }
// }
// // TextEditingController slotController = TextEditingController();
// // void addSlot(){
// //   String id=DateTime.now().microsecondsSinceEpoch.toString();
// //   Map<String,dynamic>det=HashMap();
// //   det["DESIGNATION"] = slotController.text;
// //   db.collection("Slot").doc(id).set(det);
// //   notifyListeners();
// //
// // }