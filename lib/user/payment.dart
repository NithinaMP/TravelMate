import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/globalMethods.dart';

class PaymentScreen extends StatelessWidget {
  String userId,
      destId,
      destName,
      destPlace,
      destDistrict,
      destFee,destImage;
  int  selectedCount;
  num totalAmount;
   PaymentScreen({super.key,
     required this.userId,
     required this.destId,
     required this.destName,
     required this.destPlace,
     required this.destDistrict,
     required this.destFee,
     required this.destImage,
     required this.selectedCount,
     required this.totalAmount
   });

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Container(
            color: Colors.black12,
            height: 0.5,
          ),
        ),
      ),
      backgroundColor: Color(0xfff8f8f1  ),
      body: Column(
        children: [
          ClipPath(
            clipper: ZigZagClipper(),  // Apply the custom zigzag clip
            child: Container(
              width: double.infinity,  // Make the container full width
              height:height/10,             // Set the height of the container
              decoration: BoxDecoration(
                  color: Color(0xffeef1b9
              ),

              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    Text("Amount Payable"),
                    Text("₹${totalAmount}"),

                  ],
                ),
              ),// Container color
            ),
          ),
          SizedBox(height: 20,),
          Text("PAYMENT OPTIONS",style: TextStyle(color: Colors.black),),
          SizedBox(height: 20,),

          InkWell(
            onTap: () {
              showPaymentConfirmation(context, userId, destId, destName, destDistrict, destPlace, destImage, destFee, selectedCount, totalAmount);
            },

            child: Container(
              height: height/10,
              width: width,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.symmetric(horizontal: BorderSide(color: Colors.grey.shade300))
              ),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset("assets/image/gpay.png",scale: 14,),
                  Text("Google Pay",style: TextStyle(fontSize: 16),),
                  Icon(Icons.arrow_drop_down_outlined)
                ],
              ),
            ),
          ),
          SizedBox(height: 10,),
          InkWell(
            onTap: () {
              showPaymentConfirmation(context, userId, destId, destName, destDistrict, destPlace, destImage, destFee, selectedCount, totalAmount);
              // showPaymentConfirmation(context, "userId", "destId");
            },
            child: Container(
              height: height/10,
              width: width,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.symmetric(horizontal: BorderSide(color: Colors.grey.shade300))
              ),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset("assets/image/Paytm_logo.jpg",scale: 10,),
                  Text("Paytm",style: TextStyle(fontSize: 16),),
                  Icon(Icons.arrow_drop_down_outlined)
                ],
              ),
            ),
          ),
          SizedBox(height: 10,),
          Container(
            height: height/10,
            width: width,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.symmetric(horizontal: BorderSide(color: Colors.grey.shade300))
            ),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset("assets/image/bpi.png",scale: 4,),
                Text("Bhim",style: TextStyle(fontSize: 16),),
                Icon(Icons.arrow_drop_down_outlined)
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ZigZagClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double zigzagHeight = 10.0;  // Height of each zigzag
    double zigzagWidth = 20.0;   // Width of each zigzag

    final Path path = Path();
    path.moveTo(0, 0);  // Start at the top-left corner

    // Draw the top straight line
    path.lineTo(size.width, 0); // Top-right corner

    // Start the zigzag pattern at the bottom
    path.lineTo(size.width, size.height - zigzagHeight); // Right side

    // Create the zigzag pattern
    for (double x = size.width; x > 0; x -= zigzagWidth) {
      path.lineTo(x - zigzagWidth / 2, size.height);  // Peak of the zigzag
      path.lineTo(x - zigzagWidth, size.height - zigzagHeight);  // Bottom of the zigzag
    }

    // Finish the zigzag pattern
    path.lineTo(0, size.height - zigzagHeight); // Left side of the last zigzag
    path.lineTo(0, 0);  // Back to the top-left corner
    path.close();  // Close the path to complete the shape

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}



