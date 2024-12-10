import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:travelmate/constants/call_functions.dart';
import 'package:travelmate/constants/constant_colors.dart';
import 'package:travelmate/user/myTicketScreen.dart';
import 'package:travelmate/user/profileScreen.dart';

class ProfileviewWIdget extends StatelessWidget {
  const ProfileviewWIdget({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var hieght = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          "TravelMate",
          style: TextStyle(
              fontSize: 28,
              fontFamily: "bakbak",
              color: Colors.white,
              // fontWeight: FontWeight.bold
          ),
        ),
        leading: Image.asset(
          "assets/icons/Bar chart-2.png",
          scale: 4,
        ),
        backgroundColor: Colors.black,
      ),

      body: SingleChildScrollView(
        child: Column(

          children: [
            // SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: hieght / 3.5,
                ),

                  Padding(
                  padding: const EdgeInsets.only(left: 40),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 60,
                    child: Icon(Icons.image_rounded),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20,),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "User Name",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "benne",
                            fontSize: 25),
                      ),
                      Text(
                        "user@gmail.com",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "benne",
                            fontSize: 17),
                      ),
                      InkWell(
                        onTap: () {
                          callNext(context, ProfileScreen());
                        },
                        splashColor: Colors.transparent, // Remove splash color
                        highlightColor: Colors.transparent, // Remove highlight color
                        child: Container(height: 40,width: width/3,
                        decoration: BoxDecoration(border: Border.all(color: Colors.brown),
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                          child:
                          Text("Edit",style: TextStyle(color: Colors.white,fontFamily: "belleza",),),)),
                      ),

                    ],
                  ),
                ),

              ],
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(7.0),
                child: Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Container(
                          height: hieght/10,
                          width: width/1.05,
                          decoration: BoxDecoration(gradient: admingradient,borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                ListTile(
                                  leading: Image.asset("assets/image/tickets.png",height: 32,width: 32),
                                  title: Text("My Tickets",style: TextStyle(fontFamily: "benne",fontSize: 18,color: Colors.white),),
                                  subtitle: Text("Find booked tickets, price and more",style: TextStyle(fontFamily: "baloo",fontSize: 12,color: Colors.grey),),
                                  trailing: Icon(Icons.arrow_forward_ios_sharp,size: 20,color: Colors.white,),
                                  onTap: () {
                                    callNext(context, MyTicketScreen());
                                  },
                                )
                              ],
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Container(
                          height: hieght/10,
                          width: width/1.05,
                          decoration: BoxDecoration(gradient: admingradient,borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                ListTile(
                                  leading: Icon(Icons.favorite_outline,size: 32,color: Color(0xffD1A25f)),
                                  title: Text("Wish List",style: TextStyle(fontFamily: "benne",fontSize: 18,color: Colors.white),),
                                  subtitle: Text("Your favourite destinations and more",style: TextStyle(fontFamily: "baloo",fontSize: 12,color: Colors.grey),),
                                  trailing: Icon(Icons.arrow_forward_ios_sharp,size: 20,color: Colors.white,),
                                  onTap: () {},
                                )
                              ],
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Container(
                          height: hieght/10,
                          width: width/1.05,
                          decoration: BoxDecoration(gradient: admingradient,borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              children: [
                                ListTile(
                                  leading: Icon(Icons.sign_language_outlined,size: 32,color: Color(0xffD1A25f),),
                                  title: Text("Sign Out",style: TextStyle(fontFamily: "benne",fontSize: 18,color: Colors.white),),
                                  trailing: Icon(Icons.arrow_forward_ios_sharp,size: 20,color: Colors.white,),
                                  onTap: () {},
                                )
                              ],
                            ),
                          ),
                        ),
                      ),

                      // Container(
                      //   width: width/1.15,
                      //   height: hieght/10,
                      //   decoration: BoxDecoration(gradient: admingradient,borderRadius: BorderRadius.circular(20)),
                      //   child:
                      //   Padding(
                      //     padding: const EdgeInsets.only(left: 10),
                      //     child: Row(
                      //       children: [
                      //         Image.asset("assets/image/tickets.png",height: 20,width: 20,),
                      //         Padding(
                      //           padding: const EdgeInsets.all(8.0),
                      //           child: Text("My Tickets,events,liked,signout",style: TextStyle(color: Colors.white,fontFamily: "benne",fontSize: 20),),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),





                    // Container(
                    // width: width/1.15,
                    // height: hieght/10,
                    // decoration: BoxDecoration(gradient: admingradient,borderRadius: BorderRadius.circular(20)),
                    // child:
                    //   Padding(
                    //     padding: const EdgeInsets.only(left: 10),
                    //     child: Row(
                    //       children: [
                    //         Icon(Icons.favorite_outline,color: Color(0xffD1A25f),size: 22,),
                    //         Padding(
                    //           padding: const EdgeInsets.all(8.0),
                    //           child: Text("Events",style: TextStyle(color: Colors.white,fontFamily: "benne",fontSize: 20),),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    //   Container(
                    //     width: width/1.15,
                    //     height: hieght/10,
                    //     decoration: BoxDecoration(gradient: admingradient,borderRadius: BorderRadius.circular(20)),
                    //     child:
                    //     Padding(
                    //       padding: const EdgeInsets.only(left: 10),
                    //       child: Row(
                    //         children: [
                    //           Icon(Icons.favorite_outline,color: Color(0xffD1A25f),size: 22,),
                    //           Padding(
                    //             padding: const EdgeInsets.all(8.0),
                    //             child: Text("Wish List",style: TextStyle(color: Colors.white,fontFamily: "benne",fontSize: 20),),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    //   Container(
                    //     width: width/1.15,
                    //     height: hieght/10,
                    //     decoration: BoxDecoration(gradient: admingradient,borderRadius: BorderRadius.circular(20)),
                    //     child:
                    //     Padding(
                    //       padding: const EdgeInsets.only(left: 10),
                    //       child: Row(
                    //         children: [
                    //           Icon(Icons.favorite_outline,color: Color(0xffD1A25f),size: 22,),
                    //           Padding(
                    //             padding: const EdgeInsets.all(8.0),
                    //             child: Text("Sign Out",style: TextStyle(color: Colors.white,fontFamily: "benne",fontSize: 20),),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ),

                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
