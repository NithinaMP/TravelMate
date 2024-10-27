import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/constant_colors.dart';

class MyTicketScreen extends StatelessWidget {
  const MyTicketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back_ios_new_sharp,color: Colors.white,size: 32,),
        backgroundColor: Colors.black,
        title: Text("My Tickets",style: TextStyle(color: Colors.white,fontFamily: "bakbak",fontSize: 25),),
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: 3,
            physics: ScrollPhysics(),
            itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height:height/5 ,
                width: width,
                decoration: BoxDecoration(
                    // image: DecorationImage(image: AssetImage("assets/image/camp munnar.jpeg"),
                // fit: BoxFit.fill),
                  gradient: admingradient,
                  borderRadius: BorderRadius.circular(5)
                ),

                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height:height/10 ,
                        width: width,
                        decoration: BoxDecoration(
                          image: DecorationImage(image: AssetImage("assets/image/camp munnar.jpeg"),
                          fit: BoxFit.fitWidth),
                            gradient: admingradient,
                            borderRadius: BorderRadius.circular(5)
                        ),
                      ),
                      // SizedBox(height: 2,),
                      // Row(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     Image.asset("assets/image/tickets.png",
                      //         width: 20,
                      //         height: 20,),
                      //         Column(
                      //           children: [
                      //             Text("Campper Campwoody - Suryanelli Munnar",style: TextStyle(color: Colors.white,fontFamily: "cinzel",fontSize: 15),
                      //             softWrap: true,
                      //               textAlign: TextAlign.left,
                      //               overflow: TextOverflow.visible,
                      //             ),
                      //           ],
                      //         ),

                            Column(mainAxisAlignment: MainAxisAlignment.end,crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text("Campper Campwoody - Suryanelli Munnar",style: TextStyle(color: Colors.white,fontFamily: "cinzel",fontSize: 15),
                          softWrap: true,
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.visible,
                          ),
                          Text("₹150",style: TextStyle(color: Colors.white,fontFamily: "cinzel",fontSize: 30),
                            textAlign: TextAlign.left,

                          )

                            ],
                          ),
                      // SizedBox(height: 25,),
                      Padding(
                        padding: const EdgeInsets.only(left: 200),
                        child: Row(
                          children: [
                            Container(
                              height: 40,
                              width: 150,
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(30)
                              ),
                              child: Row(mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset("assets/image/tickets.png",
                                    width: 20,
                                    height: 20,),
                                  Center(
                                    child: Text(" Details",style: TextStyle(color: Colors.white,fontFamily: "baloo",fontSize: 12),),
                                  ),
                                ],
                              ),
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.only(left: 200),
                            //   child: Row(
                            //     children: [
                            //       Container(
                            //         height: 40,
                            //         width: 150,
                            //         decoration: BoxDecoration(
                            //             color: Colors.black,
                            //             borderRadius: BorderRadius.circular(30)
                            //         ),
                            //         child: Row(mainAxisAlignment: MainAxisAlignment.center,
                            //           children: [
                            //             Image.asset("assets/image/tickets.png",
                            //               width: 20,
                            //               height: 20,),
                            //             Center(
                            //               child: Text(" Details",style: TextStyle(color: Colors.white,fontFamily: "baloo",fontSize: 12),),
                            //             ),
                            //           ],
                            //         ),
                            //       ),
                            //     ],
                            //
                            //   ),
                            // ),
                          ],

                        ),
                      ),
                      SizedBox(height: 50,),




                      // ],
                      // ),
                      // SizedBox(height: 5,),
                      // Text("Ticket Number",style: TextStyle(color: Colors.white,fontFamily: "bakbak",fontSize: 10),),
                      // SizedBox(height: 6,),
                      // Text("w345",style: TextStyle(color: cstText,fontSize: 15,fontFamily: "philosopher"),),
                      // SizedBox(height: 6,),
                    // SizedBox(height: 2,),
                    //   Row(mainAxisAlignment: MainAxisAlignment.start,
                    //     children: [
                          // Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
                          //  children: [
                          //    Text("Date and Hour",style: TextStyle(color: cstText,fontWeight: FontWeight.bold,fontSize: 10),),
                          //    Text("August 1,2024-11.00 AM",style: TextStyle(color: cstText,fontSize: 15,fontFamily: "philosopher"),),
                          //
                          //  ],
                          // ),
                          // Container(
                          //   height: 40,
                          //   width: 150,
                          //   decoration: BoxDecoration(
                          //       color: Colors.black,
                          //       borderRadius: BorderRadius.circular(30)
                          //   ),
                          //   child: Row(mainAxisAlignment: MainAxisAlignment.center,
                          //     children: [
                          //     Image.asset("assets/image/tickets.png",
                          //             width: 20,
                          //             height: 20,),
                          //       Center(
                          //           child: Text(" Details",style: TextStyle(color: Colors.white,fontFamily: "baloo",fontSize: 12),),
                          //       ),
                          //     ],
                          //   ),
                          // ),

                        // ],
                      // ),
                      // Text("August 1,2024,11.00 AM",style: TextStyle(color: cstText,fontSize: 15,fontFamily: "philosopher"),),

                    ],
                  ),
                ),
              ),
            );
          },)
        ],
      ),
    )
    );
  }
}
