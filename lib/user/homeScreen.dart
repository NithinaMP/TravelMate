
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelmate/provider/loginProvider.dart';
import 'package:travelmate/provider/mainProvider.dart';
import 'package:travelmate/user/profileScreen.dart';
import 'package:travelmate/user/wishListScreen.dart';

import '../constants/constant_colors.dart';
import 'destinationScreen.dart';
import 'myTicketScreen.dart';

class UserHomePage extends StatefulWidget {
  String userID;
  UserHomePage({super.key,required this.userID});

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
      child: GestureDetector(
        onTap: FocusScope.of(context).unfocus,
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


          // drawer: Consumer<LoginProvider>(
          //   builder: (context2,dValue,child) {
          //     return Drawer(
          //       backgroundColor: Color(0xff100801),
          //       child: ListView(
          //         children: [
          //
          //           Container(
          //             decoration: BoxDecoration(
          //               gradient: LinearGradient(
          //                 colors: [
          //                   Color(0xffBF641A),
          //                   Color(0xff592F0C),
          //                   Color(0xff000000)
          //
          //                 ],
          //                 begin: Alignment.topCenter,
          //                 end: Alignment.bottomCenter,
          //               ),
          //             ),
          //             child: UserAccountsDrawerHeader(
          //               decoration: BoxDecoration(
          //                 border: Border(
          //                   bottom: BorderSide.none,
          //                 ),
          //                 color: Colors.transparent, // Make the background transparent
          //               ),
          //
          //               accountName: Text(
          //                dValue.loginName,
          //                 style: TextStyle(
          //                   color: Colors.white,
          //                   fontFamily: "muktaregular",
          //                   fontSize: 20,
          //                 ),
          //               ),
          //               accountEmail: Text(dValue.loginPhone,
          //                 style: TextStyle(
          //                   color: Colors.white,
          //                   fontFamily: "muktaregular",
          //                   fontSize: 16,
          //                 ),
          //               ),
          //               currentAccountPicture: CircleAvatar(
          //                 backgroundImage: AssetImage("assets/icons/profile-thin.png"),
          //                 // backgroundColor: cstgreen,
          //               ),
          //             ),
          //           ),
          //           // Container(color: Colors.red,height: 5,),
          //           ListTile(
          //             leading: Image.asset("assets/image/profile.png", scale: 5),
          //             title: Text(
          //               "PROFILE",
          //               style: TextStyle(
          //                 fontFamily: "philosopher",
          //                 fontSize: 16,
          //                 color: Colors.white,
          //               ),
          //             ),
          //             onTap: () {
          //               Navigator.push(context, MaterialPageRoute(
          //                 builder: (context) => ProfileScreen(),
          //               )
          //               );
          //             },
          //           ),
          //           ListTile(
          //             leading: Image.asset("assets/image/tickets.png", scale: 6),
          //             title: Text(
          //               "MY TICKETS",
          //               style: TextStyle(
          //                 fontFamily: "philosopher",
          //                 fontSize: 16,
          //                 color: Colors.white,
          //               ),
          //             ),
          //             onTap: () {
          //               Navigator.push(context, MaterialPageRoute(
          //                 builder:(context) => MyTicketScreen(),
          //               )
          //               );
          //             },
          //           ),
          //           Consumer<MainProvider>(
          //             builder: (context,lgValue,child) {
          //               return InkWell(
          //                 onTap: () {
          //                   lgValue.logOutAlert(context);
          //                 },
          //                 child: ListTile(
          //                   leading: Image.asset("assets/image/signout.png", scale: 5),
          //                   title: Text(
          //                     "SIGN OUT",
          //                     style: TextStyle(
          //                       fontFamily: "philosopher",
          //                       fontSize: 16,
          //                       color: Colors.white,
          //                     ),
          //                   ),
          //                 ),
          //               );
          //             }
          //           ),
          //         ],
          //       ),
          //     );
          //   }
          // ),
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

                        Consumer<MainProvider>(
                          builder: (context, cValue, child) {
                            // Track the active index
                            int activeIndex = 0;  // Initialize with the first index

                            if (cValue.eventList.isEmpty) {
                              return Center(child: Text("No event available", style: TextStyle(color: Colors.white)));
                            }

                            return Column(
                              children: [
                                CarouselSlider.builder(
                                  itemCount: cValue.eventList.length,
                                  itemBuilder: (context, index, realIndex) {
                                    var carousel = cValue.eventList[index];
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      child: Container(
                                        height: 150,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(15),
                                          image: DecorationImage(
                                            image: NetworkImage(carousel.eventImage),
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
                                      // Update activeIndex when the page changes
                                      activeIndex = index;
                                    },
                                  ),
                                ),
                                SizedBox(height: 20,),
                                buildIndicator(cValue.eventList.length), // Display the indicator below the carousel
                              ],
                            );
                          },
                        ),
                        const SizedBox(height: 10),
                        // buildIndicator(images.length),
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
                        Consumer<MainProvider>(
                          builder: (context1,dValue,child) {
                            return ListView.builder(
                              itemCount: dValue.destinationList.length,
                              physics: ScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                var dest=dValue.destinationList[index];
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DestinationScreen(item: dest, userId: widget.userID,

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
                                              image: NetworkImage(dest.destImage),
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
                                                Text(dest.destName,
                                                  style: TextStyle(
                                                    color: Colors.white,fontFamily: "playfair",
                                                    fontSize: 20,
                                                  ),
                                                ),
                                                Text(
                                                  dest.destPlace,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: "benne",
                                                    fontSize: 14,
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
          ),

        ),
      ),
    );
  }

// Indicator Widget
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
            color: activeIndex == index ? Colors.blue : Colors.grey,  // Update active index color
          ),
        ),
      ),
    );
  }


}

