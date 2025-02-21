import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:travelmate/constants/constant_colors.dart';
import 'package:travelmate/provider/mainProvider.dart';

import '../models/userModel.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';



///for qr code integration
// class GetAllReceiptScreen extends StatefulWidget {
//   final dynamic ticket;
//   final String ticketType;
//
//   GetAllReceiptScreen({Key? key, required this.ticket, required this.ticketType}) : super(key: key);
//
//   @override
//   _GetAllReceiptScreenState createState() => _GetAllReceiptScreenState();
// }
//
// class _GetAllReceiptScreenState extends State<GetAllReceiptScreen> {
//   bool isScanning = false;
//   String? scannedBookingId;
//   Barcode? scannedResult;
//   final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Receipt',
//           style: TextStyle(color: Colors.white),
//         ),
//         centerTitle: true,
//         backgroundColor: Colors.orange,
//         actions: [
//           IconButton(
//             icon: Icon(Icons.qr_code_scanner, color: Colors.white),
//             onPressed: () {
//               setState(() {
//                 isScanning = !isScanning;
//               });
//             },
//           ),
//         ],
//       ),
//       body: isScanning ? buildQRScanner() : buildReceiptView(),
//     );
//   }
//
//   Widget buildQRScanner() {
//     return Column(
//       children: [
//         Expanded(
//           flex: 5,
//           child: QRView(
//             key: qrKey,
//             onQRViewCreated: _onQRViewCreated,
//           ),
//         ),
//         Expanded(
//           flex: 1,
//           child: Center(
//             child: scannedBookingId != null
//                 ? Column(
//               children: [
//                 Text("Scanned Booking ID: $scannedBookingId", style: TextStyle(fontSize: 18)),
//                 SizedBox(height: 10),
//                 ElevatedButton(
//                   onPressed: () {
//                     setState(() {
//                       isScanning = false;
//                     });
//                   },
//                   child: Text("Back to Receipt"),
//                 ),
//               ],
//             )
//                 : Text("Scan a QR code"),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget buildReceiptView() {
//     if (widget.ticket == null) {
//       return Center(child: Text('No booking details available'));
//     }
//
//     return SingleChildScrollView(
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Container(
//               padding: EdgeInsets.symmetric(vertical: 16),
//               decoration: BoxDecoration(
//                 color: Colors.blueAccent.withOpacity(0.1),
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: Column(
//                 children: [
//                   Text(
//                     'Booking Receipt',
//                     style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.orange),
//                   ),
//                   SizedBox(height: 8),
//                   Text(
//                     'Booking ID: ${widget.ticket.bookingId}',
//                     style: TextStyle(fontSize: 16, color: Colors.grey[600]),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 16),
//
//             Text('Booking Details', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//             SizedBox(height: 8),
//
//             Card(
//               elevation: 2,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text("Booking ID: ${widget.ticket.bookingId}", style: TextStyle(fontSize: 16)),
//                     Text("Ticket Type: ${widget.ticketType}", style: TextStyle(fontSize: 16)),
//                     Text("Total Amount: ₹${widget.ticket.totalAmount}", style: TextStyle(fontSize: 16)),
//                   ],
//                 ),
//               ),
//             ),
//             SizedBox(height: 16),
//
//             Center(
//               child: QrImageView(
//                 data: widget.ticket.bookingId,
//                 version: QrVersions.auto,
//                 size: 200.0,
//                 backgroundColor: Colors.white,
//                 foregroundColor: Colors.orange,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void _onQRViewCreated(QRViewController controller) {
//     controller.scannedDataStream.listen((scanData) {
//       if (mounted) {
//         setState(() {
//           scannedBookingId = scanData.code;
//           isScanning = false;
//         });
//       }
//       controller.dispose();
//     });
//   }
// }

///ticket for both destination and event
// class GetAllReceiptScreen extends StatelessWidget {
//   final dynamic ticket;
//   final String ticketType;
//
//   GetAllReceiptScreen({Key? key, required this.ticket, required this.ticketType}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     if (ticket == null) {
//       return Scaffold(
//         appBar: AppBar(
//           title: Text('Receipt'),
//           centerTitle: true,
//           backgroundColor: cstOrange1,
//         ),
//         body: Center(child: Text('No booking details available')),
//       );
//     }
//
//     String title = "";
//     String place = "";
//     String district = "";
//     String? travelDate;
//     String? eventDate;
//
//     if (ticketType == "destination" && ticket is DestTicketModel) {
//       title = ticket.destName;
//       place = ticket.destPlace;
//       district = ticket.destDistrict;
//       travelDate = ticket.travelDate;
//     } else if (ticketType == "event" && ticket is EventTicketModel) {
//       title = ticket.eventName;
//       place = ticket.eventPlace;
//       district = ticket.eventDistrict;
//       eventDate = ticket.eventDate;
//     } else {
//       return Scaffold(
//         appBar: AppBar(
//           title: Text('Receipt'),
//           centerTitle: true,
//           backgroundColor: cstOrange1,
//         ),
//         body: Center(child: Text('Invalid ticket type')),
//       );
//     }
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Receipt',
//           style: TextStyle(color: Colors.white),
//         ),
//         centerTitle: true,
//         backgroundColor: cstOrange1,
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               // Title Section
//               Container(
//                 padding: EdgeInsets.symmetric(vertical: 16),
//                 decoration: BoxDecoration(
//                   color: Colors.blueAccent.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Column(
//                   children: [
//                     Text(
//                       'Booking Receipt',
//                       style: TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                         color: cstOrange1,
//                       ),
//                     ),
//                     SizedBox(height: 8),
//                     Text(
//                       'Booking ID: ${ticket.bookingId}',
//                       style: TextStyle(fontSize: 16, color: Colors.grey[600]),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 16),
//
//               // Travel or Event Details Section
//               Text(
//                 ticketType == "destination" ? 'Travel Details' : 'Event Details',
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 8),
//               Card(
//                 elevation: 2,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       if (ticketType == "destination" && travelDate != null) ...[
//                         Text("Travel Date: $travelDate", style: TextStyle(fontSize: 16, color: Colors.black)),
//                         Text("Destination: $title", style: TextStyle(fontSize: 16, color: Colors.black)),
//                         Text("Place: $place", style: TextStyle(fontSize: 16, color: Colors.black)),
//                         Text("District: $district", style: TextStyle(fontSize: 16, color: Colors.black)),
//                       ] else if (ticketType == "event" && eventDate != null) ...[
//                         Text("Event Date: $eventDate", style: TextStyle(fontSize: 16, color: Colors.black)),
//                         Text("Event Name: $title", style: TextStyle(fontSize: 16, color: Colors.black)),
//                         Text("Venue: $place", style: TextStyle(fontSize: 16, color: Colors.black)),
//                         Text("District: $district", style: TextStyle(fontSize: 16, color: Colors.black)),
//                       ],
//
//                       Text("Ticket No: ${ticket.bookingId}", style: TextStyle(fontSize: 16, color: Colors.black)),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(height: 16),
//
//               // Booking Summary Section
//               Text(
//                 'Booking Summary',
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 8),
//               Card(
//                 elevation: 2,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text('Number of Members', style: TextStyle(fontSize: 16)),
//                           Text('${ticket.totalMembers}', style: TextStyle(fontSize: 16)),
//                         ],
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text('Unit Price', style: TextStyle(fontSize: 16)),
//                           Text('₹${ticket.unitPrice.toStringAsFixed(2)}', style: TextStyle(fontSize: 16)),
//                         ],
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text('Subtotal', style: TextStyle(fontSize: 16)),
//                           Text('₹${ticket.subTotal.toStringAsFixed(2)}', style: TextStyle(fontSize: 16)),
//                         ],
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text('GST (2%)', style: TextStyle(fontSize: 16)),
//                           Text('₹${(ticket.subTotal * 0.02).toStringAsFixed(2)}', style: TextStyle(fontSize: 16)),
//                         ],
//                       ),
//                       Divider(thickness: 1),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             'Total Amount',
//                             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                           ),
//                           Text(
//                             '₹${ticket.totalAmount.toStringAsFixed(2)}',
//                             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(height: 24),
//
//               // QR Code Section
//               Center(
//                 child: QrImageView(
//                   data: ticket.bookingId,
//                   version: QrVersions.auto,
//                   size: 200.0,
//                   backgroundColor: Colors.white,
//                   foregroundColor: cstOrange1,
//                 ),
//               ),
//               SizedBox(height: 24),
//
//               // Download Button
//               ElevatedButton.icon(
//                 onPressed: () {
//                   // Handle download logic here
//                 },
//                 icon: Icon(Icons.download, color: Colors.white),
//                 label: Text(
//                   'Download Receipt',
//                   style: TextStyle(color: Colors.white),
//                 ),
//                 style: ElevatedButton.styleFrom(
//                   padding: EdgeInsets.symmetric(vertical: 16),
//                   backgroundColor: cstOrange1,
//                   textStyle: TextStyle(fontSize: 18),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

