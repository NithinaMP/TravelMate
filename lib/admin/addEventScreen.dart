import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelmate/constants/call_functions.dart';
import 'package:travelmate/provider/mainProvider.dart';

import '../constants/constant_colors.dart';
import 'addEventDetailsScreen.dart';

class AddEventScreen extends StatelessWidget {
  const AddEventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Add Event",style: TextStyle(fontFamily: "bakbak",fontSize: 25,color: Colors.white),),
        backgroundColor: Colors.black,
        leading: Icon(Icons.arrow_back_ios_new_sharp,size: 32,color: Colors.white,),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Container(
              height: 45,
              width: width/5,
              decoration: BoxDecoration(gradient: admingradient,
              borderRadius: BorderRadius.circular(10)),
              child: Center(child: Text("Done",style: TextStyle(color: Colors.white),)),
            ),
          )

        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.75),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: height/13,width: width,),
        
                  Container(
                    child: TextField(
                      style: TextStyle(color: Colors.white,fontSize: 20,fontFamily: "benne",),
                    cursorColor: Colors.brown,
                    decoration: InputDecoration(prefixIcon: Icon(Icons.notes_outlined,color: Colors.brown,),
                      label: Text("Event Name",style: TextStyle(fontFamily: "baloo",fontSize: 18,color: Colors.white),),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.brown),borderRadius: BorderRadius.circular(30)),
                      // hintStyle: TextStyle(color: Colors.white)
                    ),
                    ),
                  ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: TextField(
                  style: TextStyle(color: Colors.white,fontSize: 20,fontFamily: "benne",
                  ),
                  cursorColor: Colors.brown,
                  decoration: InputDecoration(
                    label: Text("Place",style: TextStyle(fontFamily: "baloo",fontSize:18,color: Colors.white ),),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.brown),borderRadius: BorderRadius.circular(30)
                    )
        
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10,),
                child: TextField(
                  style: TextStyle(color: Colors.white,fontSize: 20,fontFamily: "benne",
                  ),
                  cursorColor: Colors.brown,
                  decoration: InputDecoration(
                      label: Text("District",style: TextStyle(fontFamily: "baloo",fontSize:18,color: Colors.white ),),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.brown),borderRadius: BorderRadius.circular(30)
                      )
        
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10,top: 30,right: 10),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(child: Center(child: Text("Upload Image",style: TextStyle(fontSize: 13,fontFamily: "baloo",color: Colors.white),)),
                      width: 180,height: 50,
                      decoration: BoxDecoration(gradient: admingradient,
                        borderRadius: BorderRadius.circular(30),
        
                      ),
                    ),
                    Container(child: Center(child: Text("Location/Map",style: TextStyle(fontFamily: "baloo",fontSize: 13,color: Colors.white),)),
                      width: 180,height: 50,
                      decoration: BoxDecoration(gradient: admingradient,
                          borderRadius: BorderRadius.circular(30),
        
                      ),
                    ),
                  ],
        
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: TextField(
                  style: TextStyle(color: Colors.white,fontSize: 20,fontFamily: "benne", ),
                cursorColor: Colors.brown,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.description_outlined,color: Colors.brown,),
                  label: Text("Description",style: TextStyle(fontFamily: "baloo",fontSize: 18,color: Colors.white),),
                  focusedBorder: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(30),borderSide: BorderSide(color: Colors.brown)
                  )
                ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10,left: 11,),
                child: Row(children: [Icon(Icons.calendar_month_outlined,color: Colors.brown,),
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Text("Date and Time",style: TextStyle(color: Colors.white,fontSize: 18,fontFamily: "baloo"),),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10,left: 16),
                  child: Container(width: 180,height: 50,
                    decoration: BoxDecoration(gradient: admingradient,
                    borderRadius: BorderRadius.circular(30)),
                  ),
                )
                ] ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10,left: 11,),
                child: Row(children: [Icon(Icons.confirmation_num_outlined,color: Colors.brown,),
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Text("Slot Availability",style: TextStyle(color: Colors.white,fontSize: 18,fontFamily: "baloo"),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10,left: 16),
                    child: Container(width: 100,height: 50,
                      decoration: BoxDecoration(gradient: admingradient,
                          borderRadius: BorderRadius.circular(30)),
                    ),
                  )
                ] ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10,left: 11,),
                child: Row(children: [Icon(Icons.price_change_outlined,color: Colors.brown,),
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Text("Entry Fee",style: TextStyle(color: Colors.white,fontSize: 18,fontFamily: "baloo"),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10,left: 16),
                    child: Container(width: 100,height: 50,
                      decoration: BoxDecoration(gradient: admingradient,
                          borderRadius: BorderRadius.circular(30)),
                    ),
                  )
                ] ),
              ),

                   ],
               // ),
        
          ),
        ),
      ),
    );
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         title: Text("Add Event "),
//       ),
//       body: Consumer<MainProvider>(
//         builder: (context,value,child) {
//           return Padding(
//             padding: const EdgeInsets.all(15),
//             child: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   SizedBox(height: 10,),
//                   Container(
//                     height: height / 13,
//                     decoration: BoxDecoration(
//                         color: cstOrange2,
//                         borderRadius: BorderRadius.circular(20)),
//                     child: TextFormField(
//                       controller: value.eventNameContoller,
//                       // focusNode: nameFocusNode,
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontFamily: "muktaregular",
//                       ),
//                       decoration: InputDecoration(
//
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(20)),
//                         label: Text(
//                           "EVENT NAME",
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontFamily: "muktaregular",
//                               fontWeight: FontWeight.w500),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                             borderSide: BorderSide.none,
//                             borderRadius: BorderRadius.circular(20)),
//                         enabledBorder: OutlineInputBorder(
//                             borderSide: BorderSide.none,
//                             borderRadius: BorderRadius.circular(20)),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 5,),
//                   Container(
//                     height: height / 13,
//                     decoration: BoxDecoration(
//                         color: cstOrange2,
//                         borderRadius: BorderRadius.circular(20)),
//                     child: TextFormField(
//                       controller: value.eventPlaceController,
//                       // focusNode: nameFocusNode,
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontFamily: "muktaregular",
//                       ),
//                       decoration: InputDecoration(
//
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(20)),
//                         label: Text(
//                           "EVENT PLACE",
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontFamily: "muktaregular",
//                               fontWeight: FontWeight.w500),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                             borderSide: BorderSide.none,
//                             borderRadius: BorderRadius.circular(20)),
//                         enabledBorder: OutlineInputBorder(
//                             borderSide: BorderSide.none,
//                             borderRadius: BorderRadius.circular(20)),
//                       ),
//                     ),
//                   ),
//
//                   SizedBox(height: 10,),
//                   GestureDetector(
//                     onTap: () {
//                       showBottomSheet(context);
//                     },
//                     child: Container(
//
//                       height: height / 2.5,
//                       width: width / 1.2,
//                       color: cstOrange1,
//                         child:value.addEventImg!=null?Image.file(value.addEventImg!,fit:BoxFit.fill):
//                     Text(
//                     "Add image here",
//                     style: TextStyle(color: Colors.white),
//                   )
//                     ),
//                   ),
//                   SizedBox(height: 10,),
//                   Container(
//                     height: height / 13,
//                     decoration: BoxDecoration(
//                         color: cstOrange2,
//                         borderRadius: BorderRadius.circular(20)),
//                     child: TextFormField(
//                       controller: value.eventDurationContoller,
//                       // focusNode: nameFocusNode,
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontFamily: "muktaregular",
//                       ),
//                       decoration: InputDecoration(
//
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(20)),
//                         label: Text(
//                           "EVENT DURATION",
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontFamily: "muktaregular",
//                               fontWeight: FontWeight.w500),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                             borderSide: BorderSide.none,
//                             borderRadius: BorderRadius.circular(20)),
//                         enabledBorder: OutlineInputBorder(
//                             borderSide: BorderSide.none,
//                             borderRadius: BorderRadius.circular(20)),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 5,),
//                   Container(
//                     height: height / 13,
//                     decoration: BoxDecoration(
//                         color: cstOrange2,
//                         borderRadius: BorderRadius.circular(20)),
//                     child: TextFormField(
//                       controller: value.eventTicketPriceContoller,
//                       // focusNode: nameFocusNode,
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontFamily: "muktaregular",
//                       ),
//                       decoration: InputDecoration(
//
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(20)),
//                         label: Text(
//                           "TICKET PRICE",
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontFamily: "muktaregular",
//                               fontWeight: FontWeight.w500),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                             borderSide: BorderSide.none,
//                             borderRadius: BorderRadius.circular(20)),
//                         enabledBorder: OutlineInputBorder(
//                             borderSide: BorderSide.none,
//                             borderRadius: BorderRadius.circular(20)),
//                       ),
//                     ),
//                   ),
//
//                   ElevatedButton(
//
//                       onPressed: () {
//                       value.addEvent();
//                     back(context);
//                   },
//                       child: Text("Save"))
//                 ],
//               ),
//             ),
//           );
//         }
//       ),
//     );
//   }
//   void showBottomSheet(BuildContext context) {
//     MainProvider mainprovider =Provider.of<MainProvider>(context,listen:false);
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
//                   leading:  Icon(
//                     Icons.camera_enhance_sharp,
//                     color: Colors.blue,
//                   ),
//                   title: const Text('Camera',),
//                   onTap: () => {
//                     mainprovider.getImgcamera(), Navigator.pop(context)
//                   }),
//               ListTile(
//                   leading:  Icon(Icons.photo, color: Colors.blue),
//                   title: const Text('Gallery',),
//                   onTap: () => {
//                     mainprovider.getImggallery(),Navigator.pop(context)
//                   }),
//             ],
//           );
//         });
//     // ImageSource
  }

 }
