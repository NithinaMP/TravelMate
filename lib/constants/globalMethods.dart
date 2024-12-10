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

  ),backgroundColor: Colors.green,
  )
  );
}
void showSnackBarAlert(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
    message,
    style: TextStyle(color: Colors.black),

  ),backgroundColor: Colors.red,
  )
  );
}

void showDeleteConfirmation(BuildContext context,String id,String from){
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Are you sure you want to delete?"),
          content: Text("This action cannot be undone"),
          actions: [
            TextButton(onPressed: () {
              finish(context);
            }, child: Text("Cancel")
            ),

            Consumer<MainProvider>(
              builder: (context,value,child) {
                return ElevatedButton(onPressed: () {
                  if(from=="DeleteDestination"){
                    value.deleteDestination(id, context);
                  }
                  else if(from=="DeleteEvent"){
                    value.deleteEvent(id, context);
                  }
                  showSnackBar(context, "Successfully deleted");
                  finish(context);
                }, child: Text("Delete")
                );
              }
            )
          ],
        );
      },
  );
}

void showPaymentConfirmation(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Confirm Payment"),
        content: Text("Are you sure you want to make this payment?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the alert dialog
            },
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the alert dialog
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PaymentSuccess()),
              );
            },
            child: Text("Pay"),
          ),
        ],
      );
    },
  );
}

