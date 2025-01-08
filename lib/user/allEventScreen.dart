import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelmate/constants/call_functions.dart';

import '../constants/constant_colors.dart';
import '../provider/mainProvider.dart';
import 'EventDetail.dart';

class AllEventScreen extends StatelessWidget {
  String userId;
  AllEventScreen({super.key,required this.userId});

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
              "Events",
              style: TextStyle(
                fontFamily: "bakbak",
                fontSize: 28,
                color: Colors.white,
                // fontWeight: FontWeight.bold
              ),
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

                        Consumer<MainProvider>(
                            builder: (context1,dValue,child) {
                              return ListView.builder(
                                itemCount: dValue.eventList.length,
                                physics: ScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  var event=dValue.eventList[index];
                                  return GestureDetector(
                                    onTap: () {
                                     callNext(context, EventDetailScreen(eventDetails: event, userId: userId,));
                                     // callNext(context, eventDetailWidget(eventDetails: event,));
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
                                                image: NetworkImage(event.eventImage),
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
                                                    Text(event.eventName,
                                                      maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        color: Colors.white,fontFamily: "playfair",
                                                        fontSize: 20,
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Icon(Icons.place_outlined,color: Colors.white,size: 20,),Text(
                                                          event.eventPlace,
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontFamily: "benne",
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ] ),
                                            ),
                                          )],
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
}
