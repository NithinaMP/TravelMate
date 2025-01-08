import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelmate/constants/call_functions.dart';
import 'package:travelmate/provider/mainProvider.dart';

import '../user/paymentSuccessfull.dart';

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      message,
      style: TextStyle(color: Colors.black),
    ),
    backgroundColor: Colors.green,
  ));
}

void showSnackBarAlert(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      message,
      style: TextStyle(color: Colors.black),
    ),
    backgroundColor: Colors.red,
  ));
}

void showDeleteConfirmation(BuildContext context, String id, String from) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("Are you sure you want to delete?"),
        content: Text("This action cannot be undone"),
        actions: [
          TextButton(
              onPressed: () {
                finish(context);
              },
              child: Text("Cancel")),
          Consumer<MainProvider>(builder: (context, value, child) {
            return ElevatedButton(
                onPressed: () {
                  if (from == "DeleteDestination") {
                    value.deleteDestination(id, context);
                  } else if (from == "DeleteEvent") {
                    value.deleteEvent(id, context);
                  }
                  showSnackBar(context, "Successfully deleted");
                  finish(context);
                },
                child: Text("Delete"));
          })
        ],
      );
    },
  );
}

void showPaymentConfirmation(
    BuildContext context,
    String userId,
    String destId,
    String destName,
    String destDistrict,
    String destPlace,
    String destImage,
    String destEntryFee,
    num totalTickets,
    num totalAmount,
    num subTotal,
    String from,
    {String? eventDate}// Optional parameter for event date
    ) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Confirm Payment"),
        content: Text("Are you sure you want to make this payment?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
            },
            child: Text("Cancel"),
          ),
          Consumer<MainProvider>(builder: (context1, tValue, child) {
            return TextButton(
              onPressed: () {
                // Close the payment confirmation dialog
                Navigator.pop(context);

                print("kkkkkkkkkkkkk  $userId lll");

                ///process the booking based on the sourse

                if(from=="Destination"){
                  tValue.destinationBooking(
                      userId,
                      destId,
                      destName,
                      destDistrict,
                      destPlace,
                      destEntryFee,
                      totalTickets,
                      totalAmount,
                      subTotal,
                      destImage);
                }
                else if(from=="Event"){



                  ///check if eventdate is valid before passing

                  if(eventDate==null ||eventDate.isEmpty){
                    showSnackBarAlert(context, "Event date is missing or invalid");
                    return;
                  }
                  ///event date before passing
                  print("Event date being passed: $eventDate");

                  tValue.eventBooking(
                      userId,
                      destId,
                      destName,
                      destDistrict,
                      destPlace,
                      destEntryFee,
                      totalTickets,
                      totalAmount,
                      subTotal,
                      destImage,
                      eventDate ,// Pass event date or empty if not provided
                  );
                }

                ///navigate to the payment progress screen

                Navigator.push(
                  context,
                  MaterialPageRoute(

                    builder: (context) => PaymentProgressScreen(
                      userId: userId, from: from,
                    ),
                  ),
                );
              },
              child: Text("Pay"),
            );
          }),
        ],
      );
    },
  );
}
