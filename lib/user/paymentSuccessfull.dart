import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:travelmate/constants/call_functions.dart';

import 'bookTicket.dart';
import 'homeScreen.dart';
class PaymentProgressScreen extends StatefulWidget {
  String userId;
  PaymentProgressScreen({required this.userId});
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
        MaterialPageRoute(builder: (context) => PaymentSuccess(userId: widget.userId,)),
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
  String userId;
  PaymentSuccess({super.key,
  required this.userId
  });

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
      body:  Center(
        child: Column(
          children: [
            SizedBox(height: 10,),

           Lottie.asset("assets/lottie/success.json"),
            Text(
              "Thank you for your payment!",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 15,),

            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow.shade700
                  ),
                    onPressed: () {
                  print("again navigate to homescreen $userId");
                  callNext(context, UserHomePage(userID: userId,));
                }, child: Text("Go to home",style: TextStyle(color: Colors.black))
                ),
                SizedBox(width: 10,),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow.shade700
                  ),
                    onPressed: () {
                  callNext(context, BookticketWidget());
                }, child: Text("Ticket",style: TextStyle(color: Colors.black),)
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
