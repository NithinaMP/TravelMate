import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelmate/constants/call_functions.dart';
import 'package:travelmate/constants/constant_colors.dart';
import 'package:travelmate/provider/loginProvider.dart';
import 'package:travelmate/provider/mainProvider.dart';
import 'package:travelmate/user/signupScreen.dart';
import 'package:travelmate/user/userBottomScreen.dart';

import 'homeScreen.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _validateAndLogin(BuildContext context1) {
    String phone = phoneController.text.trim();
    String password = passwordController.text.trim();

    if (phone.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Phone number and password cannot be empty."),
          backgroundColor: Colors.red,
        ),
      );
    } else if (phone.length < 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Enter a valid 10-digit phone number."),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      Provider.of<LoginProvider>(context1, listen: false)
          .userAuthorized(context1, phone, password);
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SizedBox.expand(
          child: Container(
            decoration: BoxDecoration(gradient: loginGradient),
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: height / 5),
                    Text(
                      "Hey,",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontFamily: "benne"),
                    ),
                    Text(
                      "Welcome back",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontFamily: "benne"),
                    ),
                    Text(
                      "  Log in to your account",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "archivo",
                          fontSize: 10),
                    ),
                    SizedBox(height: height / 9),
                    TextField(
                      controller: phoneController,
                      style: TextStyle(color: Colors.white, fontFamily: "baloo"),
                      decoration: InputDecoration(
                          counterText: "",
                          hintText: "Phone number",
                          hintStyle: TextStyle(
                              color: Colors.white,
                              fontFamily: "baloo",
                              fontSize: 15),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white))),
                      keyboardType: TextInputType.phone,
                      maxLength: 10,
                    ),
                    SizedBox(height: 50),
                    TextField(
                      controller: passwordController,
                      obscureText: !_isPasswordVisible,
                      style: TextStyle(color: Colors.white, fontFamily: "baloo"),
                      decoration: InputDecoration(
                          hintText: "Password",
                          hintStyle: TextStyle(
                              color: Colors.white,
                              fontFamily: "baloo",
                              fontSize: 15),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                            icon: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.white,
                            ),
                          )),
                    ),
                    SizedBox(height: height / 10),
                    Center(
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
                              child: Container(
                                height: 50,
                                width: 200,
                                color: Colors.transparent,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => _validateAndLogin(context),
                            child: Consumer<MainProvider>(
                              builder: (context,value,child) {
                                return Container(
                                  height: height / 12,
                                  width: width,
                                  decoration: BoxDecoration(
                                    color: Color(0xff60320D).withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Center(
                                    child:Text(
                                      "LOGIN",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                );
                              }
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account ?",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "archivo",
                              fontSize: 10),
                        ),
                        GestureDetector(
                          onTap: () {
                            callNext(context, RegisterScreen());
                          },
                          child: Text(
                            " Sign up",
                            style: TextStyle(
                                color: Color(0xff7CD3CE),
                                fontFamily: "archivo",
                                fontSize: 12),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//
// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});
//
//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }
//
// class _LoginPageState extends State<LoginPage> {
//   final TextEditingController phoneController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   bool _isPasswordVisible = false;
//   @override
//   void dispose() {
//     phoneController.dispose();
//     passwordController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var height = MediaQuery.of(context).size.height;
//     var width = MediaQuery.of(context).size.width;
//     return GestureDetector(
//       onTap: () => FocusScope.of(context).unfocus(),
//       child: Scaffold(
//           body: SizedBox.expand(
//         child: Container(
//           decoration: BoxDecoration(gradient: loginGradient),
//           child: Padding(
//             padding: const EdgeInsets.all(25),
//             child: SingleChildScrollView(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(
//                     height: height / 5,
//                   ),
//                   Text(
//                     "Hey,",
//                     style: TextStyle(
//                         color: Colors.white, fontSize: 40, fontFamily: "benne"),
//                   ),
//                   Text(
//                     "Welcome back",
//                     style: TextStyle(
//                         color: Colors.white, fontSize: 40, fontFamily: "benne"),
//                   ),
//                   Text(
//                     "  Log in to your account",
//                     style: TextStyle(
//                         color: Colors.white, fontFamily: "archivo", fontSize: 10),
//                   ),
//                   SizedBox(
//                     height: height / 9,
//                   ),
//                   TextField(
//                     controller: phoneController,
//                     style: TextStyle(color: Colors.white, fontFamily: "baloo"),
//                     decoration: InputDecoration(
//                       counterText: "",
//                         hintText: "Phone number",
//                         hintStyle: TextStyle(
//                             color: Colors.white,
//                             fontFamily: "baloo",
//                             fontSize: 15),
//                         focusedBorder: UnderlineInputBorder(
//                             borderSide: BorderSide(color: Colors.white)
//                         )
//                     ),
//                     keyboardType: TextInputType.phone,
//                     maxLength: 10,
//
//                   ),
//                   SizedBox(
//                     height: 50,
//                   ),
//                   TextField(
//                     controller: passwordController,
//                     obscureText: !_isPasswordVisible,
//                     style: TextStyle(color: Colors.white, fontFamily: "baloo"),
//                     decoration: InputDecoration(
//                         hintText: "Password",
//                         hintStyle: TextStyle(
//                             color: Colors.white,
//                             fontFamily: "baloo",
//                             fontSize: 15),
//                         focusedBorder: UnderlineInputBorder(
//                             borderSide: BorderSide(color: Colors.white)
//                         ),
//                       suffixIcon: IconButton(onPressed: () {
//                         setState(() {
//                           _isPasswordVisible=!_isPasswordVisible;
//                         });
//                       }, icon: Icon(_isPasswordVisible?Icons.visibility:Icons.visibility_off,color: Colors.white,)
//                       )
//                     ),
//
//                   ),
//                   SizedBox(
//                     height: height / 10,
//                   ),
//                   Center(
//                     child: Stack(
//                       children: [
//                         // Blurred container
//                         ClipRRect(
//                           borderRadius: BorderRadius.circular(30),
//                           child: BackdropFilter(
//                             filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
//                             child: Container(
//                               height: 50,
//                               width: 200,
//                               color:
//                                   Colors.transparent, // Transparent to show blur
//                             ),
//                           ),
//                         ),
//                         // Text on top of blurred container
//                         Consumer<LoginProvider>(
//                           builder: (context1,value,child) {
//                             return GestureDetector(
//                               onTap: () {
//                                 value.userAuthorized(context1, phoneController.text, passwordController.text);
//
//                               },
//                               child: Container(
//                                 height: height / 12,
//                                 width: width,
//                                 decoration: BoxDecoration(
//                                   color: Color(0xff60320D)
//                                       .withOpacity(0.5), // Adjust opacity as neede;
//                                   borderRadius: BorderRadius.circular(20),
//                                 ),
//                                 child: Center(
//                                   child: Text(
//                                     "LOGIN",
//                                     style: TextStyle(
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 18,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             );
//                           }
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         "Don't have an account ?",
//                         style: TextStyle(
//                             color: Colors.white,
//                             fontFamily: "archivo",
//                             fontSize: 10),
//                       ),
//                       GestureDetector(
//                           onTap: () {
//
//                             callNext(context, RegisterScreen());
//                           },
//                           child: Text(
//                             " Sign up",
//                             style: TextStyle(
//                                 color: Color(0xff7CD3CE),
//                                 fontFamily: "archivo",
//                                 fontSize: 12),
//                           )),
//                     ],
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ),
//       )),
//     );
//   }
// }
