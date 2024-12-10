import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:travelmate/user/profileScreen.dart';

import 'homeScreen.dart';
class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> images=[
      "assets/image/img1.jpg",
      "assets/image/munnar.jpeg",
      "assets/image/img1.jpg",
      "assets/jadayupara.jpeg",
      "assets/image/ooty.jpeg",
      "assets/image/varkala.jpeg",
    ];
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text("Wishlist",
            style: TextStyle(fontFamily: "bakbak",fontSize: 28,color: Colors.white),),
          leading: Icon(Icons.arrow_back_ios_new_rounded,color: Colors.white,size: 40,),
          backgroundColor: Colors.black,
        ),
        body: SingleChildScrollView(
          child: Column(
              children: [SizedBox(height: 30,),
                // ListView.builder(
                //     itemCount: images.length,
                //     physics: ScrollPhysics(),
                //     shrinkWrap: true,
                //     itemBuilder: (context, index) {
                //       return Padding(
                //         padding: const EdgeInsets.all(8.0),
                //         child: Column(
                //           children: [
                //             Container(
                //               height: 200,
                //               width: 500,
                //               decoration: BoxDecoration(
                //                   color: Colors.red,
                //                   borderRadius: BorderRadius.circular(20),
                //                   image: DecorationImage(image: AssetImage(images[index]),
                //
                //                       fit: BoxFit.fill
                //                   )
                //               ),
                //
                //
                //               // ),
                //             )],
                //         ),
                //       );
                //     }),
          GridView.builder(
          padding: EdgeInsets.zero,
            itemCount: images.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 2,
              crossAxisSpacing: 7,
              mainAxisExtent: 250,
            ),
            itemBuilder: (context, index) {

              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center, // Aligns content to the left
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 160,
                      width: 190,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        image: DecorationImage(
                          image: AssetImage(images[index]),
                          fit: BoxFit.fill,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    SizedBox(height: 5), // Added spacing between elements
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              "Malampuzha Dam",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 19,
                                fontFamily: "benne",
                              ),
                              maxLines: 1, // Prevents the text from overflowing
                              overflow: TextOverflow.ellipsis, // Adds ellipsis if text is too long
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 6),
                            child: Container(
                              height: 35,
                              width: 60,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.brown),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  "&150",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "didact",
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8), // Align text to the left
                      child: Text(
                        "Palakkad, ghgfhguj, ggdhjdh ,djdhdfghgjhku, Kerala",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontFamily: "didact",
                        ),

                        softWrap: true, // Allows text to wrap to the next line
                        textAlign: TextAlign.left, // Aligns text to the left
                        overflow: TextOverflow.visible, // Prevents truncation or ellipsis
                      ),
                    ),
                  ],
                ),


              );
            },
          )
              ]
          ),
        ),
    //     bottomNavigationBar: Container(
    //     height: 65,
    //     width: 350,
    //     color: Colors.black,
    //
    //     child:Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //       children: [
    //         Padding(
    //           padding: const EdgeInsets.only(right: 70,top: 10),
    //           child: InkWell(onTap:  () {
    //             Navigator.push(context, MaterialPageRoute(builder: (context) => UserHomePage(),));
    //           },
    //             child: Column(
    //               children: [
    //                 Icon(Icons.home,color:Colors.white,size: 30,),
                    // Text("Home",style: TextStyle(
                    //     color: Colors.white,fontFamily: "allerta"
                    //                 ),),
    //               ],
    //             ),
    //           ),
    //         ),
    //
    //         InkWell(onTap: () {
    //           Navigator.push(context, MaterialPageRoute(builder: (context) => WishlistScreen(),));
    //         },
    //           child: Padding(
    //             padding: const EdgeInsets.only(right:80,top: 10),
    //             child: Column(
    //               children: [
    //                 // Image.asset("assets/icons/like.png",scale: 7,color:  Colors.red,),
    //                 Icon(Icons.favorite_outlined,
                      // color: Color(0xfffff176),
                      color: Color(0xffD1A25f),
                      size: 30,),
                    // Text("Wish",style: TextStyle(
                    //     color:  Colors.white,fontFamily: "allerta"
                    //                 ),),
    //               ],
    //             ),
    //           ),
    //         ),
    //         Padding(
    //           padding: const EdgeInsets.only(top:10),
    //           child: InkWell(onTap: () {
    //             Navigator.push(context, MaterialPageRoute(builder: (context) =>  ProfileScreen(),));
    //           },
    //             child: Column(
    //              children: [
    //                 Icon(Icons.person_2_outlined,color: Colors.white,size: 30,),
                    // Text("Account",style: TextStyle(
                    //     color:  Colors.white,fontFamily: "allerta"
                    // ),
                    //                 ),
    //               ],
    //             ),
    //           ),
    //         ),
    //
    //       ],
    //     )
    // ),
    );
  }
}
