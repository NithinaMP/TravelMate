import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:travelmate/constants/call_functions.dart';
import 'package:travelmate/models/adminModels.dart';
import 'package:travelmate/provider/mainProvider.dart';

import 'bookTicket.dart';
import 'confirmBooking.dart';

class DestinationScreen extends StatelessWidget {
  DestinationModel item;
  String userId;

  DestinationScreen({
    Key? key,
    required this.item,
    required this.userId,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(item.destName, style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.black,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 300,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(item.destImage),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Consumer<MainProvider>(
                  builder: (context,dValue,child) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.destName,
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '${item.destPlace}, ${item.destDistrict}',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(item.destDescription,
                          style: TextStyle(fontSize: 16),
                        ),
      
                        SizedBox(height: 16),
                        Text("Best time to visit:   ${item.destBestTime}", style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    ),),
                        SizedBox(height: 16),
                        Container(
                          height: 200,
                          width: width,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/location.jpeg"),
                              fit: BoxFit.fill
                            ),
      
                          ),
                        ),
                        SizedBox(height: 10,),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.yellow.shade600
                          ),
                          onPressed: () {
                            showBottomSheet(context);
                            // callNext(context, BookticketWidget());
                            // Implement the action for booking or more details
                          },
                          child: Text("Continue",style: TextStyle(color: Colors.black),),
                        ),
                      ],
                    );
                  }
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  void showBottomSheet(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    showModalBottomSheet(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 10),
              Text(
                "How many members ?",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
             Lottie.asset("assets/lottie/travel.json",height: 100,width: width),

              SizedBox(height: 10),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 50, // Adjust the height of the row container
                      child: Consumer<MainProvider>(
                        builder: (context, dvalue, child) {
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              final selectedIndex = dvalue.selectedIndex;

                              return GestureDetector(
                                onTap: () {
                                  dvalue.selectIndex(index);
                                  print("Selected: ${index + 1} seats");
                                },
                                child: Container(
                                  height: 40,
                                  width: 50,
                                  margin: const EdgeInsets.symmetric(horizontal: 4),
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: selectedIndex == index
                                        ? Colors.redAccent
                                        : Colors.grey[200],
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "${index + 1}",
                                      style: TextStyle(
                                        color: selectedIndex == index
                                            ? Colors.white
                                            : Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    Consumer<MainProvider>(
                      builder: (context, dvalue, child) {
                        return ElevatedButton(
                          onPressed: dvalue.selectedIndex == -1
                              ? null // Button disabled when no number is selected
                              : () {
                            // proceed with booking

                            print("Navigate to terms and conditions $userId");
                            Terms_condition(context,dvalue.selectedCount);
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(double.infinity, 50),
                            backgroundColor: dvalue.selectedIndex == -1
                                ? Colors.grey // Disabled button color
                                : Colors.redAccent, // Active button color
                          ),
                          child: Text(
                            "Select",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: dvalue.selectedIndex == -1
                                  ? Colors.black54 // Disabled text color
                                  : Colors.white, // Active text color
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),


            ],
          ),
        );
      },
    );
  }

  void Terms_condition(BuildContext context,num selectedCount) {

    //calculate total entry fee
    num totalEntryFee=item.destEntryFee*selectedCount;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allows proper positioning
      backgroundColor: Colors.transparent, // Make the background transparent to control the width
      builder: (context) {
        return Container(
          width: MediaQuery.of(context).size.width, // Full screen width
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min, // Adjust to content height
              children: [
                SizedBox(height: 10),
                Text(
                  "Terms & conditions",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text("1. All bookings are subject to availability and confirmation."
                    "\n2. Payments must be completed at the time of booking."
                  "\n3. Once a booking is confirmed, it cannot be canceled or refunded unless explicitly mentioned."
"                  \n4. Users are responsible for ensuring the accuracy of the details entered during the booking process."
"                  \n5. TravelMate is not liable for any issues caused by third-party service providers."
"                  \n6. Tickets and bookings are non-transferable unless stated otherwise."
"                 \n7.  Event timings, availability, and details are subject to changes by the organizer without prior notice."
"                 \n8.  TravelMate reserves the right to cancel or modify a booking if fraud or misuse is detected."
"                  \n9. Any disputes arising from bookings must be addressed as per the laws of Kerala."
"                  \n10. By proceeding, you agree to comply with these terms and conditions."
"                  "),
                SizedBox(height: 20,),
                  
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      minimumSize: Size(double.infinity, 50),
                    ),
                    onPressed: () {
                      print("navigate to confirmbooking $userId");

                      callNext(context,
                          ConfirmBooking(
                        userId: userId,
                        destId: item.destId,
                        destName: item.destName,
                        destPlace: item.destPlace,
                        destDistrict: item.destDistrict,
                        destEntryFee: totalEntryFee.toString(),
                            selectedCount:selectedCount.toInt(), destImage: item.destImage,
                      ));
                  
                }, child: Text("Ok",style: TextStyle(color: Colors.white,fontSize: 16,
                  fontWeight: FontWeight.bold,),))
                
              ],
            ),
          ),
        );
      },
    );
  }

}
