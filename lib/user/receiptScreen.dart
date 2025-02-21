
import 'dart:io';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
 import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../constants/constant_colors.dart';
import '../provider/mainProvider.dart';

class ReceiptScreen extends StatelessWidget {
  final String from; // "Destination" or "Event"
  final GlobalKey _globalKey = GlobalKey();
  ReceiptScreen({Key? key, required this.from}) : super(key: key);

  /// Method to parse a date string into a DateTime object
  DateTime parseCustomDate(String dateString) {
    try {
      // Remove any commas from the input string to match the expected format
      String normalizedDate = dateString.replaceAll(',', ' ');
      // Match format with normalized input
      final DateFormat inputFormat = DateFormat("EEEE MMMM d yyyy");
      return inputFormat.parse(normalizedDate);
    } catch (e) {
      throw FormatException("Invalid date format: $dateString");
    }
  }

  @override
  Widget build(BuildContext context) {
    final destTicketList = context.watch<MainProvider>().destTicketList;
    final eventTicketList = context.watch<MainProvider>().eventTicketList;
    final isLoading = context.watch<MainProvider>().isLoading;

    if (isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Receipt'),
          centerTitle: true,
          backgroundColor: cstOrange1,
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (destTicketList.isEmpty && eventTicketList.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Receipt'),
          centerTitle: true,
          backgroundColor: cstOrange1,
        ),
        body: const Center(child: Text('No booking found')),
      );
    }

    var latestTicket;
    bool isEventReceipt = false;

    if (from == "Destination" && destTicketList.isNotEmpty) {
      latestTicket = destTicketList.reduce((current, next) {
        DateTime currentTravelDate = parseCustomDate(current.travelDate);
        DateTime nextTravelDate = parseCustomDate(next.travelDate);
        return currentTravelDate.isAfter(nextTravelDate) ? current : next;
      });
    } else if (from == "Event" && eventTicketList.isNotEmpty) {
      latestTicket = eventTicketList.reduce((current, next) {
        DateTime currentEventDate = parseCustomDate(current.eventDate);
        DateTime nextEventDate = parseCustomDate(next.eventDate);
        return currentEventDate.isAfter(nextEventDate) ? current : next;
      });
      isEventReceipt = true;
    }

