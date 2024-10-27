import 'package:flutter/material.dart';
import 'package:travelmate/constants/call_functions.dart';
import '../constants/constant_colors.dart';
import 'bookEvent.dart';

class eventDetailWidget extends StatelessWidget {
  const eventDetailWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back_ios_new_sharp,color: Colors.white,size: 32,),
        backgroundColor: Colors.black,
        title: Text("Book Ticket",style: TextStyle(color: Colors.white,fontFamily: "bakbak",fontSize: 25),),
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child:
      Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(1.0),
            child: Container(
              width: width,
              height: height/3,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image:AssetImage("assets/image/camp munnar.jpeg"),
                    fit: BoxFit.cover,
                  ),
              ),
            ),
          ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text("About Event",style: TextStyle(color: Colors.white,fontFamily: "bakbak",fontSize: 20),),
        ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("""Jatayupara Earth's Center is an ambitious new attraction in Kerala.It opened in late 2016, in Chadayamangalam village in Kerala's Kollam district, about an hour north of Trivandrum. The park is spread over an astonishing 65 acres and is themed on the Hindu epic The Ramayan.It's dominated by a 200-foot-long landmark sculpture of Jatayu, the mythical vulture that's believed to have been killed on the rocky hilltop while trying to rescue Sita from Ravan. Notably,the sculpture is considered to be the largest of its kind in the world. The park has more than 20 adventure activities, a 6D theater that shows the battle between Jatayu and Ravan, a virtual reality museum, an Ayurvedic healing cave, and cable car (aerial tramway) to transport visitors up.""",
            style: TextStyle(fontFamily: "baloo",fontSize: 13,color: Colors.white),
            softWrap: true,
            textAlign: TextAlign.left,),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: width,
              height: height/3,
              decoration: BoxDecoration(
                gradient: admingradientone,
                borderRadius: BorderRadius.circular(30)
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 20,left: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.calendar_month_outlined,color: Colors.white,size: 25,),
                          Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          Text("Monday,December 18,2024",style: TextStyle(fontSize: 15,fontFamily: "bakbak",color: Colors.white),),
                              Text("10 AM to 3 PM",style: TextStyle(fontSize: 12,fontFamily: "baloo",color: Colors.white),)
                         ]
                          )
                        ],
                      ),

                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Row(mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.location_on_outlined,color: Colors.white,size: 25,),
                          Column(crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Highlight Mall-Suryanelli,Munnar,Idukki.",style: TextStyle(fontSize: 15,fontFamily: "bakbak",color: Colors.white,),
                                  softWrap: true,
                                  textAlign: TextAlign.left,
                                ),

                              ]
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20,right: 20,top: 70),
                      child: InkWell(
                        onTap: () {
                          callNext(context, BookeventWidget());
                        },
                        child: Container(
                          width: width/1.5,height: 70,
                          decoration: BoxDecoration(gradient: admingradient,
                          borderRadius: BorderRadius.circular(20)),
                          child: Center(child: Text("Book Now",style: TextStyle(fontFamily: "benne",fontSize: 25,color: Colors.white),)),
                        ),
                      ),
                    ),

                  ],
                ),
              ),

            ),
          )
        ],
      ),
      )
    );
  }
}
