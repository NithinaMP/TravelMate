import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:travelmate/constants/constant_colors.dart';

import '../provider/mainProvider.dart';


class ReceiptScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Access the provider's state
    final destTicketList = context.watch<MainProvider>().destTicketList;
    final isLoading = context.watch<MainProvider>().isLoading;

    // Show a loading indicator while fetching data
    if (isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Receipt'),
          centerTitle: true,
          backgroundColor: cstOrange1,
        ),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    // If the list is empty, display a message
    if (destTicketList.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Receipt'),
          centerTitle: true,
          backgroundColor: cstOrange1,
        ),
        body: Center(child: Text('No booking found')),
      );
    }

    // Select the most recent booking based on travel date
    var latestTicket = destTicketList.reduce((current, next) {
      DateTime currentTravelDate = DateTime.parse(current.travelDate);
      DateTime nextTravelDate = DateTime.parse(next.travelDate);
      return currentTravelDate.isAfter(nextTravelDate) ? current : next;
    });

    // Format the travel date
    var travelDate = DateFormat('dd MMM yyyy').format(DateTime.parse(latestTicket.travelDate));

    return Scaffold(
      appBar: AppBar(
        title: Text('Receipt',style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor:cstOrange1,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Title Section
              Container(
                padding: EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.blueAccent.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Text(
                      'Booking Receipt',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color:cstOrange1,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Booking ID: ${latestTicket.bookingId}',
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),

              // Travel Details Section
              Text(
                'Travel Details',
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
                      Text('Travel Date: $travelDate', style: TextStyle(fontSize: 16)),
                      Text('Destination: ${latestTicket.destName}', style: TextStyle(fontSize: 16)),
                      Text('Place: ${latestTicket.destPlace}', style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),

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

              // QR Code Section
              Center(
                child: QrImageView(
                  data: "${latestTicket.bookingId}",
                  version: QrVersions.auto,
                  size: 200.0,
                  backgroundColor: Colors.white,
                  foregroundColor:cstOrange1,
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

