import 'package:flutter/material.dart';
import 'package:travelmate/constants/call_functions.dart';
import '../constants/constant_colors.dart';
import 'destinationScreen.dart';

class BookticketWidget extends StatelessWidget {
  const BookticketWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              back(context,DestinationScreen(imagePath: '', destinationName: '', location: '',));
            },
            child: Icon(Icons.arrow_back_ios_new_sharp,color: Colors.white,size: 32,)),
        backgroundColor: Colors.black,
        title: Text("Book Ticket",style: TextStyle(color: Colors.white,fontFamily: "bakbak",fontSize: 25),),
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
            child: Column(
              children: [
                Text("Event",style: TextStyle(color: Colors.white,fontSize: 20,fontFamily: "bakbak"),),
                Text("Campper Campwoody - Suryanelli Munnar",style: TextStyle(color: Colors.white,
                fontFamily: "cinzel",fontSize: 20),)
              ],
            ),
          )

        ],
      ),)
    );
  }
}
