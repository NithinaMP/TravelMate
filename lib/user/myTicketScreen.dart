import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/constant_colors.dart';

class MyTicketScreen extends StatelessWidget {
  const MyTicketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;



    // Replace with your gradient or default value
    // const admingradient = LinearGradient(colors: [Colors.blue, Colors.purple]);

    return DefaultTabController(
    length: 2,
    child: Scaffold(
    appBar: AppBar(
    backgroundColor: Colors.black,
    leading: Icon(Icons.arrow_back_ios_new_sharp,
    color: Colors.white,
    size: 40,
    ),
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
            colors: [ Color(0xff351C08), Colors.yellow,],
            // colors: [ Color(0xff351C08), Color(0xfffff176),],
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        labelColor: Colors.white, // Active tab text color
        unselectedLabelColor: Colors.grey, // Inactive tab text color
        labelStyle: TextStyle(
          fontFamily: "benne",
          fontSize: 16,
        ),
        tabs: [
          Tab(text: 'Events'),
          Tab(text: 'Destinations'),
        ],indicatorSize: TabBarIndicatorSize.tab,indicatorPadding: EdgeInsets.all(8),dividerColor: Colors.black,
        padding: EdgeInsets.only(right: 10,left: 10,),
        // splashFactory: NoSplash.splashFactory,
      ),

    ),
    backgroundColor: Colors.black,
    body: TabBarView(
    children: [
    // Events Tab
    SingleChildScrollView(
    child: Column(
    children: [
    SizedBox(height: 10),
    ListView.builder(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    itemCount: 4, // Adjust based on your data source
    itemBuilder: (context, index) {
    return buildTicketCard(
    height,
    width,
    admingradient,
    "assets/image/camp munnar.jpeg",
    "Event Main Title $index",
      "Location details LIKE Suryanelli city, Munnar,Idukki",
    "Ticket No: SWE23RT61${10 + index}",

    );
    },
    ),
    ],
    ),
    ),

    // Destinations Tab
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
    height,
    width,
    admingradient,
    "assets/image/camp munnar.jpeg",
    "Destination Main Title $index",
      "Location Details LIKE Suryanelli city, Munnar,Idukki",
    "Ticket No: DST23RT61${10 + index}",
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
    double height,
    double width,
    Gradient gradient,
    String imagePath,
    String title,
    String location,
    String ticketNumber,
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
    image: DecorationImage(
    image: AssetImage(imagePath),
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
    Container(
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
    ],
    ),
    ),
    ),
    ],
    ),
    ),
    );


    // return DefaultTabController(
    //   length: 2,
    //   child: Scaffold(
    //     appBar: AppBar(
    //       bottom: TabBar(tabs: [
    //         Tab(text: 'Events',),
    //         Tab(text: 'Destinations',)
    //       ]),
    //       leading: Icon(Icons.arrow_back_ios_new_sharp,color: Colors.white,size: 40,),
    //       backgroundColor: Colors.black,
    //       title: Text("My Tickets",style: TextStyle(color: Colors.white,fontFamily: "bakbak",fontSize: 28),),
    //     ),
    //     backgroundColor: Colors.black,
    //     body: SingleChildScrollView(
    //       child:TabBarView(children: [
    //       Column(
    //       children: [
    //         SizedBox(height: 20,),
    //         ListView.builder(
    //           shrinkWrap: true,
    //           itemCount: 4,
    //           physics: ScrollPhysics(),
    //           itemBuilder: (context, index) {
    //           return Padding(
    //             padding: const EdgeInsets.all(5.0),
    //             child: Container(
    //               height: height / 6,
    //               width: width,
    //               decoration: BoxDecoration(
    //                 gradient: admingradient,
    //                 borderRadius: BorderRadius.circular(5),
    //               ),
    //               child: Row(
    //                 children: [
    //                   Container(
    //                     height: 500,
    //                     width: width / 2.5,
    //                     decoration: BoxDecoration(
    //                       image: DecorationImage(
    //                         image: AssetImage("assets/image/camp munnar.jpeg"),
    //                         fit: BoxFit.fitHeight,
    //                       ),
    //                     ),
    //                   ),
    //                   Expanded( // Ensures text takes only the remaining available space
    //                     child: Padding(
    //                       padding: const EdgeInsets.all(8.0),
    //                       child: Column(
    //                         crossAxisAlignment: CrossAxisAlignment.start, // Align text to the start
    //                         mainAxisAlignment: MainAxisAlignment.center, // Center vertically
    //                         children: [
    //                           Text(
    //                             "Campper Campwoody - Suryanelli Munnar",
    //                             style: TextStyle(
    //                               color: Colors.white,
    //                               fontFamily: "cinzel",
    //                               fontSize: 12,
    //                             ),
    //                             softWrap: true, // Allows wrapping to the next line
    //                             textAlign: TextAlign.left,
    //                             overflow: TextOverflow.ellipsis, // Shows ellipsis if text overflows
    //                           ),
    //                           Text(
    //                             "Campper Campwoody - Suryanelli Munnar",
    //                             style: TextStyle(
    //                               color: Colors.white,
    //                               fontFamily: "didact",
    //                               fontSize: 9,
    //                             ),
    //                             softWrap: true, // Allows wrapping to the next line
    //                             textAlign: TextAlign.left,
    //                             overflow: TextOverflow.ellipsis, // Shows ellipsis if text overflows
    //                           ),
    //                            SizedBox(height: 10,),
    //
    //                            Text("Ticket No: SWE23RT6112",style: TextStyle(color: Colors.white,fontFamily: "didact",fontSize: 15),),
    //                            SizedBox(height: 8,),
    //                            Container(
    //                              width: 90,height: 40,decoration: BoxDecoration(border: Border.all(color: Colors.brown),
    //                                borderRadius:BorderRadius.circular(20) ,),
    //                              child: Center(child: Text("Details",style: TextStyle(color: Colors.white,fontFamily: "didact",fontSize: 15),)),
    //                            )
    //
    //                         ],
    //                       ),
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //
    //
    //
    //             //     // SizedBox(height: 2,),
    //               //     // Row(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
    //               //     //   children: [
    //               //     //     Image.asset("assets/image/tickets.png",
    //               //     //         width: 20,
    //               //     //         height: 20,),
    //               //     //         Column(
    //               //     //           children: [
    //               //     //             Text("Campper Campwoody - Suryanelli Munnar",style: TextStyle(color: Colors.white,fontFamily: "cinzel",fontSize: 15),
    //               //     //             softWrap: true,
    //               //     //               textAlign: TextAlign.left,
    //               //     //               overflow: TextOverflow.visible,
    //               //     //             ),
    //               //     //           ],
    //               //     //         ),
    //               //
    //               //       //     Column(
    //               //       //       mainAxisAlignment: MainAxisAlignment.end,crossAxisAlignment: CrossAxisAlignment.end,
    //               //       // children: [
    //               //       //   Text("Campper Campwoody - Suryanelli Munnar",style: TextStyle(color: Colors.white,fontFamily: "cinzel",fontSize: 15),
    //               //       //   softWrap: true,
    //               //       //   textAlign: TextAlign.left,
    //               //       //   overflow: TextOverflow.visible,
    //               //       //   ),
    //               //       //   Text("₹150",style: TextStyle(color: Colors.white,fontFamily: "cinzel",fontSize: 30),
    //               //       //     textAlign: TextAlign.left,
    //               //       //
    //               //       //   )
    //               //       //
    //               //       //     ],
    //               //       //   ),
    //               //     // SizedBox(height: 25,),
    //               //     // Padding(
    //               //     //   padding: const EdgeInsets.only(left: 200),
    //               //     //   child: Row(
    //               //     //     children: [
    //               //     //       Container(
    //               //     //         height: 40,
    //               //     //         width: 150,
    //               //     //         decoration: BoxDecoration(
    //               //     //             color: Colors.black,
    //               //     //             borderRadius: BorderRadius.circular(30)
    //               //     //         ),
    //               //     //         child: Row(mainAxisAlignment: MainAxisAlignment.center,
    //               //     //           children: [
    //               //     //             Image.asset("assets/image/tickets.png",
    //               //     //               width: 20,
    //               //     //               height: 20,),
    //               //     //             Center(
    //               //     //               child: Text(" Details",style: TextStyle(color: Colors.white,fontFamily: "baloo",fontSize: 12),),
    //               //     //             ),
    //               //     //           ],
    //               //     //         ),
    //               //     //       ),
    //               //     //       // Padding(
    //               //     //       //   padding: const EdgeInsets.only(left: 200),
    //               //     //       //   child: Row(
    //               //     //       //     children: [
    //               //     //       //       Container(
    //               //     //       //         height: 40,
    //               //     //       //         width: 150,
    //               //     //       //         decoration: BoxDecoration(
    //               //     //       //             color: Colors.black,
    //               //     //       //             borderRadius: BorderRadius.circular(30)
    //               //     //       //         ),
    //               //     //       //         child: Row(mainAxisAlignment: MainAxisAlignment.center,
    //               //     //       //           children: [
    //               //     //       //             Image.asset("assets/image/tickets.png",
    //               //     //       //               width: 20,
    //               //     //       //               height: 20,),
    //               //     //       //             Center(
    //               //     //       //               child: Text(" Details",style: TextStyle(color: Colors.white,fontFamily: "baloo",fontSize: 12),),
    //               //     //       //             ),
    //               //     //       //           ],
    //               //     //       //         ),
    //               //     //       //       ),
    //               //     //       //     ],
    //               //     //       //
    //               //     //       //   ),
    //               //     //       // ),
    //               //     //     ],
    //               //     //
    //               //     //   ),
    //               //     // ),
    //               //     // SizedBox(height: 50,),
    //               //
    //               //
    //               //
    //               //
    //               //     // ],
    //               //     // ),
    //               //     // SizedBox(height: 5,),
    //               //     // Text("Ticket Number",style: TextStyle(color: Colors.white,fontFamily: "bakbak",fontSize: 10),),
    //               //     // SizedBox(height: 6,),
    //               //     // Text("w345",style: TextStyle(color: cstText,fontSize: 15,fontFamily: "philosopher"),),
    //               //     // SizedBox(height: 6,),
    //               //   // SizedBox(height: 2,),
    //               //   //   Row(mainAxisAlignment: MainAxisAlignment.start,
    //               //   //     children: [
    //               //         // Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
    //               //         //  children: [
    //               //         //    Text("Date and Hour",style: TextStyle(color: cstText,fontWeight: FontWeight.bold,fontSize: 10),),
    //               //         //    Text("August 1,2024-11.00 AM",style: TextStyle(color: cstText,fontSize: 15,fontFamily: "philosopher"),),
    //               //         //
    //               //         //  ],
    //               //         // ),
    //               //         // Container(
    //               //         //   height: 40,
    //               //         //   width: 150,
    //               //         //   decoration: BoxDecoration(
    //               //         //       color: Colors.black,
    //               //         //       borderRadius: BorderRadius.circular(30)
    //               //         //   ),
    //               //         //   child: Row(mainAxisAlignment: MainAxisAlignment.center,
    //               //         //     children: [
    //               //         //     Image.asset("assets/image/tickets.png",
    //               //         //             width: 20,
    //               //         //             height: 20,),
    //               //         //       Center(
    //               //         //           child: Text(" Details",style: TextStyle(color: Colors.white,fontFamily: "baloo",fontSize: 12),),
    //               //         //       ),
    //               //         //     ],
    //               //         //   ),
    //               //         // ),
    //               //
    //               //       // ],
    //               //     // ),
    //               //     // Text("August 1,2024,11.00 AM",style: TextStyle(color: cstText,fontSize: 15,fontFamily: "philosopher"),),
    //               //
    //               //   ],
    //               // ),
    //
    //
    //           );
    //         },)
    //       ],
    //     ),
    //   ])
    //     )
    //   ),
    // );
  }
}
