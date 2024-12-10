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

// void showPaymentConfirmation(BuildContext context) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: Text("Confirm Payment"),
//         content: Text("Are you sure you want to make this payment?"),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.pop(context); // Close the alert dialog
//             },
//             child: Text("Cancel"),
//           ),
//           TextButton(
//             onPressed: () async {
//               Navigator.pop(context); // Close the alert dialog
//
//               //show circular progress indicator
//               showDialog(
//                 context: context,
//                   barrierDismissible: false,//prevent dismissing while loading
//                   builder: (BuildContext context) {
//                     return Center(
//                       child: CircularProgressIndicator(),
//                     );
//                   },
//               );
//
//               //simulate a delay
//
//               await Future.delayed(Duration(seconds: 3));
//
//
//
//               // navigate to paymentsuccess screen
//
//
//
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(builder: (context) => PaymentSuccess()),
//               );
//             },
//             child: Text("Pay"),
//           ),
//         ],
//       );
//     },
//   );
// }
void showPaymentConfirmation(BuildContext context,String userId,String destId,String destName,String destDistrict,String destPlace,String destImage,String destFee,num selectedCount,num totalAmount) {
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
          Consumer<MainProvider>(
            builder: (context1,tValue,child) {
              return TextButton(
                onPressed: () {
                  // Close the payment confirmation dialog
                  Navigator.pop(context);
                  // tValue.destinationBooking(userId, destId);
                  print("kkkkkkkkkkkkk  $userId lll");
                  tValue.destinationBooking(userId, destId, destName, destDistrict, destPlace, destFee, selectedCount, totalAmount, destImage);

                  // Use StatefulWidget to handle CircularProgressIndicator
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PaymentProgressScreen(userId: userId,),
                    ),
                  );
                },
                child: Text("Pay"),
              );
            }
          ),
        ],
      );
    },
  );
}
