import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelmate/constants/call_functions.dart';
import 'package:travelmate/constants/constant_colors.dart';
import 'package:travelmate/constants/globalMethods.dart';
import 'package:travelmate/provider/mainProvider.dart';

import 'addDestinationScreen.dart';
import 'addEventScreen.dart';

class AddDestinationDetailsScreen extends StatelessWidget {
  const AddDestinationDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_ios_new_sharp,
                color: Colors.white,
                size: 32,
              )),
          title: Text(
            "Add Destination",
            style: TextStyle(
                color: Colors.white, fontFamily: "bakbak", fontSize: 25),
          ),
          backgroundColor: Colors.black,
        ),
        floatingActionButton: Consumer<MainProvider>(
          builder: (context,destVal,child) {
            return FloatingActionButton(
              shape: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide(
                    color: Color(0xff351C08),
                    width: 1,
                  )),
              elevation: 100,
              highlightElevation: 100,
              backgroundColor: Colors.white,
              child: Icon(
                Icons.add,
                size: 50,
                color: Color(0xff351C08),
              ),
              onPressed: () {
                //navigate to add destination

                destVal.clearDestination();
                callNext(context, AddDestinationScreen(from: 'NEW', oldId: '',));
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
                builder: (context,destValue,child) {
                  return ListView.builder(
                    // itemCount: 5,
                    itemCount: destValue.destinationList.length,
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemBuilder: (context, index) {
                       var destD=destValue.destinationList[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Container(
                            width: width,
                            height: height / 4,
                            decoration: BoxDecoration(
                              color: cstOrange1,
                                image: DecorationImage(
                                  image: NetworkImage(destD.destImage),
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
                                      destValue.editAddedDestination(destD.destId);
                                      callNext(context, AddDestinationScreen(from: 'EDIT', oldId:destD.destId ,));
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
                                    showDeleteConfirmation(context, destD.destId, "DeleteDestination");
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
        )


        ));
  }
}
