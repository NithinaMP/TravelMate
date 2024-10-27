import 'package:flutter/material.dart';
import 'package:travelmate/constants/call_functions.dart';
import '../constants/constant_colors.dart';
import 'homeScreen.dart';

class BookeventWidget extends StatelessWidget {
  const BookeventWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.arrow_back_ios_new_sharp,color: Colors.white,size: 32,),
          backgroundColor: Colors.black,
          title: Text("Book Event",style: TextStyle(color: Colors.white,fontFamily: "bakbak",fontSize: 25),),
        ),
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child:
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 90),
                child: Center(
                  child: Container(
                    height: 240,width: 240,
                    decoration: BoxDecoration(color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                  ),
                ),
              ),
              SizedBox(height: height/10,),
              Container(
                width: width/1.02,
                height: height/2,
                decoration: BoxDecoration(gradient: admingradientone,
                    borderRadius: BorderRadius.circular(30)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Event",style: TextStyle(color: Colors.white,fontSize: 20,fontFamily: "bakbak"),),
                      Text("Campper Campwoody - Suryanelli Munnar",style: TextStyle(color: Colors.white,
                          fontFamily: "cinzel",fontSize: 17),),
                      SizedBox(height: height/30,),
                      Text("Name",style: TextStyle(color: Colors.white,fontSize: 13,fontFamily: "bakbak"),),
                      Text("Nithina M P",style: TextStyle(color: Colors.white,fontSize: 20,fontFamily: "benne"),),
                      Text("Ticket No.",style: TextStyle(color: Colors.white,fontSize: 13,fontFamily: "bakbak"),),
                      Text("We23rt1234",style: TextStyle(color: Colors.white,fontSize: 20,fontFamily: "benne"),),
                      Text("Date and Hour",style: TextStyle(color: Colors.white,fontSize: 13,fontFamily: "bakbak"),),
                      Text("Augest 23,2024",style: TextStyle(color: Colors.white,fontSize: 20,fontFamily: "benne"),),
                      Text("10 AM to 12 AM",style: TextStyle(color: Colors.white,fontSize: 20,fontFamily: "benne"),),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Container(
                            width: width/1.5,height: 70,
                            decoration: BoxDecoration(gradient: admingradient,
                                borderRadius: BorderRadius.circular(20)),
                            child: Center(child: Text("Book Now",style: TextStyle(fontFamily: "benne",fontSize: 25,color: Colors.white),)),

                          ),
                        ),
                      )


                    ],
                  ),
                ),
              )

            ],
          ),)
    );
  }
}
