import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:travelmate/admin/addDestinationDetails.dart';
import 'package:travelmate/admin/addEventDetailsScreen.dart';
import 'package:travelmate/admin/sample1.dart';
import 'package:travelmate/constants/call_functions.dart';
import 'package:travelmate/provider/loginProvider.dart';
import 'package:travelmate/provider/mainProvider.dart';
import 'package:travelmate/user/myTicketScreen.dart';

import '../constants/constant_colors.dart';
class adminhomeWidget extends StatelessWidget {
  const adminhomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("TravelMate",
        style:TextStyle(fontSize: 25,fontFamily: "babak",color: Colors.white,fontWeight: FontWeight.bold),),
        leading: Image.asset("assets/icons/Bar chart-2.png", scale: 4),
      backgroundColor: Colors.black,),
      body:Column(
        children: [
          // SizedBox(height: height/29,),
          Consumer<LoginProvider>(
            builder: (context,lValue,child) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [SizedBox(height: height/3.5,),
                  Padding(
                    padding: const EdgeInsets.only(left: 50),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 60,
                      child: Icon(Icons.manage_accounts_outlined),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text(lValue.loginType,
                          style:TextStyle(color: Colors.white,fontFamily: "benne",fontSize: 25),),
                        Text(lValue.loginPhone,
                          style:TextStyle(color: Colors.white,fontFamily: "belleza",fontWeight: FontWeight.w100,fontSize: 17),)
                      ],
                    ),
                  ),

                ],
              );
            }
          ),

          Consumer<MainProvider>(
            builder: (context1,destVal1,child) {
              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  height: 95,
                  width: width,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),
                  gradient: admingradient,
                  ),
                    child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ListTile(
                          leading: Icon(Icons.edit_location_outlined,size: 32,color: Colors.white,),
                          title: Text("Add Destination",style: TextStyle(fontFamily: "benne",fontSize: 18,color: Colors.white),),
                          subtitle: Text("Edit location details,price and more",style: TextStyle(fontFamily: "baloo",fontSize: 13,color: Colors.white),),
                          trailing: Icon(Icons.arrow_forward_ios_sharp,size: 20,color: Colors.white,),
                          onTap: () {
                            destVal1.getDestination();
                            callNext(context, AddDestinationDetailsScreen());
                          },
                        ),
                      ],
                    ),
                  ),
                );
            }
          ),

        Consumer<MainProvider>(
          builder: (context2,eventvalue,child) {
            return Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                height: 95,
                width: width,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),
                  gradient: admingradient,
                ),
                child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ListTile(
                        leading: Icon(Icons.event_note_outlined,size: 32,color: Colors.white,),
                        title: Text("Add Event",style: TextStyle(fontFamily: "benne",fontSize: 18,color: Colors.white),),
                        subtitle: Text("Manage events,venue and other details",style: TextStyle(fontFamily: "baloo",fontSize: 13,color: Colors.white),),
                          trailing: Icon(Icons.arrow_forward_ios_sharp,size: 20,color: Colors.white,),
                          onTap: () {
                          eventvalue.getEvent();
                          callNext(context, AddEventDetailsScreen());
                        }
                      ),
                  ],
                ),
                ),
              );
          }
        ),

         Consumer<MainProvider>(
           builder: (context,bValue,child) {
             return Padding(
               padding: const EdgeInsets.all(5.0),
               child: Container(
                 height: 95,
                 width: width,
                 decoration: BoxDecoration(gradient: admingradient,
                   borderRadius: BorderRadius.circular(5)
                 ),
                 child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                   children: [
                     ListTile(
                       leading: Icon(Icons.perm_contact_calendar_outlined,size: 32,color: Colors.white,),
                       title: Text("Bookings",style: TextStyle(fontFamily: "benne",fontSize: 18,color: Colors.white),),
                       subtitle: Text("Edit location details,price and more",style: TextStyle(fontFamily: "baloo",fontSize: 13,color: Colors.white),),
                       trailing: Icon(Icons.arrow_forward_ios_sharp,size: 20,color: Colors.white,),
                                 onTap: () async {
                                   await bValue.loadAllBookings();
                                   callNext(context, BookingListScreen());
                                 },
                     ),
                   ],
                 ),
               ),
             );
           }
         ),

          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              height: 95,
              width: width,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),
                gradient: admingradient,
              ),
                    child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Consumer<MainProvider>(
                          builder: (context,val,child) {
                            return ListTile(
                              leading: Icon(Icons.sign_language_outlined,size: 32,color: Colors.white,),
                              title: Text("Sign Out",style: TextStyle(fontFamily: "benne",fontSize: 18,color: Colors.white),),
                              trailing: Icon(Icons.arrow_forward_ios_sharp,size: 20,color: Colors.white,),
                              onTap: () {
                                val.logOutAlert(context);
                              },
                            );
                          }
                        ),
                      ],

                    ),
                  ),
              ),

        ],
      )
    );
  }
}