    if (latestTicket == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Receipt'),
          centerTitle: true,
          backgroundColor: cstOrange1,
        ),
        body: const Center(child: Text('No ticket found')),
      );
    }

    var formattedDate = isEventReceipt
        ? DateFormat('dd MMM yyyy').format(parseCustomDate(latestTicket.eventDate))
        : DateFormat('dd MMM yyyy').format(parseCustomDate(latestTicket.travelDate));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Receipt', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: cstOrange1,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: RepaintBoundary(
          key: _globalKey,
          child: Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      Text(
                        isEventReceipt ? 'Event Booking Receipt' : 'Booking Receipt',
                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: cstOrange1),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Booking ID: ${latestTicket.bookingId}',
                        style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  isEventReceipt ? 'Event Details' : 'Travel Details',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isEventReceipt
                              ? 'Event Date: $formattedDate'
                              : 'Travel Date: $formattedDate',
                          style: const TextStyle(fontSize: 16),
                        ),
                        Text(
                          isEventReceipt
                              ? 'Event Name: ${latestTicket.eventName}'
                              : 'Destination: ${latestTicket.destName}',
                          style: const TextStyle(fontSize: 16),
                        ),
                        Text(
                          isEventReceipt
                              ? 'Venue: ${latestTicket.eventPlace}'
                              : 'Place: ${latestTicket.destPlace}',
                          style: const TextStyle(fontSize: 16),
                        ),





                      ],
                    ),
                  ),
                ),
                SizedBox(height: 8),
                // Booking Summary Section
                Text(
                  'Booking Summary',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Number of Members', style: TextStyle(fontSize: 16)),
                            Text('${latestTicket.totalMembers}', style: TextStyle(fontSize: 16)),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Unit Price', style: TextStyle(fontSize: 16)),
                            Text('₹${latestTicket.unitPrice.toStringAsFixed(2)}', style: TextStyle(fontSize: 16)),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Subtotal', style: TextStyle(fontSize: 16)),
                            Text('₹${latestTicket.subTotal.toStringAsFixed(2)}', style: TextStyle(fontSize: 16)),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('GST (2%)', style: TextStyle(fontSize: 16)),
                            Text('₹${(latestTicket.subTotal * 0.02).toStringAsFixed(2)}', style: TextStyle(fontSize: 16)),
                          ],
                        ),
                        Divider(thickness: 1),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total Amount',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '₹${latestTicket.totalAmount.toStringAsFixed(2)}',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 24),
            //
                // QR Code Section
                // Center(
                //   child: QrImageView(
                //     data: "${latestTicket.bookingId}",
                //     version: QrVersions.auto,
                //     size: 200.0,
                //     backgroundColor: Colors.white,
                //     foregroundColor: cstOrange1,
                //   ),
                // ),
                _buildQRCode(latestTicket.bookingId),
                SizedBox(height: 24),

                // Download Button
                Consumer<MainProvider>(
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
                )
              ],
            ),
          ),
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
/// old code with correct flow
//  import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import 'package:qr_flutter/qr_flutter.dart';
// import '../constants/constant_colors.dart';
// import '../provider/mainProvider.dart';
// class ReceiptScreen extends StatelessWidget {
//   final String from; // "Destination" or "Event"
//
//   ReceiptScreen({Key? key, required this.from}) : super(key: key);
//
//   /// Method to parse a date string into a DateTime object
//   DateTime parseCustomDate(String dateString) {
//     try {
//       // Remove any commas from the input string to match the expected format
//       String normalizedDate = dateString.replaceAll(',', ' ');
//       // Match format with normalized input
//       final DateFormat inputFormat = DateFormat("EEEE MMMM d yyyy");
//       return inputFormat.parse(normalizedDate);
//     } catch (e) {
//       throw FormatException("Invalid date format: $dateString");
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final destTicketList = context.watch<MainProvider>().destTicketList;
//     final eventTicketList = context.watch<MainProvider>().eventTicketList;
//     final isLoading = context.watch<MainProvider>().isLoading;
//
//     if (isLoading) {
//       return Scaffold(
//         appBar: AppBar(
//           title: const Text('Receipt'),
//           centerTitle: true,
//           backgroundColor: cstOrange1,
//         ),
//         body: const Center(child: CircularProgressIndicator()),
//       );
//     }
//
//     if (destTicketList.isEmpty && eventTicketList.isEmpty) {
//       return Scaffold(
//         appBar: AppBar(
//           title: const Text('Receipt'),
//           centerTitle: true,
//           backgroundColor: cstOrange1,
//         ),
//         body: const Center(child: Text('No booking found')),
//       );
//     }
//
//     var latestTicket;
//     bool isEventReceipt = false;
//
//     if (from == "Destination" && destTicketList.isNotEmpty) {
//       latestTicket = destTicketList.reduce((current, next) {
//         DateTime currentTravelDate = parseCustomDate(current.travelDate);
//         DateTime nextTravelDate = parseCustomDate(next.travelDate);
//         return currentTravelDate.isAfter(nextTravelDate) ? current : next;
//       });
//     } else if (from == "Event" && eventTicketList.isNotEmpty) {
//       latestTicket = eventTicketList.reduce((current, next) {
//         DateTime currentEventDate = parseCustomDate(current.eventDate);
//         DateTime nextEventDate = parseCustomDate(next.eventDate);
//         return currentEventDate.isAfter(nextEventDate) ? current : next;
//       });
//       isEventReceipt = true;
//     }
//
//     if (latestTicket == null) {
//       return Scaffold(
//         appBar: AppBar(
//           title: const Text('Receipt'),
//           centerTitle: true,
//           backgroundColor: cstOrange1,
//         ),
//         body: const Center(child: Text('No ticket found')),
//       );
//     }
//
//     var formattedDate = isEventReceipt
//         ? DateFormat('dd MMM yyyy').format(parseCustomDate(latestTicket.eventDate))
//         : DateFormat('dd MMM yyyy').format(parseCustomDate(latestTicket.travelDate));
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Receipt', style: TextStyle(color: Colors.white)),
//         centerTitle: true,
//         backgroundColor: cstOrange1,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Container(
//               padding: const EdgeInsets.symmetric(vertical: 16),
//               decoration: BoxDecoration(
//                 color: Colors.blueAccent.withOpacity(0.1),
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: Column(
//                 children: [
//                   Text(
//                     isEventReceipt ? 'Event Booking Receipt' : 'Booking Receipt',
//                     style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: cstOrange1),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     'Booking ID: ${latestTicket.bookingId}',
//                     style: TextStyle(fontSize: 16, color: Colors.grey[600]),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 16),
//             Text(
//               isEventReceipt ? 'Event Details' : 'Travel Details',
//               style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 8),
//             Card(
//               elevation: 2,
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       isEventReceipt
//                           ? 'Event Date: $formattedDate'
//                           : 'Travel Date: $formattedDate',
//                       style: const TextStyle(fontSize: 16),
//                     ),
//                     Text(
//                       isEventReceipt
//                           ? 'Event Name: ${latestTicket.eventName}'
//                           : 'Destination: ${latestTicket.destName}',
//                       style: const TextStyle(fontSize: 16),
//                     ),
//                     Text(
//                       isEventReceipt
//                           ? 'Venue: ${latestTicket.eventPlace}'
//                           : 'Place: ${latestTicket.destPlace}',
//                       style: const TextStyle(fontSize: 16),
//                     ),
//
//
//
//
//
//                   ],
//                 ),
//               ),
//             ),
//             SizedBox(height: 8),
//             // Booking Summary Section
//             Text(
//               'Booking Summary',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 8),
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
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text('Number of Members', style: TextStyle(fontSize: 16)),
//                         Text('${latestTicket.totalMembers}', style: TextStyle(fontSize: 16)),
//                       ],
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text('Unit Price', style: TextStyle(fontSize: 16)),
//                         Text('₹${latestTicket.unitPrice.toStringAsFixed(2)}', style: TextStyle(fontSize: 16)),
//                       ],
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text('Subtotal', style: TextStyle(fontSize: 16)),
//                         Text('₹${latestTicket.subTotal.toStringAsFixed(2)}', style: TextStyle(fontSize: 16)),
//                       ],
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text('GST (2%)', style: TextStyle(fontSize: 16)),
//                         Text('₹${(latestTicket.subTotal * 0.02).toStringAsFixed(2)}', style: TextStyle(fontSize: 16)),
//                       ],
//                     ),
//                     Divider(thickness: 1),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           'Total Amount',
//                           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                         ),
//                         Text(
//                           '₹${latestTicket.totalAmount.toStringAsFixed(2)}',
//                           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//
//             SizedBox(height: 24),
// //
//             // QR Code Section
//             Center(
//               child: QrImageView(
//                 data: "${latestTicket.bookingId}",
//                 version: QrVersions.auto,
//                 size: 200.0,
//                 backgroundColor: Colors.white,
//                 foregroundColor: cstOrange1,
//               ),
//             ),
//             SizedBox(height: 24),
//
//             // Download Button
//             ElevatedButton.icon(
//               onPressed: () {
//                 // Handle download logic here
//               },
//               icon: Icon(Icons.download, color: Colors.white),
//               label: Text(
//                 'Download Receipt',
//                 style: TextStyle(color: Colors.white),
//               ),
//               style: ElevatedButton.styleFrom(
//                 padding: EdgeInsets.symmetric(vertical: 16),
//                 backgroundColor: cstOrange1,
//                 textStyle: TextStyle(fontSize: 18),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//               ),)
//           ],
//         ),
//       ),
//     );
//   }
// }
