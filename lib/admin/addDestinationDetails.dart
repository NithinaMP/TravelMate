import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelmate/constants/call_functions.dart';
import 'package:travelmate/constants/constant_colors.dart';
import 'package:travelmate/provider/mainProvider.dart';

import 'addDestinationScreen.dart';
import 'addEventScreen.dart';

class AddDestinationDetailsScreen extends StatelessWidget {
  const AddDestinationDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(leading: Icon(Icons.arrow_back_ios_new_sharp,color: Colors.white,size: 32,),
        title: Text("Add Destination", style: TextStyle(color: Colors.white,fontFamily: "bakbak",fontSize: 25),
        ),
        backgroundColor: Colors.black,
      ),
      floatingActionButton: FloatingActionButton(shape: UnderlineInputBorder(borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide(
          color: Color(0xff351C08),width: 1,)
     ),elevation: 100,highlightElevation: 100,
        backgroundColor:Colors.white ,
        child: Icon(Icons.add,size: 50,color: Color(0xff351C08),
        ),

        onPressed: () {
          callNext(context, AddDestinationScreen());
          // eventAddingAlertBox(context,width,height);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: SingleChildScrollView(
        child:Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15,right: 10,left: 10),
                  child: Container(
                    width: width,
                    height: height/4,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image:AssetImage("assets/image/munnar2.jpg"),
                          fit: BoxFit.cover,
                        ),borderRadius: BorderRadius.circular(15)
                    ),
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 50,width: 180,
                            decoration: BoxDecoration(
                              gradient: admingradient,borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.edit,color: Colors.white,size: 20,),
                                Text(" Edit details",style: TextStyle(color: Colors.white,fontFamily: "bakbak",fontSize: 14),)

                              ],
                            ),
                          ),
                        ),

                      ],
                    ) ,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 15,right: 10,left: 10),
                  child: Container(
                    width: width,
                    height: height/4,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                      image:AssetImage("assets/image/travel3.jpg"),
                        fit: BoxFit.cover,
                      ),borderRadius: BorderRadius.circular(15)
                  ),
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                       crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 50,width: 180,
                          decoration: BoxDecoration(
                            gradient: admingradient,borderRadius: BorderRadius.circular(30),
                          ),
                          child: Row(mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.edit,color: Colors.white,size: 20,),
                              Text(" Edit details",style: TextStyle(color: Colors.white,fontFamily: "bakbak",fontSize: 14),)

                            ],
                          ),
                        ),
                      ),

                      ],
                    ) ,
                ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15,right: 10,left: 10),
                  child: Container(
                    width: width,
                    height: height/4,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image:AssetImage("assets/image/ranipuram-ksr.jpg"),
                          fit: BoxFit.cover,
                        ),borderRadius: BorderRadius.circular(15)
                    ),
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 50,width: 180,
                            decoration: BoxDecoration(
                              gradient: admingradient,borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.edit,color: Colors.white,size: 20,),
                                Text(" Edit details",style: TextStyle(color: Colors.white,fontFamily: "bakbak",fontSize: 14),)

                              ],
                            ),
                          ),
                        ),

                      ],
                    ) ,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 15,right: 10,left: 10),
                  child: Container(
                    width: width,
                    height: height/4,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image:AssetImage("assets/jadayupara.jpeg"),
                          fit: BoxFit.cover,
                        ),borderRadius: BorderRadius.circular(15)
                    ),
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 50,width: 180,
                            decoration: BoxDecoration(
                              gradient: admingradient,borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.edit,color: Colors.white,size: 20,),
                                Text(" Edit details",style: TextStyle(color: Colors.white,fontFamily: "bakbak",fontSize: 14),)

                              ],
                            ),
                          ),
                        ),

                      ],
                    ) ,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15,right: 10,left: 10),
                  child: Container(
                    width: width,
                    height: height/4,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image:AssetImage("assets/image/travel3.jpg"),
                          fit: BoxFit.cover,
                        ),borderRadius: BorderRadius.circular(15)
                    ),
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 50,width: 180,
                            decoration: BoxDecoration(
                              gradient: admingradient,borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.edit,color: Colors.white,size: 20,),
                                Text(" Edit details",style: TextStyle(color: Colors.white,fontFamily: "bakbak",fontSize: 14),)

                              ],
                            ),
                          ),
                        ),

                      ],
                    ) ,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15,right: 10,left: 10),
                  child: Container(
                    width: width,
                    height: height/4,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image:AssetImage("assets/image/munnar2.jpg"),
                          fit: BoxFit.cover,
                        ),borderRadius: BorderRadius.circular(15)
                    ),
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 50,width: 180,
                            decoration: BoxDecoration(
                              gradient: admingradient,borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.edit,color: Colors.white,size: 20,),
                                Text(" Edit details",style: TextStyle(color: Colors.white,fontFamily: "bakbak",fontSize: 14),)

                              ],
                            ),
                          ),
                        ),

                      ],
                    ) ,
                  ),
                ),

              ],
        )
      //   child: Column(
      //     children: [
      //       // Wrapping the ListView.builder inside a Container with constrained height
      //       Container(
      //         height: height * 0.8, // Set appropriate height for ListView
      //         child: ListView.builder(
      //           shrinkWrap: true,
      //           itemCount: 2,
      //           physics: ScrollPhysics(),
      //           itemBuilder: (context, index) {
      //             return Padding(
      //               padding: const EdgeInsets.all(8.0),
      //               child: Container(
      //                 height: 130,
      //                 width: width,
      //                 decoration: BoxDecoration(color: Color(0xffB6A683)),
      //                 child: Row(
      //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                   children: [
      //                     Row(
      //                       children: [
      //                         Padding(
      //                           padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
      //                           child: Image.asset(
      //                             'assets/image/ooty.jpeg',
      //                           ),
      //                         ),
      //                         Padding(
      //                           padding: const EdgeInsets.all(8.0),
      //                           child: Column(
      //                             crossAxisAlignment: CrossAxisAlignment.start,
      //                             children: [
      //                               Text(
      //                                 "ooty flowershow",
      //                                 style: TextStyle(
      //                                     fontFamily: "muktamedium",
      //                                     fontSize: 18),
      //                               ),
      //                               Text(
      //                                 "tamilnadu",
      //                                 style: TextStyle(
      //                                     fontFamily: "muktamedium",
      //                                     fontSize: 18),
      //                               ),
      //                               Text(
      //                                 "1 week",
      //                                 style: TextStyle(
      //                                     fontFamily: "muktamedium",
      //                                     fontSize: 18),
      //                               ),
      //                               Text(
      //                                 "Rs : 99",
      //                                 style: TextStyle(
      //                                     fontFamily: "muktamedium",
      //                                     fontSize: 18),
      //                               ),
      //                             ],
      //                           ),
      //                         ),
      //                       ],
      //                     ),
      //                     // Padding(
      //                     //   padding: const EdgeInsets.only(right: 10),
      //                     //   child: GestureDetector(
      //                     //     onTap: () {
      //                     //       // Add deletion logic here
      //                     //     },
      //                     //     // child: Image.asset(
      //                     //     //   "assets/icons/delete.png",
      //                     //     //   scale: 20,
      //                     //     // ),
      //                     //   ),
      //                     // ),
      //                   ],
      //                 ),
      //               ),
      //             );
      //           },
      //         ),
      //       ),
      //     ],
      //   ),

      )
    );
  }
}
