

// //------------------second----------------------------
//
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:travelmate/user/receiptScreen.dart';
import 'package:travelmate/user/userBottomScreen.dart';

import '../constants/call_functions.dart';
import '../provider/mainProvider.dart';
import 'homeScreen.dart';

 class PaymentProgressScreen extends StatefulWidget {
  final String userId;
  final String from;
  PaymentProgressScreen({required this.userId,required this.from});

  @override
  _PaymentProgressScreenState createState() => _PaymentProgressScreenState();
}

class _PaymentProgressScreenState extends State<PaymentProgressScreen> {
  @override
  void initState() {
    super.initState();
    // Simulate payment process and navigate once done
    _processPayment();
  }

  Future<void> _processPayment() async {
    await Future.delayed(Duration(seconds: 2)); // Simulate processing time

    if (mounted) {
      // Ensure the widget is still in the tree
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => PaymentSuccess(userId: widget.userId, from: widget.from,),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Processing Payment")),
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class PaymentSuccess extends StatelessWidget {
  final String userId;
  final String from;
  PaymentSuccess({super.key, required this.userId,required this.from});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment"),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 10),
            Lottie.asset("assets/lottie/success.json"),
            Text(
              "Thank you for your payment!",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow.shade700,
                  ),
                  onPressed: () {
                    print("Navigating to HomeScreen $userId");
                    callNext(context, UserBottomScreen(userId: userId));
                  },
                  child: Text("Go to home", style: TextStyle(color: Colors.black)),
                ),
                SizedBox(width: 10),
                Consumer<MainProvider>(
                  builder: (context, tkValue, child) {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.yellow.shade700,
                      ),
                      onPressed: () async {
                        print("Navigate to the ticket");
                        // Fetch the latest receipt data
                        await tkValue.getDestReceipt(userId);
                        await tkValue.getEventReceipt(userId);
                        callNext(context, ReceiptScreen(from: from,));

                        // // After data is fetched, navigate to the ReceiptScreen
                        // if (tkValue.destTicketList.isNotEmpty) {
                        //   // Pass the latest (first) ticket from the list
                        //   Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => ReceiptScreen(
                        //         destTicketList: [tkValue.destTicketList.first], // Only show the latest ticket
                        //       ),
                        //     ),
                        //   );
                        // } else {
                        //   // Handle the case where no ticket is found
                        //   print("No ticket found for the user.");
                        // }
                      },
                      child: Text(
                        "Ticket",
                        style: TextStyle(color: Colors.black),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


// ----------------------ist-----------------------------------
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';
// import 'package:provider/provider.dart';
// import 'package:travelmate/constants/call_functions.dart';
// import 'package:travelmate/constants/globalMethods.dart';
// import 'package:travelmate/user/receiptScreen.dart';
// import '../provider/mainProvider.dart';
// import 'bookTicket.dart';
// import 'homeScreen.dart';
//
// class PaymentProgressScreen extends StatefulWidget {
//   final String userId;
//   PaymentProgressScreen({required this.userId});
//
//   @override
//   _PaymentProgressScreenState createState() => _PaymentProgressScreenState();
// }
//
// class _PaymentProgressScreenState extends State<PaymentProgressScreen> {
//   @override
//   void initState() {
//     super.initState();
//     // Simulate payment process and navigate once done
//     _processPayment();
//   }
//
//   Future<void> _processPayment() async {
//     await Future.delayed(Duration(seconds: 2)); // Simulate processing time
//
//     if (mounted) {
//       // Ensure the widget is still in the tree
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) => PaymentSuccess(userId: widget.userId),
//         ),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Processing Payment")),
//       body: Center(
//         child: CircularProgressIndicator(),
//       ),
//     );
//   }
// }
//
// class PaymentSuccess extends StatelessWidget {
//   final String userId;
//   PaymentSuccess({super.key, required this.userId});
//
//   @override
//   Widget build(BuildContext context) {
//     MainProvider mprovider = Provider.of<MainProvider>(context, listen: false);
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Payment"),
//         backgroundColor: Colors.transparent,
//         centerTitle: true,
//         automaticallyImplyLeading: false,
//       ),
//       backgroundColor: Colors.white,
//       body: Center(
//         child: Column(
//           children: [
//             SizedBox(height: 10),
//             Lottie.asset("assets/lottie/success.json"),
//             Text(
//               "Thank you for your payment!",
//               style: TextStyle(fontSize: 18),
//             ),
//             SizedBox(height: 15),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.yellow.shade700,
//                   ),
//                   onPressed: () {
//                     print("Navigating to HomeScreen $userId");
//                     callNext(context, UserHomePage(userID: userId));
//                   },
//                   child: Text("Go to home", style: TextStyle(color: Colors.black)),
//                 ),
//                 SizedBox(width: 10),
//                 Consumer<MainProvider>(
//                   builder: (context, tkValue, child) {
//                     return ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.yellow.shade700,
//                       ),
//                       onPressed: () async {
//                         // Fetch the receipt data
//                         // await tkValue.getDestReceipt(userId);
//                         mprovider.getDestReceipt(userId);
//
//                         // After data is fetched, navigate to the ReceiptScreen
//                         if (tkValue.destTicketList.isNotEmpty) {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => ReceiptScreen(
//                                 userId: userId, // Just passing the first item (latest one)
//                               ),
//                             ),
//                           );
//                         } else {
//                           // Handle the case where no ticket is found
//                           print("No ticket found for the user.");
//                         }
//                       },
//                       child: Text(
//                         "Ticket",
//                         style: TextStyle(color: Colors.black),
//                       ),
//                     );
//                   },
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
