// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
//
// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.green,
//         title: Text("TravelMate",style: TextStyle(fontFamily: "bakbak"),),
//         centerTitle: true,
//         leading: Builder(
//
//           builder: (BuildContext context) {
//             return IconButton(
//               icon:  Image.asset("assets/icons/Bar chart-2.png",scale: 5,),
//               onPressed: () {
//                 Scaffold.of(context).openDrawer();
//               },
//               tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
//             );
//           },
//         ),
//
//       ),
//       backgroundColor: Colors.black,
//     drawer: Drawer(
//       backgroundColor: Colors.orange,
//       child: ListView(
//         children: [
//           UserAccountsDrawerHeader(
//               accountName: Text("Nithina",style: TextStyle(color: Colors.white),),
//               accountEmail:Text("nithina@gmail.com",style: TextStyle(color: Colors.white)),
//               currentAccountPicture: CircleAvatar(
//                 backgroundImage: AssetImage("assets/getstarted.jpg"),
//               ),
//           )
//         ],
//       ),
//     ),
//
//       body: Column(
//
//       ),
//     );
//   }
// }

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/painting.dart';
// import 'package:flutter/widgets.dart';
// import 'package:travelmate/user/profileScreen.dart';
// import 'package:travelmate/user/wishListScreen.dart';
// import '../constants/constant_colors.dart';
// import 'myTicketScreen.dart';
//
//
// class UserHomePage extends StatelessWidget {
//   const UserHomePage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     List<String> images=[
//       "assets/image/travel3.jpg",
//       "assets/jadayupara.jpeg",
//       "assets/image/ooty.jpeg",
//       "assets/image/varkala.jpeg",
//     ];
//     var width=MediaQuery.of(context).size.width;
//     var height=MediaQuery.of(context).size.height;
//
//     return Container(
//       decoration: BoxDecoration(
//         gradient: loginGradient,
//       ),
//       child: Scaffold(
//         backgroundColor: Colors.black,
//         // backgroundColor: Colors.transparent,
//         // extendBodyBehindAppBar: true,
//         appBar: AppBar(
//           backgroundColor: Colors.transparent,
//           elevation: 0,
//           title: Text("TravelMate",style: TextStyle(fontFamily: "tradeWinds",fontSize: 25,color: Colors.white),),
//
//                   leading: Builder(
//
//             builder: (BuildContext context) {
//               return IconButton(
//                 icon:   Image.asset("assets/icons/Bar chart-2.png",scale: 5,),
//                 onPressed: () {
//                   Scaffold.of(context).openDrawer();
//                 },
//                 tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
//               );
//             },
//           ),
//         ),
//
//         drawer: Drawer(
//           backgroundColor: cstOrange1,
//           child: ListView(
//             children: [
//
//               Container(
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [
//                       Color(0xffCBB480),
//                       Color(0xff632B05)
//
//                     ],
//                     begin: Alignment.topCenter,
//                     end: Alignment.bottomCenter,
//                   ),
//                 ),
//                 child: UserAccountsDrawerHeader(
//                   decoration: BoxDecoration(
//                     border: Border(
//                       bottom: BorderSide.none,
//                     ),
//                     color: Colors.transparent, // Make the background transparent
//                   ),
//
//                   accountName: Text(
//                     "Nithina",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontFamily: "muktaregular",
//                       fontSize: 20,
//                     ),
//                   ),
//                   accountEmail: Text(
//                     "nithina@gmail.com",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontFamily: "muktaregular",
//                       fontSize: 16,
//                     ),
//                   ),
//                   currentAccountPicture: CircleAvatar(
//                     backgroundImage: AssetImage("assets/icons/profile-thin.png"),
//                     // backgroundColor: cstgreen,
//                   ),
//                 ),
//               ),
//               // Container(color: Colors.red,height: 5,),
//               ListTile(
//                 leading: Image.asset("assets/image/profile.png", scale: 5),
//                 title: Text(
//                   "PROFILE",
//                   style: TextStyle(
//                     fontFamily: "philosopher",
//                     fontSize: 16,
//                     color: Colors.white,
//                   ),
//                 ),
//                 onTap: () {
//                   Navigator.push(context, MaterialPageRoute(
//                     builder: (context) => ProfileScreen(),
//                   )
//                   );
//                 },
//               ),
//               ListTile(
//                 leading: Image.asset("assets/image/tickets.png", scale: 6),
//                 title: Text(
//                   "MY TICKETS",
//                   style: TextStyle(
//                     fontFamily: "philosopher",
//                     fontSize: 16,
//                     color: Colors.white,
//                   ),
//                 ),
//                 onTap: () {
//                   Navigator.push(context, MaterialPageRoute(
//                     builder:(context) => MyTicketScreen(),
//                   )
//                   );
//                 },
//               ),
//               ListTile(
//                 leading: Image.asset("assets/image/signout.png", scale: 5),
//                 title: Text(
//                   "SIGN OUT",
//                   style: TextStyle(
//                     fontFamily: "philosopher",
//                     fontSize: 16,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         body: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(10),
//             child: Column (
//               children: [
//                 Container(
//                   decoration: BoxDecoration(
//                     color: Colors.black
//                   ),
//                   child: Column(crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//
//                       Container(
//                         height: height / 13,
//                         decoration: BoxDecoration(
//                             gradient: containerGradient,
//                             borderRadius: BorderRadius.circular(20)),
//                         child: TextFormField(
//
//
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontFamily: "muktaregular",
//                           ),
//                           decoration: InputDecoration(
//                                 border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(20)),
//                             // label: Text(
//                             //   "USER NAME",
//                             //   style: TextStyle(
//                             //       color: Colors.white,
//                             //       fontFamily: "muktaregular",
//                             //       fontWeight: FontWeight.w500),
//                             // ),
//                             hintText: "Search here",
//                             hintStyle: TextStyle(color: Colors.white),
//                             focusedBorder: OutlineInputBorder(
//                                 borderSide: BorderSide.none,
//                                 borderRadius: BorderRadius.circular(20)),
//                             enabledBorder: OutlineInputBorder(
//                                 borderSide: BorderSide.none,
//                                 borderRadius: BorderRadius.circular(20)),
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: 20,),
//                       Container(
//                         height: height/3,
//                         width: width,
//                         decoration: BoxDecoration(
//                           gradient: containerRGradient,
//                           borderRadius: BorderRadius.circular(20)
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.only(left: 10,right: 10,top: 30),
//                           child: Container(
//                             height: height/3,
//                             width: width,
//                             decoration: BoxDecoration(
//                               image: DecorationImage(image: AssetImage("assets/image/ooty.jpeg"),
//                                 fit: BoxFit.fill
//                               ),
//
//                               borderRadius: BorderRadius.circular(20)
//                             ),
//                           ),
//                         ),
//                       ),
//
//                       Padding(
//                         padding: const EdgeInsets.only(left: 8.0,top: 10),
//                         child: Text("Recommended for you",style: TextStyle(color: Colors.white,fontFamily: "bakbak",fontSize: 18),),
//                       ),
//                       SizedBox(height: 5,),
//                       ListView.builder(
//                           itemCount: images.length,
//                           physics: ScrollPhysics(),
//                           shrinkWrap: true,
//                           itemBuilder: (context, index) {
//                             return Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Column(
//                                 children: [
//                                   Container(
//                                     height: height/3.75,
//                                     width: width,
//                                     decoration: BoxDecoration(
//                                         color: Colors.red,
//                                         borderRadius: BorderRadius.circular(20),
//                                         image: DecorationImage(image: AssetImage(images[index]),
//
//                                             fit: BoxFit.fill
//                                         )
//                                     ),
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(8.0),
//                                       child: Column(mainAxisAlignment: MainAxisAlignment.start,
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         children: [
//                                           SizedBox(
//                                             height: height/7,
//                                           ),
//                                           Text("Munnar",style: TextStyle(color:Colors.yellow,fontWeight: FontWeight.bold,fontSize: 30),),
//                                           Text("Iduki",style: TextStyle(color:Colors.yellow,fontWeight: FontWeight.bold,fontSize: 20),),
//                                         ],
//                                       ),
//                                     ),
//
//
//                                     // ),
//                                   )],
//                               ),
//                             );
//                           }),
//
//
//                     ],
//                   ),
//                 ),
//
//               ],
//
//             ),
//           ),
//         ),
//         bottomNavigationBar: Container(
//             height: 65,
//             width: 350,
//             color: Colors.teal,
//
//             child:Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(right: 70,top: 10),
//                   child: InkWell(onTap:  () {
//                     Navigator.push(context, MaterialPageRoute(builder: (context) => UserHomePage(),));
//                   },
//                     child: Column(
//                       children: [
//                         Icon(Icons.home,color:Colors.white,),
//                         Text("Home",style: TextStyle(
//                             color: Colors.white,fontFamily: "allerta"
//                         ),),
//                       ],
//                     ),
//                   ),
//                 ),
//
//                 InkWell(onTap: () {
//                   Navigator.push(context, MaterialPageRoute(builder: (context) => WishlistScreen(),));
//                 },
//                   child: Padding(
//                     padding: const EdgeInsets.only(right:80,top: 10),
//                     child: Column(
//                       children: [
//                         // Image.asset("assets/icons/like.png",scale: 7,color:  Colors.red,),
//                         Icon(Icons.shopping_cart_outlined,color: Colors.white,),
//                         Text("Wish",style: TextStyle(
//                             color:  Colors.red,fontFamily: "allerta"
//                         ),),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(top:10),
//                   child: InkWell(onTap: () {
//                     Navigator.push(context, MaterialPageRoute(builder: (context) =>  ProfileScreen(),));
//                   },
//                     child: Column(
//                       children: [
//                         Icon(Icons.shopping_cart_outlined,color:  Colors.red,),
//                         Text("Cart",style: TextStyle(
//                             color:  Colors.red,fontFamily: "allerta"
//                         ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//
//               ],
//             )
//         ),
//       ),
//     );
//   }
// }
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:travelmate/user/profileScreen.dart';
import 'package:travelmate/user/profileView.dart';
import 'package:travelmate/user/wishListScreen.dart';

import '../constants/constant_colors.dart';
import 'destinationScreen.dart';
import 'myTicketScreen.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({super.key});

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  int activeIndex = 0;

  void carouselIndex(int index) {
    setState(() {
      activeIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    var images=[
      "assets/image/img1.jpg",
      "assets/image/munnar.jpeg",
      "assets/image/varkala.jpeg",
      "assets/image/img1.jpg",
      // "assets/image/img2.jpg",
      // "assets/image/img3.jpg",
      // "assets/image/img4.jpg",
    ];
    List<Map<String, String>> destinations = [
      {
        "image": "assets/image/travel3.jpg",
        "name": "Malambuzha Dam",
        "location": "Malampuzha,Palakkad,Kerala"
      },
      {
        "image": "assets/image/jatayu.jpg",
        "name": "Jadayupara",
        "location": "Kollam, Kerala"
      },
      {
        "image": "assets/image/ranipuram-ksr.jpg",
        "name": "Ooty",
        "location": "Tamil Nadu"
      },
      {
        "image": "assets/image/munnar.jpeg",
        "name": "Varkala",
        "location": "Kerala"
      },
    ];

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue, Colors.purple],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            "TravelMate",
            style: TextStyle(
              fontFamily: "bakbak",
              fontSize: 28,
              color: Colors.white,
              // fontWeight: FontWeight.bold
            ),
          ),
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: Image.asset("assets/icons/Bar chart-2.png", scale: 4),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            },
          ),
        ),
        // drawer: Drawer(
        //   backgroundColor: Colors.orange,
        //   child: ListView(
        //     children: [
        //       UserAccountsDrawerHeader(
        //         accountName: Text(
        //           "Nithina",
        //           style: TextStyle(color: Colors.white),
        //         ),
        //         accountEmail: Text(
        //           "nithina@gmail.com",
        //           style: TextStyle(color: Colors.white),
        //         ),
        //         currentAccountPicture: CircleAvatar(
        //           backgroundImage: AssetImage("assets/getstarted.jpg"),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
    drawer: Drawer(
          backgroundColor: cstOrange1,
          child: ListView(
            children: [

              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xffBF641A),
                      Color(0xff592F0C),
                      Color(0xff000000)

                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide.none,
                    ),
                    color: Colors.transparent, // Make the background transparent
                  ),

                  accountName: Text(
                    "Nithina",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "muktaregular",
                      fontSize: 20,
                    ),
                  ),
                  accountEmail: Text(
                    "nithina@gmail.com",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "muktaregular",
                      fontSize: 16,
                    ),
                  ),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: AssetImage("assets/icons/profile-thin.png"),
                    // backgroundColor: cstgreen,
                  ),
                ),
              ),
              // Container(color: Colors.red,height: 5,),
              ListTile(
                leading: Image.asset("assets/image/profile.png", scale: 5),
                title: Text(
                  "PROFILE",
                  style: TextStyle(
                    fontFamily: "philosopher",
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => ProfileScreen(),
                  )
                  );
                },
              ),
              ListTile(
                leading: Image.asset("assets/image/tickets.png", scale: 6),
                title: Text(
                  "MY TICKETS",
                  style: TextStyle(
                    fontFamily: "philosopher",
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder:(context) => MyTicketScreen(),
                  )
                  );
                },
              ),
              ListTile(
                leading: Image.asset("assets/image/signout.png", scale: 5),
                title: Text(
                  "SIGN OUT",
                  style: TextStyle(
                    fontFamily: "philosopher",
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(color: Colors.black),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: height / 15,
                        decoration: BoxDecoration(
                          gradient: admingradient,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: TextFormField(
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: "didact",
                            ),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              icon: Icon(Icons.search_outlined,size: 30,color: Colors.grey,),
                              hintText: "Find out where you want to go!",
                              hintStyle: TextStyle(color: Colors.grey),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0,bottom: 10.0),
                        child: Text("Upcoming Events",
                          style: TextStyle(fontSize: 20,fontFamily: "bakbak",color: Colors.white),),
                      ),

                      CarouselSlider.builder(
                        itemCount: images.length,
                        itemBuilder: (context, index, realIndex) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Container(
                              height: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                  image: AssetImage(images[index]),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          );
                        },
                        options: CarouselOptions(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          height: MediaQuery.of(context).size.height / 2.75,
                          viewportFraction: 1,
                          autoPlay: true,
                          pageSnapping: true,
                          enlargeStrategy: CenterPageEnlargeStrategy.height,
                          enlargeCenterPage: true,
                          autoPlayInterval: const Duration(seconds: 4),
                          onPageChanged: (index, reason) {
                            carouselIndex(index);
                          },
                        ),
                      ),
                      const SizedBox(height: 16),
                      buildIndicator(images.length),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, top: 10),
                        child: Text(
                          "Recommended for you",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "bakbak",
                            fontSize: 18,
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      ListView.builder(
                        itemCount: destinations.length,
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DestinationScreen(
                                    imagePath: destinations[index]["image"]!,
                                    destinationName: destinations[index]["name"]!,
                                    location: destinations[index]["location"]!,
                                  ),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Container(
                                    height: height / 4.5,
                                    width: width,
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(20),
                                      image: DecorationImage(
                                        image: AssetImage(destinations[index]["image"]!),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 15.0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: height / 7,
                                          ),
                                          Text(
                                            destinations[index]["name"]!,
                                            style: TextStyle(
                                              color: Colors.white,fontFamily: "playfair",
                                              fontSize: 20,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Icon(Icons.place_outlined,color: Colors.white,size: 20,),
                                              Text(
                                                destinations[index]["location"]!,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: "benne",
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
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
          ),
        ),
    bottomNavigationBar: Container(
            height: 65,
            width: 350,
            color: Colors.black,

            child:Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 70,top: 10),
                  child: InkWell(onTap:  () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => UserHomePage(),));
                  },
                    child: Column(
                      children: [
                        Icon(Icons.home,color:Colors.white,size: 30,),
                        // Text("Home",style: TextStyle(
                        //     color: Colors.white,fontFamily: "allerta"
                        // ),
                // ),
                      ],
                    ),
                  ),
                ),

                InkWell(onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => WishlistScreen(),));
                },
                  child: Padding(
                    padding: const EdgeInsets.only(right:80,top: 10),
                    child: Column(
                      children: [
                        // Image.asset("assets/icons/like.png",scale: 7,color:  Colors.red,),
                        Icon(Icons.favorite_sharp,color: Colors.white,size: 30,),
                        // Text("Wish",style: TextStyle(
                        //     color:  Colors.white,fontFamily: "allerta"
                        // ),),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top:10),
                  child: InkWell(onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>  ProfileviewWIdget(),));
                  },
                    child: Column(
                      children: [
                        Icon(Icons.person_2_outlined,color:  Colors.white,size: 30,),
                        // Text("Account",style: TextStyle(
                        //     color:  Colors.white,fontFamily: "allerta"
                        // ),
                        // ),
                      ],
                    ),
                  ),
                ),

              ],
            )
        ),
      ),
    );
  }

  Widget buildIndicator(int length) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        length,
            (index) => Container(
          width: 8,
          height: 8,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: activeIndex == index ? Colors.blue : Colors.grey,
          ),
        ),
      ),
    );
  }
}


