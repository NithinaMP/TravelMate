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
                        return Center(child: Text("No ticket available",style: TextStyle(color: Colors.white),));
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
                            ticket,
                            "destination" // Pass ticket type
                            , // Pass the ticket data
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
                  Consumer<MainProvider>(
                    builder: (context,eValue,child) {
                      // If loading, show a loading indicator
                      if (eValue.isLoading) {
                        return Center(child: CircularProgressIndicator());
                      }

                      // If there are no tickets, show a placeholder
                      if (eValue.eventTicketList.isEmpty) {
                        return Center(child: Text("No ticket available",style: TextStyle(color: Colors.white),));
                      }
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: eValue.eventTicketList.length, // Adjust based on your data source
                        itemBuilder: (context, index) {
                          var eTicket=eValue.eventTicketList[index];
                          return buildTicketCard(
                            context,
                            height,
                            width,
                            admingradient,
                            eTicket.eventImage, // Event image
                            eTicket.eventName,
                            "${eTicket.eventPlace},${eTicket.eventDistrict}",
                            "Ticket No: ${eTicket.bookingId}",
                            eTicket , // null, // No ticket data for events
                            "event", // Pass ticket type
                          );
                        },
                      );
                    }
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
      var ticket, // Ticket data (Destination/Event)
      String ticketType, // New parameter to differentiate between Destination and Event
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
                         print("Navigate to the GetAllReceiptScreen and pass the ticket data");
                        // callNext(context, GetAllReceiptScreen(ticket: ticket));

                         Navigator.push(
                           context,
                           MaterialPageRoute(
                             builder: (context) => GetAllReceiptScreen(ticket: ticket,ticketType: ticketType,),
                           ),
                         );
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

///only for destination ticket
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:travelmate/constants/call_functions.dart';
// import 'package:travelmate/provider/mainProvider.dart';
// import 'package:travelmate/user/getAllReceiptScreen.dart';
//
// import '../constants/constant_colors.dart';
//
// class MyTicketScreen extends StatelessWidget {
//   final String userId;
//
//   MyTicketScreen({super.key, required this.userId});
//
//   @override
//   Widget build(BuildContext context) {
//     var height = MediaQuery.of(context).size.height;
//     var width = MediaQuery.of(context).size.width;
//
//     return DefaultTabController(
//       length: 2,
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.black,
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
//               ),
//               borderRadius: BorderRadius.circular(30),
//             ),
//             labelColor: Colors.white,
//             unselectedLabelColor: Colors.grey,
//             labelStyle: TextStyle(
//               fontFamily: "benne",
//               fontSize: 16,
//             ),
//             tabs: [
//               Tab(text: 'Destinations'),
//               Tab(text: 'Events'),
//             ],
//             indicatorSize: TabBarIndicatorSize.tab,
//             indicatorPadding: EdgeInsets.all(8),
//             dividerColor: Colors.black,
//             padding: EdgeInsets.only(right: 10, left: 10),
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
//                   Consumer<MainProvider>(
//                     builder: (context, dValue, child) {
//                       // If loading, show a loading indicator
//                       if (dValue.isLoading) {
//                         return Center(child: CircularProgressIndicator());
//                       }
//
//                       // If there are no tickets, show a placeholder
//                       if (dValue.destTicketList.isEmpty) {
//                         return Center(child: Text("No ticket available",style: TextStyle(color: Colors.white),));
//                       }
//
//                       // If tickets are available, display them
//                       return ListView.builder(
//                         shrinkWrap: true,
//                         physics: NeverScrollableScrollPhysics(),
//                         itemCount: dValue.destTicketList.length,
//                         itemBuilder: (context, index) {
//                           var ticket = dValue.destTicketList[index];
//                           return buildTicketCard(
//                             context,
//                             height,
//                             width,
//                             admingradient,
//                             ticket.destImage,
//                             ticket.destName,
//                             "${ticket.destPlace}, ${ticket.destDistrict}",
//                             "Ticket No: ${ticket.bookingId}",
//                             ticket, // Pass the ticket data
//                           );
//                         },
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ),
//
//             // Event Tab (You can implement this later)
//             SingleChildScrollView(
//               child: Column(
//                 children: [
//                   SizedBox(height: 10),
//                   Consumer<MainProvider>(
//                     builder: (context,eValue,child) {
//                       // If loading, show a loading indicator
//                       if (eValue.isLoading) {
//                         return Center(child: CircularProgressIndicator());
//                       }
//
//                       // If there are no tickets, show a placeholder
//                       if (eValue.eventTicketList.isEmpty) {
//                         return Center(child: Text("No ticket available",style: TextStyle(color: Colors.white),));
//                       }
//                       return ListView.builder(
//                         shrinkWrap: true,
//                         physics: NeverScrollableScrollPhysics(),
//                         itemCount: eValue.eventTicketList.length, // Adjust based on your data source
//                         itemBuilder: (context, index) {
//                           var eTicket=eValue.eventTicketList[index];
//                           return buildTicketCard(
//                             context,
//                             height,
//                             width,
//                             admingradient,
//                             eTicket.eventImage, // Event image
//                             eTicket.eventName,
//                             "${eTicket.eventPlace},${eTicket.eventDistrict}",
//                             "Ticket No: ${eTicket.bookingId}",
//                             eTicket
//                             // null, // No ticket data for events
//                           );
//                         },
//                       );
//                     }
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
//       BuildContext context,
//       double height,
//       double width,
//       Gradient gradient,
//       String imagePath,
//       String title,
//       String location,
//       String ticketNumber,
//       var ticket, // Ticket data
//       ) {
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
//                 color: Colors.yellow,
//                 image: DecorationImage(
//                   image: NetworkImage(imagePath),
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
//                     GestureDetector(
//                       onTap: () {
//                          print("Navigate to the GetAllReceiptScreen and pass the ticket data");
//                         // callNext(context, GetAllReceiptScreen(ticket: ticket));
//
//                          Navigator.push(
//                            context,
//                            MaterialPageRoute(
//                              builder: (context) => GetAllReceiptScreen(ticket: ticket),
//                            ),
//                          );
//                       },
//                       child: Container(
//                         padding: EdgeInsets.symmetric(horizontal: 30, vertical: 7),
//                         decoration: BoxDecoration(
//                           border: Border.all(color: Colors.brown),
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                         child: Text(
//                           "Details",
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontFamily: "didact",
//                             fontSize: 14,
//                           ),
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
//   }
// }
