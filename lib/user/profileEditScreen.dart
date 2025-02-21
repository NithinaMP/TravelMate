import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:travelmate/constants/call_functions.dart';
import 'package:travelmate/constants/constant_colors.dart';
import 'package:travelmate/provider/loginProvider.dart';

import '../provider/mainProvider.dart';


class ProfileEditScreen extends StatelessWidget {
  String userId;
  ProfileEditScreen({super.key,required this.userId});

  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(backgroundColor: Colors.black,
        appBar:
        AppBar(
          backgroundColor: Colors.transparent,
         title: Text("Edit Profile",
            style: TextStyle(fontFamily: "bakbak", fontSize: 28,color:Colors.white),
          ),
          // leading: InkWell(
          //     onTap: () {
          //
          //     },
          //     // splashColor: Colors.transparent, // Remove splash color
          //     // highlightColor: Colors.transparent, // Remove highlight color
          //     child: Icon(Icons.arrow_back_ios_new_sharp,color: Colors.white,size: 40,)
          // ),
          // centerTitle: true,
        ),

        body: SingleChildScrollView(
          child: Consumer<LoginProvider>(
            builder: (context,value,child) {
              return Column(
                children: [
                  SizedBox(height: height/10,),
                  Stack(
                    children: [
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            showBottomSheet(context);
                          },
                          child: CircleAvatar(
                            backgroundColor:Colors.grey,
                            radius: 50,

                            child: ClipOval(
                              child: value.addUsersImage != null
                                  ? Image.file(
                                value.addUsersImage!,
                                fit: BoxFit.cover,
                                width: 100,
                                height: 100,
                              )
                                  : Icon(Icons.person,color:Colors.blue.shade900, size: 50),
                            ),
                          ),
                        ),
                      ),

                    ],

                  ),
                  SizedBox(height: 25,),

                  Container(
                    child: TextField(
                      controller: value.RegNameController,
                      style: TextStyle(color: Colors.white,fontSize: 20,fontFamily: "benne",),
                      cursorColor: Colors.brown,
                      decoration: InputDecoration(prefixIcon: Icon(Icons.person_pin_outlined,color: Colors.brown,),
                        label: Text("User Name",style: TextStyle(fontFamily: "baloo",fontSize: 18,color: Colors.white),),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.brown),borderRadius: BorderRadius.circular(30)),
                        // hintStyle: TextStyle(color: Colors.white)
                      ),
                    ),
                  ),
                  SizedBox(height: 15,),
                  Container(
                    child: TextField(
                      controller: value.RegPhoneController,
                      style: TextStyle(color: Colors.white,fontSize: 20,fontFamily: "belleza",),
                      keyboardType: TextInputType.number,maxLength: 10,
                      cursorColor: Colors.brown,
                      decoration: InputDecoration(counterText: "",
                        prefixIcon: Icon(Icons.phone,color: Colors.brown,),
                        label: Text("Phone Number",style: TextStyle(fontFamily: "baloo",fontSize: 18,color: Colors.white),),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.brown),borderRadius: BorderRadius.circular(30)),
                        // hintStyle: TextStyle(color: Colors.white)
                      ),
                    ),
                  ),
                  SizedBox(height: 15,),

                  Container(
                    child: TextField(
                  controller: value.RegPlaceController,
                      style: TextStyle(color: Colors.white,fontSize: 20,fontFamily: "benne",),
                      cursorColor: Colors.brown,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.edit_location_outlined,color: Colors.brown,),
                        label: Text("Place",style: TextStyle(fontFamily: "baloo",fontSize: 18,color: Colors.white),),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.brown),borderRadius: BorderRadius.circular(30)),
                        // hintStyle: TextStyle(color: Colors.white)
                      ),
                    ),
                  ),

                  SizedBox(height:height/5,),

                  Consumer<LoginProvider>(
                    builder: (context, eValue, child) {
                      return InkWell(
                        onTap: () {
                          eValue.addRegistraion(context, "EDIT", userId);
                          // eValue.getUser();
                        },
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        child: Container(
                          height: 55,
                          width: width / 2.5,
                          decoration: BoxDecoration(
                            gradient: admingradient,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: eValue.isSaving
                                ? CircularProgressIndicator(color: Colors.white) // Show loader
                                : Text(
                              "Save",
                              style: TextStyle(color: Colors.white, fontFamily: "belleza", fontSize: 20),
                            ),
                          ),
                        ),
                      );
                    },
                  ),


                ],
              );
            }
          ),
        ),
      ),
    );
  }
}

void showBottomSheet(BuildContext context) {
  LoginProvider logprovider =Provider.of<LoginProvider>(context,listen:false);
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
                leading:  Icon(
                  Icons.camera_enhance_sharp,
                  color: Colors.blue,
                ),
                title: const Text('Camera',),
                onTap: () => {
                  logprovider.UsersgetImagecamera(), Navigator.pop(context)
                }),
            ListTile(
                leading:  Icon(Icons.photo, color: Colors.blue),
                title: const Text('Gallery',),
                onTap: () => {
                  logprovider.UsersgetImagegallery(),Navigator.pop(context)
                }),
          ],
        );
      });
  // ImageSource
}


// Consumer<LoginProvider>(
//   builder: (context,eValue,child) {
//     return InkWell(
//       onTap: () {
//         eValue.addRegistraion(context, "EDIT", userId);
//         finish(context);
//       },
//       splashColor: Colors.transparent, // Remove splash color
//       highlightColor: Colors.transparent, // Remove highlight color
//       child: Container(
//         height: 55,
//         width: width/2.5,
//         decoration: BoxDecoration(gradient: admingradient,
//         borderRadius: BorderRadius.circular(20)),
//         child: Center(child: Text("Save",
//           style: TextStyle(color: Colors.white,fontFamily: "belleza",fontSize: 20),
//         ),
//         ),
//       ),
//     );
//   }
// ),