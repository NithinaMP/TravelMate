
// --------------------------generate recipt------------------------------------------------
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import 'package:qr_flutter/qr_flutter.dart';
// import 'package:travelmate/constants/constant_colors.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:printing/printing.dart';
//
// import '../provider/mainProvider.dart';
//
// class ReceiptScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // Access the provider's state
//     final destTicketList = context.watch<MainProvider>().destTicketList;
//     final isLoading = context.watch<MainProvider>().isLoading;
//
//     if (isLoading) {
//       return Scaffold(
//         appBar: AppBar(
//           title: Text('Receipt'),
//           centerTitle: true,
//           backgroundColor: cstOrange1,
//         ),
//         body: Center(child: CircularProgressIndicator()),
//       );
//     }
//
//     if (destTicketList.isEmpty) {
//       return Scaffold(
//         appBar: AppBar(
//           title: Text('Receipt'),
//           centerTitle: true,
//           backgroundColor: cstOrange1,
//         ),
//         body: Center(child: Text('No booking found')),
//       );
//     }
//
//     var latestTicket = destTicketList.reduce((current, next) {
//       DateTime currentTravelDate = DateTime.parse(current.travelDate);
//       DateTime nextTravelDate = DateTime.parse(next.travelDate);
//       return currentTravelDate.isAfter(nextTravelDate) ? current : next;
//     });
//
//     var travelDate = DateFormat('dd MMM yyyy').format(DateTime.parse(latestTicket.travelDate));
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Receipt', style: TextStyle(color: Colors.white)),
//         centerTitle: true,
//         backgroundColor: cstOrange1,
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               // Other sections remain unchanged...
//
//               ElevatedButton.icon(
//                 onPressed: () async {
//                   await generateAndDownloadPDF(context, latestTicket, travelDate);
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
//
//   Future<void> generateAndDownloadPDF(BuildContext context, latestTicket, String travelDate) async {
//     final pdf = pw.Document();
//
//     pdf.addPage(
//       pw.Page(
//         build: (pw.Context context) => pw.Column(
//           crossAxisAlignment: pw.CrossAxisAlignment.start,
//           children: [
//             pw.Text('Booking Receipt', style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
//             pw.SizedBox(height: 16),
//             pw.Text('Booking ID: ${latestTicket.bookingId}', style: pw.TextStyle(fontSize: 16)),
//             pw.SizedBox(height: 16),
//             pw.Text('Travel Date: $travelDate', style: pw.TextStyle(fontSize: 16)),
//             pw.Text('Destination: ${latestTicket.destName}', style: pw.TextStyle(fontSize: 16)),
//             pw.Text('Place: ${latestTicket.destPlace}', style: pw.TextStyle(fontSize: 16)),
//             pw.SizedBox(height: 16),
//             pw.Text('Number of Members: ${latestTicket.totalMembers}', style: pw.TextStyle(fontSize: 16)),
//             pw.Text('Unit Price: ₹${latestTicket.unitPrice.toStringAsFixed(2)}', style: pw.TextStyle(fontSize: 16)),
//             pw.Text('Subtotal: ₹${latestTicket.subTotal.toStringAsFixed(2)}', style: pw.TextStyle(fontSize: 16)),
//             pw.Text('GST (2%): ₹${(latestTicket.subTotal * 0.02).toStringAsFixed(2)}', style: pw.TextStyle(fontSize: 16)),
//             pw.Divider(),
//             pw.Text('Total Amount: ₹${latestTicket.totalAmount.toStringAsFixed(2)}',
//                 style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
//             pw.SizedBox(height: 32),
//             pw.Center(
//               child: pw.BarcodeWidget(
//                 data: "${latestTicket.bookingId}",
//                 barcode: pw.Barcode.qrCode(),
//                 width: 100,
//                 height: 100,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//
//     // Use the printing package to save or share the PDF
//     await Printing.sharePdf(
//       bytes: await pdf.save(),
//       filename: 'booking_receipt_${latestTicket.bookingId}.pdf',
//     );
//   }
// }
// --------------------------generate recipt------------------------------------------------



import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../constants/constant_colors.dart';
import '../provider/mainProvider.dart';

class ReceiptScreen extends StatelessWidget {
  final String from; // "Destination" or "Event"

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
            Center(
              child: QrImageView(
                data: "${latestTicket.bookingId}",
                version: QrVersions.auto,
                size: 200.0,
                backgroundColor: Colors.white,
                foregroundColor: cstOrange1,
              ),
            ),
            SizedBox(height: 24),

