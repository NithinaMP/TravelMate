import 'package:flutter/material.dart';
import 'package:travelmate/constants/call_functions.dart';
import 'package:travelmate/models/adminModels.dart';
import '../constants/constant_colors.dart';
import 'bookEvent.dart';

class EventDetailWidget extends StatelessWidget {
  final EventsModel eventDetails;
  EventDetailWidget({super.key, required this.eventDetails});

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
                                "Monday, December 18, 2024",
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
                              "Highlight Mall-Suryanelli, Munnar, Idukki",
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
                          callNext(context, BookeventWidget());
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


}



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
