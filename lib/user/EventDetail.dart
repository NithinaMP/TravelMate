


// ist complte code----------------------------------------------
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:travelmate/constants/call_functions.dart';
import 'package:travelmate/models/adminModels.dart';
import 'package:travelmate/refactors/showBottomSheet.dart';
import '../constants/constant_colors.dart';
import '../provider/mainProvider.dart';
import 'bookEvent.dart';
import 'confirmBooking.dart';

class EventDetailScreen extends StatelessWidget {
  final EventsModel eventDetails;
  String userId;
  EventDetailScreen({super.key, required this.eventDetails,required this.userId});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Book Ticket",
          style: TextStyle(
            color: Colors.white,
            fontFamily: "bakbak",
            fontSize: 25,
          ),
        ),
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Event Image
              Container(
                width: width,
                height: height / 3,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(eventDetails.eventImage),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              SizedBox(height: 10),

              // Event Name
              Text(
                eventDetails.eventName,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "bakbak",
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 10),

              // About Event Section
              Text(
                "About Event",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "bakbak",
                  fontSize: 20,
                ),
              ),

              SizedBox(height: 5),

              Text(
                eventDetails.eventDescription,
                style: TextStyle(
                  fontFamily: "baloo",
                  fontSize: 13,
                  color: Colors.white,
                ),
              ),

              SizedBox(height: 20),

              // Event Details Section
              Container(
                width: width,
                decoration: BoxDecoration(
                  gradient: admingradientone,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Date and Time
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_month_outlined,
                            color: Colors.white,
                            size: 25,
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                DateFormat("EEEE, MMMM  d, y ").format(DateTime.parse(eventDetails.eventDate)),
                                // eventDetails.eventDate,
                                // "Monday, December 18, 2024",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: "bakbak",
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "10 AM to 3 PM",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: "baloo",
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),

                      SizedBox(height: 20),

                      // Location
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            color: Colors.white,
                            size: 25,
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              "${eventDetails.eventPlace},${eventDetails.eventDistrict}",
                              // "Highlight Mall-Suryanelli, Munnar, Idukki",
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: "bakbak",
                                color: Colors.white,
                              ),
                              softWrap: true,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 30),

                      // Book Now Button
                      InkWell(
                        onTap: () {
                          // selectCountBottomSheet(context, "Event", userId, null, eventDetails.eventId);
                          // selectCountBottomSheet(context, "EventDetailScreen", userId);
                          // callNext(context, BookeventWidget());
                          showBottomSheet(context);
                        },
                        child: Container(
                          width: width / 1.5,
                          height: 70,
                          decoration: BoxDecoration(
                            gradient: textGradient,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text(
                              "Book Now",
                              style: TextStyle(
                                fontFamily: "benne",
                                fontSize: 25,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  void showBottomSheet(BuildContext context) {

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
                              final selectedEventIndex = dvalue.selectedEventIndex;

                              return GestureDetector(
                                onTap: () {
                                  dvalue.selectEventIndex(index);
                                  print("Selected: ${index + 1} seats");
                                },
                                child: Container(
                                  height: 40,
                                  width: 50,
                                  margin: const EdgeInsets.symmetric(horizontal: 4),
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: selectedEventIndex == index
                                        ? Colors.redAccent
                                        : Colors.grey[200],
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "${index + 1}",
                                      style: TextStyle(
                                        color: selectedEventIndex == index
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
                          onPressed: dvalue.selectedEventIndex == -1
                              ? null // Button disabled when no number is selected
                              : () {
                            // proceed with booking

                            print("Navigate to terms and conditions $userId");
                            Terms_condition(context,dvalue.selectedEventCount);
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(double.infinity, 50),
                            backgroundColor: dvalue.selectedEventIndex == -1
                                ? Colors.grey // Disabled button color
                                : Colors.redAccent, // Active button color
                          ),
                          child: Text(
                            "Select",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: dvalue.selectedEventIndex == -1
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
    num entryFee=double.parse(eventDetails.eventEntryFee.toString());
    num totalEntryFee=entryFee * selectedCount;
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
                            destId: eventDetails.eventId,
                            Name: eventDetails.eventName,
                            Place: eventDetails.eventPlace,
                            District: eventDetails.eventDistrict,
                            EntryFee: totalEntryFee.toString(),
                            selectedCount:selectedCount.toInt(),
                            Image: eventDetails.eventImage,
                            from: 'Event',
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


// -------------------------------------------second--------
// import 'package:flutter/material.dart';
// import 'package:travelmate/constants/call_functions.dart';
// import 'package:travelmate/models/adminModels.dart';
// import '../constants/constant_colors.dart';
// import 'bookEvent.dart';
//
// class eventDetailWidget extends StatelessWidget {
//   final EventsModel eventDetails;
//   eventDetailWidget({super.key,required this.eventDetails});
//
//   @override
//   Widget build(BuildContext context) {
//     var height = MediaQuery.of(context).size.height;
//     var width = MediaQuery.of(context).size.width;
//
//     return Scaffold(
//       appBar: AppBar(
//
//         backgroundColor: Colors.black,
//         title: Text("Book Ticket",style: TextStyle(color: Colors.white,fontFamily: "bakbak",fontSize: 25),),
//       ),
//       backgroundColor: Colors.black,
//       body: SingleChildScrollView(
//         child:
//       Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(1.0),
//             child: Container(
//               width: width,
//               height: height/3,
//               decoration: BoxDecoration(
//                   image: DecorationImage(
//                     image:NetworkImage(eventDetails.eventImage),
//                     fit: BoxFit.cover,
//                   ),
//               ),
//             ),
//           ),
//         Padding(
//           padding: const EdgeInsets.all(10.0),
//           child: Text("About Event",style: TextStyle(color: Colors.white,fontFamily: "bakbak",fontSize: 20),),
//         ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text(eventDetails.eventDescription,
//             style: TextStyle(fontFamily: "baloo",fontSize: 13,color: Colors.white),
//             softWrap: true,
//             textAlign: TextAlign.left,),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Container(
//               width: width,
//               height: height/3,
//               decoration: BoxDecoration(
//                 gradient: admingradientone,
//                 borderRadius: BorderRadius.circular(30)
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.only(top: 20,left: 20),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(top: 10),
//                       child: Row(mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           Icon(Icons.calendar_month_outlined,color: Colors.white,size: 25,),
//                           Column(crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                           Text("Monday,December 18,2024",style: TextStyle(fontSize: 15,fontFamily: "bakbak",color: Colors.white),),
//                               Text("10 AM to 3 PM",style: TextStyle(fontSize: 12,fontFamily: "baloo",color: Colors.white),)
//                          ]
//                           )
//                         ],
//                       ),
//
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(top: 30),
//                       child: Row(mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           Icon(Icons.location_on_outlined,color: Colors.white,size: 25,),
//                           Column(crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text("Highlight Mall-Suryanelli,Munnar,Idukki.",style: TextStyle(fontSize: 15,fontFamily: "bakbak",color: Colors.white,),
//                                   softWrap: true,
//                                   textAlign: TextAlign.left,
//                                 ),
//
//                               ]
//                           )
//                         ],
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(left: 20,right: 20,top: 70),
//                       child: InkWell(
//                         onTap: () {
//                           callNext(context, BookeventWidget());
//                         },
//                         child: Container(
//                           width: width/1.5,height: 70,
//                           decoration: BoxDecoration(gradient: admingradient,
//                           borderRadius: BorderRadius.circular(20)),
//                           child: Center(child: Text("Book Now",style: TextStyle(fontFamily: "benne",fontSize: 25,color: Colors.white),)),
//                         ),
//                       ),
//                     ),
//
//                   ],
//                 ),
//               ),
//
//             ),
//           )
//         ],
//       ),
//       )
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:travelmate/constants/call_functions.dart';
// import 'package:travelmate/models/adminModels.dart';
// import '../constants/constant_colors.dart';
// import 'bookEvent.dart';
//
// class EventDetailWidget extends StatelessWidget {
//   final EventsModel eventDetails;
//   EventDetailWidget({super.key, required this.eventDetails});
//
//   @override
//   Widget build(BuildContext context) {
//     var height = MediaQuery.of(context).size.height;
//     var width = MediaQuery.of(context).size.width;
//
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         title: Text(
//           "Book Ticket",
//           style: TextStyle(
//             color: Colors.white,
//             fontFamily: "bakbak",
//             fontSize: 25,
//           ),
//         ),
//       ),
//       backgroundColor: Colors.black,
//       body: SingleChildScrollView(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Event Image
//             Padding(
//               padding: const EdgeInsets.all(1.0),
//               child: Container(
//                 width: width,
//                 height: height / 3,
//                 decoration: BoxDecoration(
//                   image: DecorationImage(
//                     image: NetworkImage(eventDetails.eventImage),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//             ),
//
//             // Event Name
//             Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: Text(
//                 eventDetails.eventName,
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontFamily: "bakbak",
//                   fontSize: 22,
//                   fontWeight: FontWeight.bold,
//                 ),
//                 softWrap: true,
//                 textAlign: TextAlign.center,
//               ),
//             ),
//
//             // About Event Section
//             Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: Text(
//                 "About Event",
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontFamily: "bakbak",
//                   fontSize: 20,
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: ExpandableText(
//                 eventDetails.eventDescription,
//                 style: TextStyle(
//                   fontFamily: "baloo",
//                   fontSize: 13,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//
//             // Event Details Section
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Container(
//                 width: width,
//                 decoration: BoxDecoration(
//                   gradient: admingradientone,
//                   borderRadius: BorderRadius.circular(30),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       // Date and Time
//                       Padding(
//                         padding: const EdgeInsets.only(top: 10),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Icon(
//                               Icons.calendar_month_outlined,
//                               color: Colors.white,
//                               size: 25,
//                             ),
//                             SizedBox(width: 10),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   "Monday, December 18, 2024",
//                                   style: TextStyle(
//                                     fontSize: 15,
//                                     fontFamily: "bakbak",
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                                 Text(
//                                   "10 AM to 3 PM",
//                                   style: TextStyle(
//                                     fontSize: 12,
//                                     fontFamily: "baloo",
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                               ],
//                             )
//                           ],
//                         ),
//                       ),
//
//                       // Location
//                       Padding(
//                         padding: const EdgeInsets.only(top: 30),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Icon(
//                               Icons.location_on_outlined,
//                               color: Colors.white,
//                               size: 25,
//                             ),
//                             SizedBox(width: 10),
//                             Expanded(
//                               child: Text(
//                                 "Highlight Mall-Suryanelli, Munnar, Idukki",
//                                 style: TextStyle(
//                                   fontSize: 15,
//                                   fontFamily: "bakbak",
//                                   color: Colors.white,
//                                 ),
//                                 softWrap: true,
//                                 textAlign: TextAlign.left,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//
//                       // Book Now Button
//                       Padding(
//                         padding: const EdgeInsets.only(top: 30),
//                         child: InkWell(
//                           onTap: () {
//                             callNext(context, BookeventWidget());
//                           },
//                           child: Container(
//                             width: width / 1.5,
//                             height: 70,
//                             decoration: BoxDecoration(
//                               gradient: admingradient,
//                               borderRadius: BorderRadius.circular(20),
//                             ),
//                             child: Center(
//                               child: Text(
//                                 "Book Now",
//                                 style: TextStyle(
//                                   fontFamily: "benne",
//                                   fontSize: 25,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class ExpandableText extends StatefulWidget {
//   final String text;
//   final TextStyle style;
//
//   ExpandableText(this.text, {required this.style});
//
//   @override
//   _ExpandableTextState createState() => _ExpandableTextState();
// }
//
// class _ExpandableTextState extends State<ExpandableText> {
//   bool isExpanded = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           isExpanded ? widget.text : widget.text.substring(0, 110) + "...",
//           style: widget.style,
//         ),
//         GestureDetector(
//           onTap: () {
//             setState(() {
//               isExpanded = !isExpanded;
//             });
//           },
//           child: Text(
//             isExpanded ? "Show less" : "Show more",
//             style: TextStyle(
//               fontSize: 12,
//               color: Colors.blue,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
