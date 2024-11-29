import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelmate/constants/call_functions.dart';
import 'package:travelmate/constants/constant_colors.dart';
import 'package:travelmate/provider/mainProvider.dart';

import '../constants/globalMethods.dart';
import 'addEventScreen.dart';

class AddEventDetailsScreen extends StatelessWidget {
  const AddEventDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: InkWell(onTap: () {
          finish(context);
        },
            child: Icon(Icons.arrow_back_ios_new_sharp,color: Colors.white,size: 32,)),
        title: Text("Add Event", style: TextStyle(color: Colors.white,fontSize: 25,fontFamily: "bakbak"),),
        backgroundColor: Colors.black,
      ),
      floatingActionButton: Consumer<MainProvider>(
        builder: (context1,eventValue,child) {
          return FloatingActionButton(
            shape: UnderlineInputBorder(borderRadius: BorderRadius.circular(20),
                borderSide:BorderSide(color: Color(0xff351C08),width: 1) ),
            elevation: 100,highlightElevation: 100,
            backgroundColor: Colors.white,
            child: Icon(Icons.add,color: Color(0xff351C08),size: 50,),
            onPressed: () {
              eventValue.clearEvent();
              callNext(context, AddEventScreen(from: 'NEW', oldId: '',));
              // eventAddingAlertBox(context,width,height);
            },
          );
        }
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: SingleChildScrollView(
        child: Column(
          children: [

            Padding(
                padding: const EdgeInsets.only(top: 15, right: 10, left: 10),
                child: Consumer<MainProvider>(
                    builder: (context,eventValue,child) {
                      return ListView.builder(
                        // itemCount: 5,
                        itemCount: eventValue.eventList.length,
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemBuilder: (context, index) {
                          var eventD=eventValue.eventList[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Container(
                              width: width,
                              height: height / 4,
                              decoration: BoxDecoration(
                                  color: Colors.yellow.shade300,
                                  image: DecorationImage(
                                    image: NetworkImage(eventD.eventImage),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(15)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        eventValue.editAddedEvent(eventD.eventId);
                                        callNext(context, AddEventScreen(from: 'EDIT', oldId:eventD.eventId ,));
                                      },
                                      child: Container(
                                        height: 50,
                                        width: 180,
                                        decoration: BoxDecoration(
                                          gradient: admingradient,
                                          borderRadius: BorderRadius.circular(30),
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.edit,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                            Text(
                                              " Edit details",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: "bakbak",
                                                  fontSize: 14),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),

                                  CircleAvatar(
                                    radius: 20,
                                    backgroundColor: cstOrange1,
                                    child: GestureDetector(onTap: () {
                                      showDeleteConfirmation(context, eventD.eventId, "DeleteEvent");
                                      // destValue.deleteDestination(destD.destId,context);
                                    },

                                      child: Icon(Icons.delete,color: Colors.white,size: 30,),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },);
                    }
                )


            ),
            SizedBox(height: height/10,)

          ],


        ),
      ),
    );
  }
}
