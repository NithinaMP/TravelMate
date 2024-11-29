import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelmate/constants/call_functions.dart';
import 'package:travelmate/provider/mainProvider.dart';

import '../constants/constant_colors.dart';

class AddDestinationScreen extends StatelessWidget {
  String from,oldId;
   AddDestinationScreen({super.key,required this.from,required this.oldId});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery
        .of(context)
        .size
        .width;
    var height = MediaQuery
        .of(context)
        .size
        .height;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Add Destination", style: TextStyle(
            fontFamily: "bakbak", fontSize: 25, color: Colors.white),),
        backgroundColor: Colors.black,
        leading: InkWell(onTap: () {
          Navigator.pop(context);
        },
            child: Icon(
              Icons.arrow_back_ios_new_sharp, size: 32, color: Colors.white,)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.75),
          child: Consumer<MainProvider>(
              builder: (context, value, child) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // SizedBox(height: height/13,width: width,),

                    Container(
                      child: TextField(
                        controller: value.destNameController,
                        style: TextStyle(color: Colors.white,
                          fontSize: 20,
                          fontFamily: "benne",),
                        cursorColor: Colors.brown,
                        decoration: InputDecoration(prefixIcon: Icon(Icons
                            .edit_location_outlined, color: Colors.brown,),
                          label: Text("Destination Name", style: TextStyle(
                              fontFamily: "baloo",
                              fontSize: 18,
                              color: Colors.white),),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.brown),
                              borderRadius: BorderRadius.circular(30)),
                          // hintStyle: TextStyle(color: Colors.white)
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: TextField(
                        controller: value.destPlaceController,
                        style: TextStyle(color: Colors.white,
                          fontSize: 20,
                          fontFamily: "benne",
                        ),
                        cursorColor: Colors.brown,
                        decoration: InputDecoration(
                            label: Text("Place", style: TextStyle(
                                fontFamily: "baloo",
                                fontSize: 18,
                                color: Colors.white),),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.brown),
                                borderRadius: BorderRadius.circular(30)
                            )

                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10,),
                      child: TextField(
                        controller: value.destDistrictController,
                        style: TextStyle(color: Colors.white,
                          fontSize: 20,
                          fontFamily: "benne",
                        ),
                        cursorColor: Colors.brown,
                        decoration: InputDecoration(
                            label: Text("District", style: TextStyle(
                                fontFamily: "baloo",
                                fontSize: 18,
                                color: Colors.white),),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.brown),
                                borderRadius: BorderRadius.circular(30)
                            )

                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10, top: 30, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                showBottomSheet(context);
                              },
                              child: Container(
                                child: Center(
                                  child: Text(
                                    "Upload Image",
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontFamily: "baloo",
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                height: height / 15,
                                decoration: BoxDecoration(
                                  gradient: admingradient,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          // Add spacing between the two containers
                          Expanded(
                            child: Container(
                              child: Center(
                                child: Text(
                                  "Location/Map",
                                  style: TextStyle(
                                    fontFamily: "baloo",
                                    fontSize: 13,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              height: height / 15,
                              decoration: BoxDecoration(
                                gradient: admingradient,
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: TextField(
                        controller: value.destDiscriptionController,
                        style: TextStyle(color: Colors.white,
                          fontSize: 20,
                          fontFamily: "benne",),
                        cursorColor: Colors.brown,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.description_outlined,
                              color: Colors.brown,),
                            label: Text("Description", style: TextStyle(
                                fontFamily: "baloo",
                                fontSize: 18,
                                color: Colors.white),),
                            focusedBorder: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(color: Colors.brown)
                            )
                        ),
                      ),
                    ),



                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 11,),
                      child: Consumer<MainProvider>(
                          builder: (context, fee, child) {
                            return Row(children: [
                              Icon(Icons.price_change_outlined,
                                color: Colors.brown,),
                              Padding(
                                padding: const EdgeInsets.all(14.0),
                                child: Text("Entry Fee", style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontFamily: "baloo"),),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 10, left: 16),
                                child:
                                Container(width: 100, height: 50,
                                  decoration: BoxDecoration(
                                      gradient: admingradient,
                                      borderRadius: BorderRadius.circular(30)),
                                  child: TextField(
                                    controller: fee.destEntryFeeController,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,

                                    ),
                                    style: TextStyle(color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ),

                                ),
                              )
                            ]);
                          }
                      ),
                    ),
                    SizedBox(height: 15,),

                    Consumer<MainProvider>(
                      builder: (context1,val1,child) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 10,left: 11,),
                          child: Row(children: [Icon(Icons.confirmation_num_outlined,color: Colors.brown,),
                            Padding(
                              padding: const EdgeInsets.all(14.0),
                              child: Text("Slot Availability",style: TextStyle(color: Colors.white,fontSize: 18,fontFamily: "baloo"),),
                            ),
                            Row(
                              children: [
                                Switch(value: val1.isSwitched, onChanged: (value) {
                                 val1.toggleSwitch(value,context1);
                                },
                                activeColor: Colors.deepOrange,
                                  inactiveThumbColor: cstOrange1,
                                  inactiveTrackColor: Colors.blueGrey.shade300,
                                ),
                                Text(
                                  val1.isSwitched?"Available":"Not Available",
                                  style: TextStyle(color: val1.isSwitched?Colors.green:Colors.red,fontSize: 15,fontWeight: FontWeight.bold),
                                ),
                              ],
                            )
                          ] ),
                        );
                      }
                    ),



                    SizedBox(height: 30,),

                    Consumer<MainProvider>(
                        builder: (context2, val, child) {
                          return
                            ElevatedButton(

                                style: ElevatedButton.styleFrom(
                                    backgroundColor: cstOrange1,
                                    foregroundColor: Colors.white
                                ),

                                onPressed: () {

                                  if(from=="NEW"){
                                    val.addDestination(context, from, "");

                                  }
                                  else{
                                    val.addDestination(context, from, oldId);

                                  }
                                },
                                child: Text("DONE"));
                        }
                    )

                  ],
                  // ),

                );
              }
          ),
        ),
      ),
    );

  }

  void showBottomSheet(BuildContext context) {
    MainProvider mainprovider = Provider.of<MainProvider>(
        context, listen: false);
    showModalBottomSheet(
        elevation: 10,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            )),
        context: context,
        builder: (BuildContext bc) {
          return Wrap(
            children: <Widget>[
              ListTile(
                  leading: Icon(
                    Icons.camera_enhance_sharp,
                    color: cstOrange1,
                  ),
                  title: const Text('Camera',),
                  onTap: () =>
                  {
                    mainprovider.getDestImgcamera(), Navigator.pop(context)
                  }),
              ListTile(
                  leading: Icon(Icons.photo, color: cstOrange1),
                  title: const Text('Gallery',),
                  onTap: () =>
                  {
                    mainprovider.getDestImggallery(), Navigator.pop(context)
                  }),
            ],
          );
        });
    // ImageSource
  }
}