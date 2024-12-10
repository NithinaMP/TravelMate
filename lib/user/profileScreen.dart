import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:travelmate/constants/constant_colors.dart';
import 'package:travelmate/user/wishListScreen.dart';

import 'homeScreen.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;
    return Scaffold(backgroundColor: Colors.black,
      appBar:
      AppBar(
        backgroundColor: Colors.transparent,
       title: Text("Edit Profile",
          style: TextStyle(fontFamily: "bakbak", fontSize: 28,color:Colors.white),
        ),
        leading: InkWell(
            onTap: () {

            },
            // splashColor: Colors.transparent, // Remove splash color
            // highlightColor: Colors.transparent, // Remove highlight color
            child: Icon(Icons.arrow_back_ios_new_sharp,color: Colors.white,size: 40,)
        ),
        // centerTitle: true,
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: height/10,),
            Stack(
              children: [
                Center(
                  child: CircleAvatar(
                    backgroundColor:Colors.grey,
                    radius: 50,

                    child: Container(
                      height: 70,
                      width: 60,
                      child: Icon(Icons.person),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 180,top: 70),
                  child: IconButton(onPressed:() {

                  },
                      icon: Icon(Icons.edit,color: Colors.white,)

                  ),
                )
              ],

            ),
            SizedBox(height: 25,),

            Container(
              child: TextField(
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
            // Padding(
            //   padding: const EdgeInsets.all(20),
            //   child: Container(
            //     child: Column(
            //       children: [
            //         TextFormField(
            //
            //           decoration: InputDecoration(
            //               label: Text("USER NAME",style: TextStyle(fontFamily: "muktaregular",fontSize: 20,color: Colors.white),),
            //               enabledBorder: OutlineInputBorder(borderRadius:BorderRadius.circular(20),borderSide: BorderSide(color: Colors.white)),
            //               border: OutlineInputBorder(borderRadius:BorderRadius.circular(20),borderSide: BorderSide(color: Colors.white,)),
            //               focusedBorder: OutlineInputBorder(borderRadius:BorderRadius.circular(20),borderSide: BorderSide(color: Colors.white))
            //
            //           ),
            //
            //
            //         ),
            //         SizedBox(height: 10,),
            //         TextFormField(
            //
            //           decoration: InputDecoration(
            //               label: Text("PHONE NUMBER",style: TextStyle(fontFamily: "muktaregular",fontSize: 20,color: Colors.white),),
            //               enabledBorder: OutlineInputBorder(borderRadius:BorderRadius.circular(20),borderSide: BorderSide(color: Colors.white)),
            //               border: OutlineInputBorder(borderRadius:BorderRadius.circular(20),borderSide: BorderSide(color: Colors.white,)),
            //               focusedBorder: OutlineInputBorder(borderRadius:BorderRadius.circular(20),borderSide: BorderSide(color: Colors.white))
            //
            //           ),
            //
            //
            //         ),
            //         SizedBox(height: 10,),
            //         TextFormField(
            //
            //           decoration: InputDecoration(
            //               label: Text("PLACE",style: TextStyle(fontFamily: "muktaregular",fontSize: 20,color: Colors.white),),
            //               enabledBorder: OutlineInputBorder(borderRadius:BorderRadius.circular(20),borderSide: BorderSide(color: Colors.white)),
            //               border: OutlineInputBorder(borderRadius:BorderRadius.circular(20),borderSide: BorderSide(color: Colors.white,)),
            //               focusedBorder: OutlineInputBorder(borderRadius:BorderRadius.circular(20),borderSide: BorderSide(color: Colors.white))
            //
            //           ),
            //
            //
            //         ),
            //         SizedBox(height: 10,),
            //
            //       ],
            //     ),
            //   ),
            // ),
            SizedBox(height:height/5,),
            InkWell(
              onTap: () {

              },
              splashColor: Colors.transparent, // Remove splash color
              highlightColor: Colors.transparent, // Remove highlight color
              child: Container(
                height: 55,
                width: width/2.5,
                decoration: BoxDecoration(gradient: admingradient,
                borderRadius: BorderRadius.circular(20)),
                child: Center(child: Text("Save",
                  style: TextStyle(color: Colors.white,fontFamily: "belleza",fontSize: 20),
                ),
                ),
              ),
            ),
            // SizedBox(
            //   height: height/15,
            //   width: width/3,
            //   child: ElevatedButton(
            //     onPressed: () {
            //       Navigator.pop(context);
            //     },
            //     child: Text("SAVE",style: TextStyle(color: Colors.white),),
            //     style: ElevatedButton.styleFrom(backgroundColor: cstOrange1,
            //
            //     ),
            //
            //   ),
            // )


          ],
        ),
      ),
      // bottomNavigationBar: Container(
      //     height: 65,
      //     width: 350,
      //     color: Colors.black,
      //
      //     child:Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //       children: [
      //         Padding(
      //           padding: const EdgeInsets.only(right: 70,top: 10),
      //           child: InkWell(onTap:  () {
      //             Navigator.push(context, MaterialPageRoute(builder: (context) => UserHomePage(),));
      //           },
      //             child: Column(
      //               children: [
      //                 Icon(Icons.home,color:Colors.white,size: 30,),
                      // Text("Home",style: TextStyle(
                      //     color: Colors.white,fontFamily: "allerta"
                      //                 ),),
      //               ],
      //             ),
      //           ),
      //         ),
      //
      //         InkWell(onTap: () {
      //           Navigator.push(context, MaterialPageRoute(builder: (context) => WishlistScreen(),));
      //         },
      //           child: Padding(
      //             padding: const EdgeInsets.only(right:80,top: 10),
      //             child: Column(
      //               children: [
      //                 // Image.asset("assets/icons/like.png",scale: 7,color:  Colors.red,),
      //                 Icon(Icons.favorite_outlined,color: Colors.white,size: 30,),
                      // Text("Wish",style: TextStyle(
                      //     color:  Colors.white,fontFamily: "allerta"
                      //                 ),),
      //               ],
      //             ),
      //           ),
      //         ),
      //         Padding(
      //           padding: const EdgeInsets.only(top:10),
      //           child: InkWell(onTap: () {
      //             Navigator.push(context, MaterialPageRoute(builder: (context) =>  ProfileScreen(),));
      //           },
      //             child: Column(
      //               children: [
      //                 Icon(Icons.person_2_outlined,color: Color(0xffD1A25f),size: 30,),
                      // Text("Account",style: TextStyle(
                      //     color:  Colors.white,fontFamily: "allerta"
                      // ),
                      //                 ),
      //               ],
      //             ),
      //           ),
      //         ),
      //
      //       ],
      //     )
      // ),
    );
  }
}
