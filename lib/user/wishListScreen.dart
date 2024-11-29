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
            style: TextStyle(fontFamily: "benne",fontSize: 32,color: Colors.white),),
          leading: Icon(Icons.arrow_back_ios_new_rounded,color: Colors.white,size: 40,),
          backgroundColor: Colors.black,
        ),
        body: SingleChildScrollView(
          child: Column(
              children: [
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
              mainAxisSpacing: 5,
              crossAxisSpacing: 12,
              mainAxisExtent: 200,
            ),
            itemBuilder: (context, index) {

              return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    image: DecorationImage(
                      image: AssetImage(images[index]),
                      fit: BoxFit.fill,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                Text("malampuzha", style: TextStyle(color: Colors.white, fontSize: 15, fontFamily: "philosopher")),
                Text("20", style: TextStyle(color: Colors.white, fontSize: 10, fontFamily: "bakbak")),
              ]);
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
    //                 Icon(Icons.home,color:Colors.white,),
    //                 Text("Home",style: TextStyle(
    //                     color: Colors.white,fontFamily: "allerta"
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
    //                 Icon(Icons.favorite,color: Colors.red,),
    //                 Text("Wish",style: TextStyle(
    //                     color:  Colors.white,fontFamily: "allerta"
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
    //               children: [
    //                 Icon(Icons.person,color:  Colors.white,),
    //                 Text("Account",style: TextStyle(
    //                     color:  Colors.white,fontFamily: "allerta"
    //                 ),
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