/// for share to whatsapp as a image
// import 'dart:io';
// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:qr_flutter/qr_flutter.dart';
//
// import 'dart:io';
// import 'dart:typed_data';
// import 'dart:ui' as ui;
// import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:qr_flutter/qr_flutter.dart';
// import 'package:share_plus/share_plus.dart';
//
// class GetAllReceiptScreen extends StatelessWidget {
//   final dynamic ticket;
//   final String ticketType;
//   final GlobalKey _globalKey = GlobalKey(); // Key for capturing the widget
//
//   GetAllReceiptScreen({Key? key, required this.ticket, required this.ticketType}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     if (ticket == null) {
//       return Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           title: Text('Receipt'),
//           centerTitle: true,
//           backgroundColor: Colors.orange,
//         ),
//         body: Center(child: Text('No booking details available')),
//       );
//     }
//
//     String title = "";
//     String place = "";
//     String district = "";
//     String? travelDate;
//     String? eventDate;
//
//     if (ticketType == "destination") {
//       title = ticket.destName;
//       place = ticket.destPlace;
//       district = ticket.destDistrict;
//       travelDate = ticket.travelDate;
//     } else if (ticketType == "event") {
//       title = ticket.eventName;
//       place = ticket.eventPlace;
//       district = ticket.eventDistrict;
//       eventDate = ticket.eventDate;
//     } else {
//       return Scaffold(
//         appBar: AppBar(
//           title: Text('Receipt'),
//           centerTitle: true,
//           backgroundColor: Colors.orange,
//         ),
//         body: Center(child: Text('Invalid ticket type')),
//       );
//     }
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Receipt', style: TextStyle(color: Colors.white)),
//         centerTitle: true,
//         backgroundColor: Colors.orange,
//       ),
//       body: RepaintBoundary(
//         key: _globalKey, // Assign key for capturing image
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 _buildReceiptHeader(ticket.bookingId),
//                 _buildTicketDetails(ticketType, title, place, district, travelDate, eventDate),
//                 _buildBookingSummary(ticket),
//                 _buildQRCode(ticket.bookingId),
//                 _buildShareButton(),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildReceiptHeader(String bookingId) {
//     return Container(
//       padding: EdgeInsets.symmetric(vertical: 16),
//       decoration: BoxDecoration(
//         color: Colors.blueAccent.withOpacity(0.1),
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Column(
//         children: [
//           Text('Booking Receipt',
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.orange)),
//           SizedBox(height: 8),
//           Text('Booking ID: $bookingId', style: TextStyle(fontSize: 16, color: Colors.grey[600])),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildTicketDetails(String ticketType, String title, String place, String district, String? travelDate, String? eventDate) {
//     return Card(
//       elevation: 2,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             if (ticketType == "destination" && travelDate != null) ...[
//               Text("Travel Date: $travelDate", style: TextStyle(fontSize: 16)),
//               Text("Destination: $title", style: TextStyle(fontSize: 16)),
//               Text("Place: $place", style: TextStyle(fontSize: 16)),
//               Text("District: $district", style: TextStyle(fontSize: 16)),
//             ] else if (ticketType == "event" && eventDate != null) ...[
//               Text("Event Date: $eventDate", style: TextStyle(fontSize: 16)),
//               Text("Event Name: $title", style: TextStyle(fontSize: 16)),
//               Text("Venue: $place", style: TextStyle(fontSize: 16)),
//               Text("District: $district", style: TextStyle(fontSize: 16)),
//             ],
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildBookingSummary(dynamic ticket) {
//     return Card(
//       elevation: 2,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _buildSummaryRow('Number of Members', '${ticket.totalMembers}'),
//             _buildSummaryRow('Unit Price', '₹${ticket.unitPrice.toStringAsFixed(2)}'),
//             _buildSummaryRow('Subtotal', '₹${ticket.subTotal.toStringAsFixed(2)}'),
//             _buildSummaryRow('GST (2%)', '₹${(ticket.subTotal * 0.02).toStringAsFixed(2)}'),
//             Divider(thickness: 1),
//             _buildSummaryRow('Total Amount', '₹${ticket.totalAmount.toStringAsFixed(2)}', bold: true),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildQRCode(String bookingId) {
//     return Center(
//       child: QrImageView(
//         data: bookingId,
//         version: QrVersions.auto,
//         size: 200.0,
//         backgroundColor: Colors.white,
//         foregroundColor: Colors.orange,
//       ),
//     );
//   }
//
//   Widget _buildShareButton() {
//     return ElevatedButton.icon(
//       onPressed: () => _captureAndSharePng(),
//       icon: Icon(Icons.share, color: Colors.white),
//       label: Text('Share to WhatsApp', style: TextStyle(color: Colors.white)),
//       style: ElevatedButton.styleFrom(
//         padding: EdgeInsets.symmetric(vertical: 16),
//         backgroundColor: Colors.orange,
//         textStyle: TextStyle(fontSize: 18),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//       ),
//     );
//   }
//
//   Widget _buildSummaryRow(String label, String value, {bool bold = false}) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(label, style: TextStyle(fontSize: 16, fontWeight: bold ? FontWeight.bold : FontWeight.normal)),
//         Text(value, style: TextStyle(fontSize: 16, fontWeight: bold ? FontWeight.bold : FontWeight.normal)),
//       ],
//     );
//   }
//
//   Future<void> _captureAndSharePng() async {
//     try {
//       RenderRepaintBoundary boundary = _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
//       ui.Image image = await boundary.toImage(pixelRatio: 3.0);
//       ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
//       Uint8List pngBytes = byteData!.buffer.asUint8List();
//
//       final directory = await getApplicationDocumentsDirectory();
//       final imagePath = File('${directory.path}/receipt.png');
//       await imagePath.writeAsBytes(pngBytes);
//
//       await Share.shareFiles([imagePath.path], text: 'Here is your booking receipt!');
//     } catch (e) {
//       print("Error capturing and sharing: $e");
//     }
//   }
// }

///enitre screen

import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';

class GetAllReceiptScreen extends StatelessWidget {
  final dynamic ticket;
  final String ticketType;
  final GlobalKey _globalKey = GlobalKey(); // Key for capturing the widget

  GetAllReceiptScreen({Key? key, required this.ticket, required this.ticketType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (ticket == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Receipt'),
          centerTitle: true,
          backgroundColor: Colors.orange,
        ),
        body: Center(child: Text('No booking details available')),
      );
    }

    String title = "";
    String place = "";
    String district = "";
    String? travelDate;
    String? eventDate;

    if (ticketType == "destination") {
      title = ticket.destName;
      place = ticket.destPlace;
      district = ticket.destDistrict;
      travelDate = ticket.travelDate;
    } else if (ticketType == "event") {
      title = ticket.eventName;
      place = ticket.eventPlace;
      district = ticket.eventDistrict;
      eventDate = ticket.eventDate;
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text('Receipt'),
          centerTitle: true,
          backgroundColor: Colors.orange,
        ),
        body: Center(child: Text('Invalid ticket type')),
      );
    }

    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      appBar: AppBar(
        title: Text('Receipt', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: cstOrange1,
      ),
      body: SingleChildScrollView(
        child: RepaintBoundary(
          key: _globalKey, // Assign key for capturing image
          child: Container(
            color: Colors.white,  // Explicitly setting white background
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildReceiptHeader(ticket.bookingId),
                _buildTicketDetails(ticketType, title, place, district, travelDate, eventDate),
                _buildBookingSummary(ticket),
                SizedBox(height: 10,),
                _buildQRCode(ticket.bookingId),
                SizedBox(height: 10,),
                _buildShareButton(),
              ],
            ),
          ),
        ),
      ),

    );
  }

  Widget _buildReceiptHeader(String bookingId) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.blueAccent.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text('Booking Receipt',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color:cstOrange1)),
          SizedBox(height: 8),
          Text('Booking ID: $bookingId', style: TextStyle(fontSize: 16, color: Colors.grey[600])),
        ],
      ),
    );
  }

  Widget _buildTicketDetails(String ticketType, String title, String place, String district, String? travelDate, String? eventDate) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (ticketType == "destination" && travelDate != null) ...[
              Text("Travel Date: $travelDate", style: TextStyle(fontSize: 16)),
              Text("Destination: $title", style: TextStyle(fontSize: 16)),
              Text("Place: $place", style: TextStyle(fontSize: 16)),
              Text("District: $district", style: TextStyle(fontSize: 16)),
            ] else if (ticketType == "event" && eventDate != null) ...[
              Text("Event Date: $eventDate", style: TextStyle(fontSize: 16)),
              Text("Event Name: $title", style: TextStyle(fontSize: 16)),
              Text("Venue: $place", style: TextStyle(fontSize: 16)),
              Text("District: $district", style: TextStyle(fontSize: 16)),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildBookingSummary(dynamic ticket) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSummaryRow('Number of Members', '${ticket.totalMembers}'),
            _buildSummaryRow('Unit Price', '₹${ticket.unitPrice.toStringAsFixed(2)}'),
            _buildSummaryRow('Subtotal', '₹${ticket.subTotal.toStringAsFixed(2)}'),
            _buildSummaryRow('GST (2%)', '₹${(ticket.subTotal * 0.02).toStringAsFixed(2)}'),
            Divider(thickness: 1),
            _buildSummaryRow('Total Amount', '₹${ticket.totalAmount.toStringAsFixed(2)}', bold: true),
          ],
        ),
      ),
    );
  }

  Widget _buildQRCode(String bookingId) {
    return Center(
      child: QrImageView(
        data: bookingId,
        version: QrVersions.auto,
        size: 200.0,
        backgroundColor: Colors.white,
        foregroundColor: cstOrange1,
      ),
    );
  }

  Widget _buildShareButton() {
    return Consumer<MainProvider>(
      builder: (context,value,child) {
        return ElevatedButton.icon(
          onPressed: () => _captureAndSharePng(context),
          icon: Icon(Icons.share, color: Colors.white),
          label:value.isSaving
              ?CircularProgressIndicator(color: Colors.white,)
              : Text('Share to WhatsApp', style: TextStyle(color: Colors.white)),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 16),
            backgroundColor: cstOrange1,
            textStyle: TextStyle(fontSize: 18),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8)
            ),
          ),
        );
      }
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool bold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontSize: 16, fontWeight: bold ? FontWeight.bold : FontWeight.normal)),
        Text(value, style: TextStyle(fontSize: 16, fontWeight: bold ? FontWeight.bold : FontWeight.normal)),
      ],
    );
  }

  // Future<void> _captureAndSharePng() async {
  //   try {
  //     RenderRepaintBoundary boundary = _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
  //     ui.Image image = await boundary.toImage(pixelRatio: 3.0);
  //     ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
  //     Uint8List pngBytes = byteData!.buffer.asUint8List();
  //
  //     final directory = await getApplicationDocumentsDirectory();
  //     final imagePath = File('${directory.path}/receipt.png');
  //     await imagePath.writeAsBytes(pngBytes);
  //
  //     await Share.shareFiles([imagePath.path], text: 'Here is your booking receipt!');
  //   } catch (e) {
  //     print("Error capturing and sharing: $e");
  //   }
  // }
  Future<void> _captureAndSharePng(BuildContext context) async {
    final provider = Provider.of<MainProvider>(context, listen: false);
    try {
      // Set isSaving to true before starting
      provider.isSaving = true;
      provider.notifyListeners();

      RenderRepaintBoundary boundary = _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      final directory = await getApplicationDocumentsDirectory();
      final imagePath = File('${directory.path}/receipt.png');
      await imagePath.writeAsBytes(pngBytes);

      await Share.shareFiles([imagePath.path], text: 'Here is your booking receipt!');
    } catch (e) {
      print("Error capturing and sharing: $e");
    } finally {
      // Reset isSaving after completion
      provider.isSaving = false;
      provider.notifyListeners();
    }
  }

}