            // Download Button
            ElevatedButton.icon(
              onPressed: () {
                // Handle download logic here
              },
              icon: Icon(Icons.download, color: Colors.white),
              label: Text(
                'Download Receipt',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16),
                backgroundColor: cstOrange1,
                textStyle: TextStyle(fontSize: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),)
          ],
        ),
      ),
    );
  }
}
//---------------2nd  code----------------------------------
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import 'package:qr_flutter/qr_flutter.dart';
// import '../constants/constant_colors.dart';
// import '../provider/mainProvider.dart';
//
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

// _______________________________________________________________________________________________________________________________________
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import 'package:qr_flutter/qr_flutter.dart';
//
// import '../constants/constant_colors.dart';
// import '../provider/mainProvider.dart';
//
// class ReceiptScreen extends StatelessWidget {
//
//   String from;//
//   ReceiptScreen({super.key, required this.from});
//   String parseCustomDate(String dateString) {
//     try {
//       // Define the custom date format matching the input string
//       final customFormat = DateFormat("EEEE,MMMM,d,yyyy");
//       DateTime parsedDate = customFormat.parse(dateString.replaceAll(',', ' '));
//       return DateFormat("yyyy-MM-dd").format(parsedDate); // Convert to ISO format
//     } catch (e) {
//       throw FormatException("Invalid date format: $dateString");
//     }
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     // Access the provider's state
//     final destTicketList = context.watch<MainProvider>().destTicketList;
//     final eventTicketList = context.watch<MainProvider>().eventTicketList;
//     final isLoading = context.watch<MainProvider>().isLoading;
//
//     // Show a loading indicator while fetching data
//     if (isLoading) {
//       return Scaffold(
//         appBar: AppBar(
//           title: Text('Receipt'),
//           centerTitle: true,
//           backgroundColor: cstOrange1,
//         ),
//         body: Center(child: CircularProgressIndicator()),
//       );
//     }
//
//     // If both lists are empty, display a message
//     if (destTicketList.isEmpty && eventTicketList.isEmpty) {
//       return Scaffold(
//         appBar: AppBar(
//           title: Text('Receipt'),
//           centerTitle: true,
//           backgroundColor: cstOrange1,
//         ),
//         body: Center(child: Text('No booking found')),
//       );
//     }
//
//     // Select the most recent ticket from either destination or event
//     var latestTicket;
//     bool isEventReceipt = false;
//
//     if (from=="Destination" && destTicketList.isNotEmpty) {
//       latestTicket = destTicketList.reduce((current, next) {
//         DateTime currentTravelDate = DateTime.parse(parseCustomDate(current.travelDate));
//         DateTime nextTravelDate = DateTime.parse(parseCustomDate(next.travelDate));
//         return currentTravelDate.isAfter(nextTravelDate) ? current : next;
//       });
//     }
//
//    else if (from=="Event"&&eventTicketList.isNotEmpty) {
//       latestTicket = eventTicketList.reduce((current, next) {
//         DateTime currentEventDate = DateTime.parse(parseCustomDate(current.eventDate));
//         DateTime nextEventDate = DateTime.parse(parseCustomDate(next.eventDate));
//         return currentEventDate.isAfter(nextEventDate) ? current : next;
//       });
//       isEventReceipt = true; // Set flag if it's an event ticket
//     }
//    if(latestTicket==null){
//      return Scaffold(
//        body: Center(child: Text("No ticket")),
//      );
//    }
//
//     // Format the date accordingly
//     var formattedDate = isEventReceipt
//         ? DateFormat('dd MMM yyyy').format(DateTime.parse(latestTicket.eventDate))
//         : DateFormat('dd MMM yyyy').format(DateTime.parse(latestTicket.travelDate));
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Receipt', style: TextStyle(color: Colors.white)),
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
//                       isEventReceipt ? 'Event Booking Receipt' : 'Booking Receipt',
//                       style: TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                         color: cstOrange1,
//                       ),
//                     ),
//                     SizedBox(height: 8),
//                     Text(
//                       'Booking ID: ${latestTicket.bookingId}',
//                       style: TextStyle(fontSize: 16, color: Colors.grey[600]),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 16),
//
//               // Event/Travel Details Section
//               Text(
//                 isEventReceipt ? 'Event Details' : 'Travel Details',
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
//                       Text(isEventReceipt
//                           ? 'Event Date: $formattedDate'
//                           : 'Travel Date: $formattedDate',
//                           style: TextStyle(fontSize: 16)),
//                       Text(isEventReceipt
//                           ? 'Event Name: ${latestTicket.eventName}'
//                           : 'Destination: ${latestTicket.destName}',
//                           style: TextStyle(fontSize: 16)),
//                       Text(isEventReceipt
//                           ? 'Venue: ${latestTicket.eventPlace}'
//                           : 'Place: ${latestTicket.destPlace}',
//                           style: TextStyle(fontSize: 16)),
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
//                           Text('${latestTicket.totalMembers}', style: TextStyle(fontSize: 16)),
//                         ],
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text('Unit Price', style: TextStyle(fontSize: 16)),
//                           Text('₹${latestTicket.unitPrice.toStringAsFixed(2)}', style: TextStyle(fontSize: 16)),
//                         ],
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text('Subtotal', style: TextStyle(fontSize: 16)),
//                           Text('₹${latestTicket.subTotal.toStringAsFixed(2)}', style: TextStyle(fontSize: 16)),
//                         ],
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text('GST (2%)', style: TextStyle(fontSize: 16)),
//                           Text('₹${(latestTicket.subTotal * 0.02).toStringAsFixed(2)}', style: TextStyle(fontSize: 16)),
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
//                             '₹${latestTicket.totalAmount.toStringAsFixed(2)}',
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
//                   data: "${latestTicket.bookingId}",
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



