import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:travelmate/constants/call_functions.dart';

import 'bookTicket.dart';
import 'homeScreen.dart';

class PaymentSuccess extends StatelessWidget {
  const PaymentSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment"),
        backgroundColor: Colors.transparent,
          centerTitle: true,
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
                  callNext(context, UserHomePage());
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
