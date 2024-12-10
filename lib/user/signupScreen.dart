import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';
import 'package:travelmate/constants/constant_colors.dart';
import 'package:travelmate/provider/loginProvider.dart';
import 'package:travelmate/user/userBottomScreen.dart';

import 'homeScreen.dart';

class RegisterScreen extends StatelessWidget {

  RegisterScreen({super.key,

  });

  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;
    return Scaffold(
      body: SizedBox.expand(
        child: Container(
          decoration: BoxDecoration(
            gradient: loginGradient
          ),
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: SingleChildScrollView(
              child: Consumer<LoginProvider>(
                builder: (context,value,child) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: height/8,),
                      Text("Let's get",style: TextStyle(color: Colors.white,fontFamily: "benne",fontSize: 40),),
                      Text("started",style: TextStyle(color: Colors.white,fontFamily: "benne",fontSize: 40),),
                      SizedBox(height: height/17,),
                      TextField(
                        controller:value.RegNameController ,
                        style: TextStyle(color: Colors.white,fontFamily: "baloo"),
                        decoration: InputDecoration(

                          hintText: "Username",
                          hintStyle: TextStyle(color: Colors.white,fontFamily: "baloo",fontSize: 13),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)
                            )
                        ),

                      ),
                      //
                      SizedBox(height: height/50,),
                      TextField(
                        controller: value.RegPhoneController,
                        style: TextStyle(color: Colors.white,fontFamily: "baloo"),
                        decoration: InputDecoration(
                          counterText: "",
                          hintText: "Phone number",
                          hintStyle: TextStyle(color: Colors.white,fontFamily: "baloo",fontSize: 13),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)
                            )
                        ),
                        keyboardType: TextInputType.phone,
                        maxLength: 10,


                      ),
                      SizedBox(height: height/50,),
                      TextField(
                        controller: value.RegPassWordController,
                        style: TextStyle(color: Colors.white,fontFamily: "baloo"),
                        decoration: InputDecoration(
                          hintText: "Password",
                          hintStyle: TextStyle(color: Colors.white,fontFamily: "baloo",fontSize: 13),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)
                            )
                        ),

                      ),
                      SizedBox(height: height/50,),
                      TextField(
                        controller: value.RegConfirmPassWordController,
                        style: TextStyle(color: Colors.white,fontFamily: "baloo"),
                        decoration: InputDecoration(
                          hintText: "Confirm Password",
                          hintStyle: TextStyle(color: Colors.white,fontFamily: "baloo",fontSize: 13),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)
                            )
                        ),

                      ),

                      // TextField(
                      //   decoration: InputDecoration(
                      //     focusedBorder: OutlineInputBorder(
                      //       borderSide:BorderSide(
                      //         color: Colors.white,
                      //         width: 5,
                      //
                      //       ) ,
                      //       borderRadius: BorderRadius.circular(10),
                      //     ) ,
                      //     label: Text("usernsme or password",
                      //       style: TextStyle(color: Colors.white),),
                      //     labelText: "hello",
                      //
                      //   ),
                      // ),
                      //
                      //
                      SizedBox(height: height/8,),
                      Center(
                        child: Stack(
                          children: [
                            // Blurred container
                            ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
                                child: Container(
                                  height: 50,
                                  width: 200,
                                  color: Colors.transparent, // Transparent to show blur
                                ),
                              ),
                            ),
                          //  Text on top of blurred container


                            GestureDetector(
                              onTap: () {
                                value.addRegistraion(context);
                              },
                              child: Container(
                                height: height/12,
                                width: width,
                                decoration: BoxDecoration(
                                  color: Color(0xff60320D).withOpacity(0.5), // Adjust opacity as needed
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Center(
                                  child: Text(
                                    "Sign Up",
                                    style: TextStyle(
                                      //fontFamily: "belleza",
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,

                                    ),
                                  ),
                                // ),
                              ),
                              ),
                            ) ],
                        ),
                      ),

                    ],
                  );
                }
              ),
            ),
          ),
        ),
      ),
    );
  }
}