// -----------------------------------------------------------------------
//
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import 'package:qr_flutter/qr_flutter.dart';
// import 'package:travelmate/constants/constant_colors.dart';
//
// import '../provider/mainProvider.dart';
//
//
// class ReceiptScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // Access the provider's state
//     final destTicketList = context.watch<MainProvider>().destTicketList;
//     final eventTicketList = context.watch<MainProvider>().eventTicketList;
//     final isLoading = context.watch<MainProvider>().isLoading;
//
//     // Show a loading indicator while fetching data
//     if (isLoading) {
//       return Scaffold(
//         appBar: AppBar(
//           title: Text('Receipt'),
//           centerTitle: true,
//           backgroundColor: cstOrange1,
//         ),
//         body: Center(child: CircularProgressIndicator()),
//       );
//     }
//
//     // If the list is empty, display a message
//     if (destTicketList.isEmpty&&eventTicketList.isEmpty) {
//       return Scaffold(
//         appBar: AppBar(
//           title: Text('Receipt'),
//           centerTitle: true,
//           backgroundColor: cstOrange1,
//         ),
//         body: Center(child: Text('No booking found')),
//       );
//     }
//
//     // Select the most recentticket from either destination or event
//
//     var latestTicket;
//     bool isEventReceipt=false;
//
//     if(destTicketList.isNotEmpty){
//       latestTicket = destTicketList.reduce((current, next) {
//         DateTime currentTravelDate = DateTime.parse(current.travelDate);
//         DateTime nextTravelDate = DateTime.parse(next.travelDate);
//         return currentTravelDate.isAfter(nextTravelDate) ? current : next;
//       });
//     }
//
//     if(eventTicketList.isNotEmpty){
//       latestTicket = eventTicketList.reduce((current, next) {
//         DateTime currentEventDate = DateTime.parse(current.travelDate);
//         DateTime nextEventDate = DateTime.parse(next.travelDate);
//         return currentEventDate.isAfter(nextEventDate) ? current : next;
//       });
//
//       isEventReceipt=true;/// set flag if its an event ticket
//     }
//
//     // Format the  date accordingly
//     var formattedDate =isEventReceipt
//     ?DateFormat('dd MMM yyyy').format(DateTime.parse(latestTicket.travelDate))
//     :DateFormat('dd MMM yyyy').format(DateTime.parse(latestTicket.travelDate));
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Receipt',style: TextStyle(color: Colors.white),),
//         centerTitle: true,
//         backgroundColor:cstOrange1,
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
//                       isEventReceipt
//                           ?"Event Booking Receipt"
//                       :'Booking Receipt',
//                       style: TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                         color:cstOrange1,
//                       ),
//                     ),
//                     SizedBox(height: 8),
//                     Text(
//                       'Booking ID: ${latestTicket.bookingId}',
//                       style: TextStyle(fontSize: 16, color: Colors.grey[600]),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 16),
//
//               // Event / Travel Details Section
//               Text(
//                 isEventReceipt
//                     ?"Event Details"
//                 :'Travel Details',
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
//                       Text(isEventReceipt?"Event Date: $formattedDate":'Travel Date: $formattedDate', style: TextStyle(fontSize: 16)),
//                       Text(isEventReceipt?"Event Name: ${latestTicket.eventName}":'Destination: ${latestTicket.destName}', style: TextStyle(fontSize: 16)),
//                       Text(isEventReceipt?"Venu: ${latestTicket.eventPlace}":'Place: ${latestTicket.destPlace}', style: TextStyle(fontSize: 16)),
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
//                           Text('${latestTicket.totalMembers}', style: TextStyle(fontSize: 16)),
//                         ],
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text('Unit Price', style: TextStyle(fontSize: 16)),
//                           Text('₹${latestTicket.unitPrice.toStringAsFixed(2)}', style: TextStyle(fontSize: 16)),
//                         ],
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text('Subtotal', style: TextStyle(fontSize: 16)),
//                           Text('₹${latestTicket.subTotal.toStringAsFixed(2)}', style: TextStyle(fontSize: 16)),
//                         ],
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text('GST (2%)', style: TextStyle(fontSize: 16)),
//                           Text('₹${(latestTicket.subTotal * 0.02).toStringAsFixed(2)}', style: TextStyle(fontSize: 16)),
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
//                             '₹${latestTicket.totalAmount.toStringAsFixed(2)}',
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
//                   data: "${latestTicket.bookingId}",
//                   version: QrVersions.auto,
//                   size: 200.0,
//                   backgroundColor: Colors.white,
//                   foregroundColor:cstOrange1,
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



