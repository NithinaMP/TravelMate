import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travelmate/constants/call_functions.dart';
import 'package:travelmate/user/payment.dart';

class ConfirmBooking extends StatelessWidget {
  const ConfirmBooking({super.key});

  @override
  Widget build(BuildContext context) {

    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xffe6f7f5),
    appBar: AppBar(
      title: Text("Confirm booking"),
      centerTitle: true,
    ),
      body: Column(
        children: [
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Container(
              height:height/7.8,
              width: width,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade200),
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10)
                )
              ),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Varkala"),
                        Text("10"),
                      ],
                    ),
                    Row(
                      children: [
                        Text("Place"),
                        Text(" District"),
                      ],
                    ),
                    Text("Date"),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Container(
              height:height/8.5,
              width: width,
              decoration: BoxDecoration(
                color: Color(0xffc0fce3 ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)
                ),
                border: Border.all(color: Colors.grey.shade200)


              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Cancellation Available"),
                    Text("This venue supports booking cancellation. To know more view",style: TextStyle(fontSize: 11),),
                    Text("cancellation policy",style: TextStyle(color: Colors.blue),),

                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Container(
              height: height/5,
              width: width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade200)
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    SizedBox(height: 15,),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Total"),
                        Text("₹ 500"),
                      ],
                    ),
                    SizedBox(height: 5,),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("GST(2 %)"),
                        Text("₹ 5"),
                      ],
                    ),
                    SizedBox(height: 5,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(68, (index) {
                        return const Text(
                          "-",
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        );
                      }),
                    ),
                    SizedBox(height: 5,),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Amount to pay"),
                        Text("₹ 1000"),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Container(
              height: height/14,
              width: width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade200)
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    SizedBox(height: 15,),
                    Text("By proceeding ,I express my consent to complete this transaction.",style: TextStyle(fontSize: 10.35),),


                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: height/5,),
      Expanded(
        child:
        Container(
          height: height / 9,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            border: const Border(
              top: BorderSide(
                color: Colors.black12,
                width: 1,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Text Section (Left Side)
              Padding(
                padding: const EdgeInsets.only(left: 16.0), // Adjust padding if needed
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start, // Align text to the start
                  children: const [
                    Text(
                      "Total",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4), // Space between the two texts
                    Text(
                      "\₹ 200",
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              // Elevated Button (Right Side)
              Padding(
                padding: const EdgeInsets.only(right: 16.0), // Adjust padding if needed
                child: SizedBox(
                  width: width / 2.2, // Adjust button width as needed
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    onPressed: () {
                      //move to payment screen

                      callNext(context, PaymentScreen());
                    },
                    child: const Text(
                      "Continue",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )

      )
        ],
      ),
    );
  }


}


