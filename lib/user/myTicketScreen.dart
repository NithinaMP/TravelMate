import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelmate/constants/call_functions.dart';
import 'package:travelmate/provider/mainProvider.dart';
import 'package:travelmate/user/getAllReceiptScreen.dart';

import '../constants/constant_colors.dart';

class MyTicketScreen extends StatelessWidget {
  final String userId;

  MyTicketScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            "My Tickets",
            style: TextStyle(
              color: Colors.white,
              fontFamily: "bakbak",
              fontSize: 28,
            ),
          ),
          bottom: TabBar(
            indicator: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xff351C08),
                  Colors.yellow,
                ],
              ),
              borderRadius: BorderRadius.circular(30),
            ),
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey,
            labelStyle: TextStyle(
              fontFamily: "benne",
              fontSize: 16,
            ),
            tabs: [
              Tab(text: 'Destinations'),
              Tab(text: 'Events'),
            ],
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorPadding: EdgeInsets.all(8),
            dividerColor: Colors.black,
            padding: EdgeInsets.only(right: 10, left: 10),
          ),
        ),
        backgroundColor: Colors.black,
        body: TabBarView(
          children: [
            // Destination Tab
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Consumer<MainProvider>(
                    builder: (context, dValue, child) {
                      // If loading, show a loading indicator
                      if (dValue.isLoading) {
                        return Center(child: CircularProgressIndicator());
                      }

                      // If there are no tickets, show a placeholder
                      if (dValue.destTicketList.isEmpty) {
                        return Center(child: Text("No ticket available"));
                      }

                      // If tickets are available, display them
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: dValue.destTicketList.length,
                        itemBuilder: (context, index) {
                          var ticket = dValue.destTicketList[index];
                          return buildTicketCard(
                            context,
                            height,
                            width,
                            admingradient,
                            ticket.destImage,
                            ticket.destName,
                            "${ticket.destPlace}, ${ticket.destDistrict}",
                            "Ticket No: ${ticket.bookingId}",
                            ticket, // Pass the ticket data
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),

            // Event Tab (You can implement this later)
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 10),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 3, // Adjust based on your data source
                    itemBuilder: (context, index) {
                      return buildTicketCard(
                        context,
                        height,
                        width,
                        admingradient,
                        "assets/image/camp_munnar.jpeg", // Event image
                        "Destination Main Title $index",
                        "Location Details LIKE Suryanelli city, Munnar, Idukki",
                        "Ticket No: DST23RT61${10 + index}",
                        null, // No ticket data for events
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTicketCard(
      BuildContext context,
      double height,
      double width,
      Gradient gradient,
      String imagePath,
      String title,
      String location,
      String ticketNumber,
      var ticket, // Ticket data
      ) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: height / 6,
        width: width,
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Container(
              width: width / 2.5,
              decoration: BoxDecoration(
                color: Colors.yellow,
                image: DecorationImage(
                  image: NetworkImage(imagePath),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.horizontal(left: Radius.circular(5)),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "cinzel",
                        fontSize: 12,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    Text(
                      location,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "didact",
                        fontSize: 9,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    SizedBox(height: 10),
                    Text(
                      ticketNumber,
                      style: TextStyle(
                        color: Colors.white70,
                        fontFamily: "didact",
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(height: 8),
                    GestureDetector(
                      onTap: () {
                        // Navigate to the GetAllReceiptScreen and pass the ticket data
                        callNext(context, GetAllReceiptScreen(ticket: ticket));
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 7),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.brown),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          "Details",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "didact",
                            fontSize: 14,
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
    );
  }
}

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import '../constants/constant_colors.dart';
//
// class MyTicketScreen extends StatelessWidget {
//   const MyTicketScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     var height = MediaQuery.of(context).size.height;
//     var width = MediaQuery.of(context).size.width;
//
//     // Replace with your gradient or default value
//     // const admingradient = LinearGradient(colors: [Colors.blue, Colors.purple]);
//
//     return DefaultTabController(
//       length: 2,
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.black,
//           leading: Icon(
//             Icons.arrow_back_ios_new_sharp,
//             color: Colors.white,
//             size: 40,
//           ),
//           title: Text(
//             "My Tickets",
//             style: TextStyle(
//               color: Colors.white,
//               fontFamily: "bakbak",
//               fontSize: 28,
//             ),
//           ),
//           bottom: TabBar(
//             indicator: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [
//                   Color(0xff351C08),
//                   Colors.yellow,
//                 ],
//                 // colors: [ Color(0xff351C08), Color(0xfffff176),],
//               ),
//               borderRadius: BorderRadius.circular(30),
//             ),
//             labelColor: Colors.white, // Active tab text color
//             unselectedLabelColor: Colors.grey, // Inactive tab text color
//             labelStyle: TextStyle(
//               fontFamily: "benne",
//               fontSize: 16,
//             ),
//             tabs: [
//               Tab(text: 'Destinations'),
//               Tab(text: 'Events'),
//
//             ],
//             indicatorSize: TabBarIndicatorSize.tab,
//             indicatorPadding: EdgeInsets.all(8),
//             dividerColor: Colors.black,
//             padding: EdgeInsets.only(
//               right: 10,
//               left: 10,
//             ),
//             // splashFactory: NoSplash.splashFactory,
//           ),
//         ),
//         backgroundColor: Colors.black,
//         body: TabBarView(
//           children: [
//             // Destination Tab
//             SingleChildScrollView(
//               child: Column(
//                 children: [
//                   SizedBox(height: 10),
//                   ListView.builder(
//                     shrinkWrap: true,
//                     physics: NeverScrollableScrollPhysics(),
//                     itemCount: 4, // Adjust based on your data source
//                     itemBuilder: (context, index) {
//                       return buildTicketCard(
//                         height,
//                         width,
//                         admingradient,
//                         "assets/image/camp munnar.jpeg",
//                         "Event Main Title $index",
//                         "Location details LIKE Suryanelli city, Munnar,Idukki",
//                         "Ticket No: SWE23RT61${10 + index}",
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ),
//
//             // Event Tab
//             SingleChildScrollView(
//               child: Column(
//                 children: [
//                   SizedBox(height: 10),
//                   ListView.builder(
//                     shrinkWrap: true,
//                     physics: NeverScrollableScrollPhysics(),
//                     itemCount: 3, // Adjust based on your data source
//                     itemBuilder: (context, index) {
//                       return buildTicketCard(
//                         height,
//                         width,
//                         admingradient,
//                         "assets/image/camp munnar.jpeg",
//                         "Destination Main Title $index",
//                         "Location Details LIKE Suryanelli city, Munnar,Idukki",
//                         "Ticket No: DST23RT61${10 + index}",
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget buildTicketCard(
//     double height,
//     double width,
//     Gradient gradient,
//     String imagePath,
//     String title,
//     String location,
//     String ticketNumber,
//   ) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Container(
//         height: height / 6,
//         width: width,
//         decoration: BoxDecoration(
//           gradient: gradient,
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: Row(
//           children: [
//             Container(
//               width: width / 2.5,
//               decoration: BoxDecoration(
//                 image: DecorationImage(
//                   image: AssetImage(imagePath),
//                   fit: BoxFit.cover,
//                 ),
//                 borderRadius: BorderRadius.horizontal(left: Radius.circular(5)),
//               ),
//             ),
//             Expanded(
//               child: Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       title,
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontFamily: "cinzel",
//                         fontSize: 12,
//                       ),
//                       overflow: TextOverflow.ellipsis,
//                       maxLines: 1,
//                     ),
//                     Text(
//                       location,
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontFamily: "didact",
//                         fontSize: 9,
//                       ),
//                       overflow: TextOverflow.ellipsis,
//                       maxLines: 1,
//                     ),
//                     SizedBox(height: 10),
//                     Text(
//                       ticketNumber,
//                       style: TextStyle(
//                         color: Colors.white70,
//                         fontFamily: "didact",
//                         fontSize: 12,
//                       ),
//                     ),
//                     SizedBox(height: 8),
//                     Container(
//                       padding:
//                           EdgeInsets.symmetric(horizontal: 30, vertical: 7),
//                       decoration: BoxDecoration(
//                         border: Border.all(color: Colors.brown),
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       child: Text(
//                         "Details",
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontFamily: "didact",
//                           fontSize: 14,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//
//     // return DefaultTabController(
//     //   length: 2,
//     //   child: Scaffold(
//     //     appBar: AppBar(
//     //       bottom: TabBar(tabs: [
//     //         Tab(text: 'Events',),
//     //         Tab(text: 'Destinations',)
//     //       ]),
//     //       leading: Icon(Icons.arrow_back_ios_new_sharp,color: Colors.white,size: 40,),
//     //       backgroundColor: Colors.black,
//     //       title: Text("My Tickets",style: TextStyle(color: Colors.white,fontFamily: "bakbak",fontSize: 28),),
//     //     ),
//     //     backgroundColor: Colors.black,
//     //     body: SingleChildScrollView(
//     //       child:TabBarView(children: [
//     //       Column(
//     //       children: [
//     //         SizedBox(height: 20,),
//     //         ListView.builder(
//     //           shrinkWrap: true,
//     //           itemCount: 4,
//     //           physics: ScrollPhysics(),
//     //           itemBuilder: (context, index) {
//     //           return Padding(
//     //             padding: const EdgeInsets.all(5.0),
//     //             child: Container(
//     //               height: height / 6,
//     //               width: width,
//     //               decoration: BoxDecoration(
//     //                 gradient: admingradient,
//     //                 borderRadius: BorderRadius.circular(5),
//     //               ),
//     //               child: Row(
//     //                 children: [
//     //                   Container(
//     //                     height: 500,
//     //                     width: width / 2.5,
//     //                     decoration: BoxDecoration(
//     //                       image: DecorationImage(
//     //                         image: AssetImage("assets/image/camp munnar.jpeg"),
//     //                         fit: BoxFit.fitHeight,
//     //                       ),
//     //                     ),
//     //                   ),
//     //                   Expanded( // Ensures text takes only the remaining available space
//     //                     child: Padding(
//     //                       padding: const EdgeInsets.all(8.0),
//     //                       child: Column(
//     //                         crossAxisAlignment: CrossAxisAlignment.start, // Align text to the start
//     //                         mainAxisAlignment: MainAxisAlignment.center, // Center vertically
//     //                         children: [
//     //                           Text(
//     //                             "Campper Campwoody - Suryanelli Munnar",
//     //                             style: TextStyle(
//     //                               color: Colors.white,
//     //                               fontFamily: "cinzel",
//     //                               fontSize: 12,
//     //                             ),
//     //                             softWrap: true, // Allows wrapping to the next line
//     //                             textAlign: TextAlign.left,
//     //                             overflow: TextOverflow.ellipsis, // Shows ellipsis if text overflows
//     //                           ),
//     //                           Text(
//     //                             "Campper Campwoody - Suryanelli Munnar",
//     //                             style: TextStyle(
//     //                               color: Colors.white,
//     //                               fontFamily: "didact",
//     //                               fontSize: 9,
//     //                             ),
//     //                             softWrap: true, // Allows wrapping to the next line
//     //                             textAlign: TextAlign.left,
//     //                             overflow: TextOverflow.ellipsis, // Shows ellipsis if text overflows
//     //                           ),
//     //                            SizedBox(height: 10,),
//     //
//     //                            Text("Ticket No: SWE23RT6112",style: TextStyle(color: Colors.white,fontFamily: "didact",fontSize: 15),),
//     //                            SizedBox(height: 8,),
//     //                            Container(
//     //                              width: 90,height: 40,decoration: BoxDecoration(border: Border.all(color: Colors.brown),
//     //                                borderRadius:BorderRadius.circular(20) ,),
//     //                              child: Center(child: Text("Details",style: TextStyle(color: Colors.white,fontFamily: "didact",fontSize: 15),)),
//     //                            )
//     //
//     //                         ],
//     //                       ),
//     //                     ),
//     //                   ),
//     //                 ],
//     //               ),
//     //             ),
//     //
//     //
//     //
//     //             //     // SizedBox(height: 2,),
//     //               //     // Row(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
//     //               //     //   children: [
//     //               //     //     Image.asset("assets/image/tickets.png",
//     //               //     //         width: 20,
//     //               //     //         height: 20,),
//     //               //     //         Column(
//     //               //     //           children: [
//     //               //     //             Text("Campper Campwoody - Suryanelli Munnar",style: TextStyle(color: Colors.white,fontFamily: "cinzel",fontSize: 15),
//     //               //     //             softWrap: true,
//     //               //     //               textAlign: TextAlign.left,
//     //               //     //               overflow: TextOverflow.visible,
//     //               //     //             ),
//     //               //     //           ],
//     //               //     //         ),
//     //               //
//     //               //       //     Column(
//     //               //       //       mainAxisAlignment: MainAxisAlignment.end,crossAxisAlignment: CrossAxisAlignment.end,
//     //               //       // children: [
//     //               //       //   Text("Campper Campwoody - Suryanelli Munnar",style: TextStyle(color: Colors.white,fontFamily: "cinzel",fontSize: 15),
//     //               //       //   softWrap: true,
//     //               //       //   textAlign: TextAlign.left,
//     //               //       //   overflow: TextOverflow.visible,
//     //               //       //   ),
//     //               //       //   Text("₹150",style: TextStyle(color: Colors.white,fontFamily: "cinzel",fontSize: 30),
//     //               //       //     textAlign: TextAlign.left,
//     //               //       //
//     //               //       //   )
//     //               //       //
//     //               //       //     ],
//     //               //       //   ),
//     //               //     // SizedBox(height: 25,),
//     //               //     // Padding(
//     //               //     //   padding: const EdgeInsets.only(left: 200),
//     //               //     //   child: Row(
//     //               //     //     children: [
//     //               //     //       Container(
//     //               //     //         height: 40,
//     //               //     //         width: 150,
//     //               //     //         decoration: BoxDecoration(
//     //               //     //             color: Colors.black,
//     //               //     //             borderRadius: BorderRadius.circular(30)
//     //               //     //         ),
//     //               //     //         child: Row(mainAxisAlignment: MainAxisAlignment.center,
//     //               //     //           children: [
//     //               //     //             Image.asset("assets/image/tickets.png",
//     //               //     //               width: 20,
//     //               //     //               height: 20,),
//     //               //     //             Center(
//     //               //     //               child: Text(" Details",style: TextStyle(color: Colors.white,fontFamily: "baloo",fontSize: 12),),
//     //               //     //             ),
//     //               //     //           ],
//     //               //     //         ),
//     //               //     //       ),
//     //               //     //       // Padding(
//     //               //     //       //   padding: const EdgeInsets.only(left: 200),
//     //               //     //       //   child: Row(
//     //               //     //       //     children: [
//     //               //     //       //       Container(
//     //               //     //       //         height: 40,
//     //               //     //       //         width: 150,
//     //               //     //       //         decoration: BoxDecoration(
//     //               //     //       //             color: Colors.black,
//     //               //     //       //             borderRadius: BorderRadius.circular(30)
//     //               //     //       //         ),
//     //               //     //       //         child: Row(mainAxisAlignment: MainAxisAlignment.center,
//     //               //     //       //           children: [
//     //               //     //       //             Image.asset("assets/image/tickets.png",
//     //               //     //       //               width: 20,
//     //               //     //       //               height: 20,),
//     //               //     //       //             Center(
//     //               //     //       //               child: Text(" Details",style: TextStyle(color: Colors.white,fontFamily: "baloo",fontSize: 12),),
//     //               //     //       //             ),
//     //               //     //       //           ],
//     //               //     //       //         ),
//     //               //     //       //       ),
//     //               //     //       //     ],
//     //               //     //       //
//     //               //     //       //   ),
//     //               //     //       // ),
//     //               //     //     ],
//     //               //     //
//     //               //     //   ),
//     //               //     // ),
//     //               //     // SizedBox(height: 50,),
//     //               //
//     //               //
//     //               //
//     //               //
//     //               //     // ],
//     //               //     // ),
//     //               //     // SizedBox(height: 5,),
//     //               //     // Text("Ticket Number",style: TextStyle(color: Colors.white,fontFamily: "bakbak",fontSize: 10),),
//     //               //     // SizedBox(height: 6,),
//     //               //     // Text("w345",style: TextStyle(color: cstText,fontSize: 15,fontFamily: "philosopher"),),
//     //               //     // SizedBox(height: 6,),
//     //               //   // SizedBox(height: 2,),
//     //               //   //   Row(mainAxisAlignment: MainAxisAlignment.start,
//     //               //   //     children: [
//     //               //         // Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
//     //               //         //  children: [
//     //               //         //    Text("Date and Hour",style: TextStyle(color: cstText,fontWeight: FontWeight.bold,fontSize: 10),),
//     //               //         //    Text("August 1,2024-11.00 AM",style: TextStyle(color: cstText,fontSize: 15,fontFamily: "philosopher"),),
//     //               //         //
//     //               //         //  ],
//     //               //         // ),
//     //               //         // Container(
//     //               //         //   height: 40,
//     //               //         //   width: 150,
//     //               //         //   decoration: BoxDecoration(
//     //               //         //       color: Colors.black,
//     //               //         //       borderRadius: BorderRadius.circular(30)
//     //               //         //   ),
//     //               //         //   child: Row(mainAxisAlignment: MainAxisAlignment.center,
//     //               //         //     children: [
//     //               //         //     Image.asset("assets/image/tickets.png",
//     //               //         //             width: 20,
//     //               //         //             height: 20,),
//     //               //         //       Center(
//     //               //         //           child: Text(" Details",style: TextStyle(color: Colors.white,fontFamily: "baloo",fontSize: 12),),
//     //               //         //       ),
//     //               //         //     ],
//     //               //         //   ),
//     //               //         // ),
//     //               //
//     //               //       // ],
//     //               //     // ),
//     //               //     // Text("August 1,2024,11.00 AM",style: TextStyle(color: cstText,fontSize: 15,fontFamily: "philosopher"),),
//     //               //
//     //               //   ],
//     //               // ),
//     //
//     //
//     //           );
//     //         },)
//     //       ],
//     //     ),
//     //   ])
//     //     )
//     //   ),
//     // );
//   }
// }