// ---------------------currently running code no isseue--------------------------
//
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import 'package:qr_flutter/qr_flutter.dart';
// import 'package:travelmate/constants/constant_colors.dart';
//
// import '../provider/mainProvider.dart';
//
//
// class ReceiptScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // Access the provider's state
//     final destTicketList = context.watch<MainProvider>().destTicketList;
//     final isLoading = context.watch<MainProvider>().isLoading;
//
//     // Show a loading indicator while fetching data
//     if (isLoading) {
//       return Scaffold(
//         appBar: AppBar(
//           title: Text('Receipt'),
//           centerTitle: true,
//           backgroundColor: cstOrange1,
//         ),
//         body: Center(child: CircularProgressIndicator()),
//       );
//     }
//
//     // If the list is empty, display a message
//     if (destTicketList.isEmpty) {
//       return Scaffold(
//         appBar: AppBar(
//           title: Text('Receipt'),
//           centerTitle: true,
//           backgroundColor: cstOrange1,
//         ),
//         body: Center(child: Text('No booking found')),
//       );
//     }
//
//     // Select the most recent booking based on travel date
//     var latestTicket = destTicketList.reduce((current, next) {
//       DateTime currentTravelDate = DateTime.parse(current.travelDate);
//       DateTime nextTravelDate = DateTime.parse(next.travelDate);
//       return currentTravelDate.isAfter(nextTravelDate) ? current : next;
//     });
//
//     // Format the travel date
//     var travelDate = DateFormat('dd MMM yyyy').format(DateTime.parse(latestTicket.travelDate));
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Receipt',style: TextStyle(color: Colors.white),),
//         centerTitle: true,
//         backgroundColor:cstOrange1,
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
//                         color:cstOrange1,
//                       ),
//                     ),
//                     SizedBox(height: 8),
//                     Text(
//                       'Booking ID: ${latestTicket.bookingId}',
//                       style: TextStyle(fontSize: 16, color: Colors.grey[600]),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 16),
//
//               // Travel Details Section
//               Text(
//                 'Travel Details',
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
//                       Text('Travel Date: $travelDate', style: TextStyle(fontSize: 16)),
//                       Text('Destination: ${latestTicket.destName}', style: TextStyle(fontSize: 16)),
//                       Text('Place: ${latestTicket.destPlace}', style: TextStyle(fontSize: 16)),
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
//                           Text('${latestTicket.totalMembers}', style: TextStyle(fontSize: 16)),
//                         ],
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text('Unit Price', style: TextStyle(fontSize: 16)),
//                           Text('₹${latestTicket.unitPrice.toStringAsFixed(2)}', style: TextStyle(fontSize: 16)),
//                         ],
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text('Subtotal', style: TextStyle(fontSize: 16)),
//                           Text('₹${latestTicket.subTotal.toStringAsFixed(2)}', style: TextStyle(fontSize: 16)),
//                         ],
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text('GST (2%)', style: TextStyle(fontSize: 16)),
//                           Text('₹${(latestTicket.subTotal * 0.02).toStringAsFixed(2)}', style: TextStyle(fontSize: 16)),
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
//                             '₹${latestTicket.totalAmount.toStringAsFixed(2)}',
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
//                   data: "${latestTicket.bookingId}",
//                   version: QrVersions.auto,
//                   size: 200.0,
//                   backgroundColor: Colors.white,
//                   foregroundColor:cstOrange1,
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
//
