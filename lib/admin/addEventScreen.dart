//
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelmate/provider/mainProvider.dart';
import '../constants/constant_colors.dart';


class AddEventScreen extends StatelessWidget {
  String from,oldId;
  AddEventScreen({super.key,
    required this.from,required this.oldId
  });

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Add Event",style: TextStyle(fontFamily: "bakbak",fontSize: 25,color: Colors.white),),
        backgroundColor: Colors.black,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios_new_sharp,size: 32,color: Colors.white,)),

      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.75),
          child: Consumer<MainProvider>(
              builder: (context,eventValue,child) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: height/13,width: width,),

                    Container(
                      child: TextField(
                        controller: eventValue.eventNameController,
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
                        controller: eventValue.eventPlaceController,
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
                        controller: eventValue.eventDistrictController,
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
                    SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.calendar_today,
                              color: Colors.brown,
                            ),
                            onPressed: () async {
                              DateTime? selectedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2100),
                              );
                              if (selectedDate != null) {
                                eventValue.updateEventSelectedDate(selectedDate); // Update eventSelectedDate in MainProvider
                              }
                            },
                          ),
                          Text(
                            "Event Date",
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(width: 10),
                          // Displaying the selected date
                          Consumer<MainProvider>(
                            builder: (context, daValue, child) {
                              return Text(
                                daValue.eventSelectedDate == null
                                    ? "No date selected"
                                    : "${daValue.eventSelectedDate!.day}-${daValue.eventSelectedDate!.month}-${daValue.eventSelectedDate!.year}",
                                style: TextStyle(fontSize: 16, color: Colors.white), // Adjusted color to match your UI theme
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30,),


                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: TextField(
                        controller: eventValue.eventDiscriptionController,
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
                          builder: (contextt, fee, child) {
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
                                    controller: fee.eventEntryFeeController,
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
                                    val.addEvent(context2, from, "");
                                    print("errrrrrrrrrrr");

                                  }
                                  else{
                                    val.addEvent(context2, from, oldId);

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
                    mainprovider.getEventImgcamera(), Navigator.pop(context)
                  }),
              ListTile(
                  leading: Icon(Icons.photo, color: cstOrange1),
                  title: const Text('Gallery',),
                  onTap: () =>
                  {
                    mainprovider.getEventImggallery(), Navigator.pop(context)
                  }),
            ],
          );
        });
    // ImageSource
  }

}
//
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:travelmate/provider/mainProvider.dart';
// import '../constants/constant_colors.dart';
//
//
// class AddEventScreen extends StatelessWidget {
//   String from,oldId;
//   AddEventScreen({super.key,
//   required this.from,required this.oldId
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     var width = MediaQuery.of(context).size.width;
//     var height = MediaQuery.of(context).size.height;
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         title: Text("Add Event",style: TextStyle(fontFamily: "bakbak",fontSize: 25,color: Colors.white),),
//         backgroundColor: Colors.black,
//         leading: InkWell(
//           onTap: () {
//             Navigator.pop(context);
//           },
//             child: Icon(Icons.arrow_back_ios_new_sharp,size: 32,color: Colors.white,)),
//
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(8.75),
//           child: Consumer<MainProvider>(
//             builder: (context,eventValue,child) {
//               return Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   SizedBox(height: height/13,width: width,),
//
//                   Container(
//                     child: TextField(
//                       controller: eventValue.eventNameController,
//                       style: TextStyle(color: Colors.white,
//                         fontSize: 20,
//                         fontFamily: "benne",),
//                       cursorColor: Colors.brown,
//                       decoration: InputDecoration(prefixIcon: Icon(Icons
//                           .edit_location_outlined, color: Colors.brown,),
//                         label: Text("Destination Name", style: TextStyle(
//                             fontFamily: "baloo",
//                             fontSize: 18,
//                             color: Colors.white),),
//                         focusedBorder: UnderlineInputBorder(
//                             borderSide: BorderSide(color: Colors.brown),
//                             borderRadius: BorderRadius.circular(30)),
//                         // hintStyle: TextStyle(color: Colors.white)
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(top: 10),
//                     child: TextField(
//                       controller: eventValue.eventPlaceController,
//                       style: TextStyle(color: Colors.white,
//                         fontSize: 20,
//                         fontFamily: "benne",
//                       ),
//                       cursorColor: Colors.brown,
//                       decoration: InputDecoration(
//                           label: Text("Place", style: TextStyle(
//                               fontFamily: "baloo",
//                               fontSize: 18,
//                               color: Colors.white),),
//                           focusedBorder: UnderlineInputBorder(
//                               borderSide: BorderSide(color: Colors.brown),
//                               borderRadius: BorderRadius.circular(30)
//                           )
//
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(top: 10,),
//                     child: TextField(
//                       controller: eventValue.eventDistrictController,
//                       style: TextStyle(color: Colors.white,
//                         fontSize: 20,
//                         fontFamily: "benne",
//                       ),
//                       cursorColor: Colors.brown,
//                       decoration: InputDecoration(
//                           label: Text("District", style: TextStyle(
//                               fontFamily: "baloo",
//                               fontSize: 18,
//                               color: Colors.white),),
//                           focusedBorder: UnderlineInputBorder(
//                               borderSide: BorderSide(color: Colors.brown),
//                               borderRadius: BorderRadius.circular(30)
//                           )
//
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(
//                         left: 10, top: 30, right: 10),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Expanded(
//                           child: GestureDetector(
//                             onTap: () {
//                               showBottomSheet(context);
//                             },
//                             child: Container(
//                               child: Center(
//                                 child: Text(
//                                   "Upload Image",
//                                   style: TextStyle(
//                                     fontSize: 13,
//                                     fontFamily: "baloo",
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                               ),
//                               height: height / 15,
//                               decoration: BoxDecoration(
//                                 gradient: admingradient,
//                                 borderRadius: BorderRadius.circular(30),
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(width: 10),
//                         // Add spacing between the two containers
//                         Expanded(
//                           child: Container(
//                             child: Center(
//                               child: Text(
//                                 "Location/Map",
//                                 style: TextStyle(
//                                   fontFamily: "baloo",
//                                   fontSize: 13,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ),
//                             height: height / 15,
//                             decoration: BoxDecoration(
//                               gradient: admingradient,
//                               borderRadius: BorderRadius.circular(30),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//
//                 ///for calender
//                 //   Padding(
//                 //     padding: const EdgeInsets.only(top: 20),
//                 //     child: Row(
//                 //       mainAxisAlignment: MainAxisAlignment.start,
//                 //       children: [
//                 //         IconButton(
//                 //           icon: Icon(
//                 //             Icons.calendar_today,
//                 //             color: Colors.brown,
//                 //           ),
//                 //           onPressed: () async {
//                 //             DateTime? selectedDate = await showDatePicker(
//                 //               context: context,
//                 //               initialDate: DateTime.now(),
//                 //               firstDate: DateTime(2000),
//                 //               lastDate: DateTime(2100),
//                 //             );
//                 //             if (selectedDate != null) {
//                 //               eventValue.updateEventSelectedDate(selectedDate); // Update eventSelectedDate in MainProvider
//                 //             }
//                 //           },
//                 //         ),
//                 //         Text(
//                 //           "Event Date",
//                 //           style: TextStyle(color: Colors.white),
//                 //         ),
//                 //         SizedBox(width: 10),
//                 //         // Displaying the selected date
//                 //         Consumer<MainProvider>(
//                 //           builder: (context, daValue, child) {
//                 //             return Text(
//                 //               daValue.eventSelectedDate == null
//                 //                   ? "No date selected"
//                 //                   : "${daValue.eventSelectedDate!.day}-${daValue.eventSelectedDate!.month}-${daValue.eventSelectedDate!.year}",
//                 //               style: TextStyle(fontSize: 16, color: Colors.white), // Adjusted color to match your UI theme
//                 //             );
//                 //           },
//                 //         ),
//                 //       ],
//                 //     ),
//                 //   ),
//
//
//
//                   // Consumer<MainProvider>(
//                   //   builder: (context,dateValue,child) {
//                   //     return IconButton(
//                   //       icon: Icon(Icons.calendar_today, color: Colors.brown),
//                   //       onPressed: () async {
//                   //         DateTime? selectedDate = await showDatePicker(
//                   //           context: context,
//                   //           initialDate: DateTime.now(),
//                   //           firstDate: DateTime(2000),
//                   //           lastDate: DateTime(2100),
//                   //         );
//                   //
//                   //         if (selectedDate != null) {
//                   //           dateValue.updateEventDate(selectedDate); // Update the date using Provider
//                   //         }
//                   //       },
//                   //     );
//                   //   }
//                   // ),
//                   // SizedBox(width: 10),
//                   // Consumer<MainProvider>(
//                   //   builder: (context,daValue,child) {
//                   //     return Text(
//                   //       daValue.selectedDate == null
//                   //           ? "No date selected"
//                   //           : "${daValue.selectedDate!.day}-${daValue.selectedDate!.month}-${daValue.selectedDate!.year}",
//                   //       style: TextStyle(fontSize: 16, color: Colors.black),
//                   //     );
//                   //   }
//                   // ),
//
//
//
//                   Padding(
//                     padding: const EdgeInsets.only(top: 20),
//                     child: TextField(
//                       controller: eventValue.eventDiscriptionController,
//                       style: TextStyle(color: Colors.white,
//                         fontSize: 20,
//                         fontFamily: "benne",),
//                       cursorColor: Colors.brown,
//                       decoration: InputDecoration(
//                           prefixIcon: Icon(Icons.description_outlined,
//                             color: Colors.brown,),
//                           label: Text("Description", style: TextStyle(
//                               fontFamily: "baloo",
//                               fontSize: 18,
//                               color: Colors.white),),
//                           focusedBorder: UnderlineInputBorder(
//                               borderRadius: BorderRadius.circular(30),
//                               borderSide: BorderSide(color: Colors.brown)
//                           )
//                       ),
//                     ),
//                   ),
//
//
//
//                   Padding(
//                     padding: const EdgeInsets.only(top: 10, left: 11,),
//                     child: Consumer<MainProvider>(
//                         builder: (contextt, fee, child) {
//                           return Row(children: [
//                             Icon(Icons.price_change_outlined,
//                               color: Colors.brown,),
//                             Padding(
//                               padding: const EdgeInsets.all(14.0),
//                               child: Text("Entry Fee", style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 18,
//                                   fontFamily: "baloo"),),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(
//                                   top: 10, left: 16),
//                               child:
//                               Container(width: 100, height: 50,
//                                 decoration: BoxDecoration(
//                                     gradient: admingradient,
//                                     borderRadius: BorderRadius.circular(30)),
//                                 child: TextField(
//                                   controller: fee.eventEntryFeeController,
//                                   decoration: InputDecoration(
//                                     border: InputBorder.none,
//
//                                   ),
//                                   style: TextStyle(color: Colors.white),
//                                   textAlign: TextAlign.center,
//                                 ),
//
//                               ),
//                             )
//                           ]);
//                         }
//                     ),
//                   ),
//                   SizedBox(height: 15,),
//
//                   Consumer<MainProvider>(
//                       builder: (context1,val1,child) {
//                         return Padding(
//                           padding: const EdgeInsets.only(top: 10,left: 11,),
//                           child: Row(children: [Icon(Icons.confirmation_num_outlined,color: Colors.brown,),
//                             Padding(
//                               padding: const EdgeInsets.all(14.0),
//                               child: Text("Slot Availability",style: TextStyle(color: Colors.white,fontSize: 18,fontFamily: "baloo"),),
//                             ),
//                             Row(
//                               children: [
//                                 Switch(value: val1.isSwitched, onChanged: (value) {
//                                   val1.toggleSwitch(value,context1);
//                                 },
//                                   activeColor: Colors.deepOrange,
//                                   inactiveThumbColor: cstOrange1,
//                                   inactiveTrackColor: Colors.blueGrey.shade300,
//                                 ),
//                                 Text(
//                                   val1.isSwitched?"Available":"Not Available",
//                                   style: TextStyle(color: val1.isSwitched?Colors.green:Colors.red,fontSize: 15,fontWeight: FontWeight.bold),
//                                 ),
//                               ],
//                             )
//                           ] ),
//                         );
//                       }
//                   ),
//
//
//
//                   SizedBox(height: 30,),
//
//
//                   Consumer<MainProvider>(
//                       builder: (context2, val, child) {
//                         return
//                           ElevatedButton(
//
//                               style: ElevatedButton.styleFrom(
//                                   backgroundColor: cstOrange1,
//                                   foregroundColor: Colors.white
//                               ),
//
//                               onPressed: () {
//
//                                 if(from=="NEW"){
//                                   val.addEvent(context2, from, "");
//                                   print("errrrrrrrrrrr");
//
//                                 }
//                                 else{
//                                   val.addEvent(context2, from, oldId);
//
//                                 }
//                               },
//                               child: Text("DONE"));
//                       }
//                   )
//
//                        ],
//                    // ),
//
//               );
//             }
//           ),
//         ),
//       ),
//     );
//
//   }
//   void showBottomSheet(BuildContext context) {
//     MainProvider mainprovider = Provider.of<MainProvider>(
//         context, listen: false);
//     showModalBottomSheet(
//         elevation: 10,
//         backgroundColor: Colors.white,
//         shape: const RoundedRectangleBorder(
//             borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(10.0),
//               topRight: Radius.circular(10.0),
//             )),
//         context: context,
//         builder: (BuildContext bc) {
//           return Wrap(
//             children: <Widget>[
//               ListTile(
//                   leading: Icon(
//                     Icons.camera_enhance_sharp,
//                     color: cstOrange1,
//                   ),
//                   title: const Text('Camera',),
//                   onTap: () =>
//                   {
//                     mainprovider.getEventImgcamera(), Navigator.pop(context)
//                   }),
//               ListTile(
//                   leading: Icon(Icons.photo, color: cstOrange1),
//                   title: const Text('Gallery',),
//                   onTap: () =>
//                   {
//                     mainprovider.getEventImggallery(), Navigator.pop(context)
//                   }),
//             ],
//           );
//         });
//     // ImageSource
//   }
//
//  }
