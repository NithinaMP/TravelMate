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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40),
        child: AppBar(
          backgroundColor: Colors.transparent,

         title: Text(
            "PROFILE",
            style: TextStyle(fontFamily: "tradeWinds", fontSize: 20,color:Colors.white),
          ),
          centerTitle: true,
        ),
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
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                child: Column(
                  children: [
                    TextFormField(

                      decoration: InputDecoration(
                          label: Text("USER NAME",style: TextStyle(fontFamily: "muktaregular",fontSize: 20,color: Colors.white),),
                          enabledBorder: OutlineInputBorder(borderRadius:BorderRadius.circular(20),borderSide: BorderSide(color: Colors.white)),
                          border: OutlineInputBorder(borderRadius:BorderRadius.circular(20),borderSide: BorderSide(color: Colors.white,)),
                          focusedBorder: OutlineInputBorder(borderRadius:BorderRadius.circular(20),borderSide: BorderSide(color: Colors.white))

                      ),


                    ),
                    SizedBox(height: 10,),
                    TextFormField(

                      decoration: InputDecoration(
                          label: Text("PHONE NUMBER",style: TextStyle(fontFamily: "muktaregular",fontSize: 20,color: Colors.white),),
                          enabledBorder: OutlineInputBorder(borderRadius:BorderRadius.circular(20),borderSide: BorderSide(color: Colors.white)),
                          border: OutlineInputBorder(borderRadius:BorderRadius.circular(20),borderSide: BorderSide(color: Colors.white,)),
                          focusedBorder: OutlineInputBorder(borderRadius:BorderRadius.circular(20),borderSide: BorderSide(color: Colors.white))

                      ),


                    ),
                    SizedBox(height: 10,),
                    TextFormField(

                      decoration: InputDecoration(
                          label: Text("PLACE",style: TextStyle(fontFamily: "muktaregular",fontSize: 20,color: Colors.white),),
                          enabledBorder: OutlineInputBorder(borderRadius:BorderRadius.circular(20),borderSide: BorderSide(color: Colors.white)),
                          border: OutlineInputBorder(borderRadius:BorderRadius.circular(20),borderSide: BorderSide(color: Colors.white,)),
                          focusedBorder: OutlineInputBorder(borderRadius:BorderRadius.circular(20),borderSide: BorderSide(color: Colors.white))

                      ),


                    ),
                    SizedBox(height: 10,),

                  ],
                ),
              ),
            ),
            SizedBox(height: 25,),
            SizedBox(
              height: height/15,
              width: width/3,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("SAVE",style: TextStyle(color: Colors.white),),
                style: ElevatedButton.styleFrom(backgroundColor: cstOrange1,

                ),

              ),
            )


          ],
        ),
      ),
      bottomNavigationBar: Container(
          height: 65,
          width: 350,
          color: Colors.black,

          child:Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 70,top: 10),
                child: InkWell(onTap:  () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => UserHomePage(),));
                },
                  child: Column(
                    children: [
                      Icon(Icons.home,color:Colors.white,),
                      Text("Home",style: TextStyle(
                          color: Colors.white,fontFamily: "allerta"
                      ),),
                    ],
                  ),
                ),
              ),

              InkWell(onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => WishlistScreen(),));
              },
                child: Padding(
                  padding: const EdgeInsets.only(right:80,top: 10),
                  child: Column(
                    children: [
                      // Image.asset("assets/icons/like.png",scale: 7,color:  Colors.red,),
                      Icon(Icons.favorite,color: Colors.white,),
                      Text("Wish",style: TextStyle(
                          color:  Colors.white,fontFamily: "allerta"
                      ),),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top:10),
                child: InkWell(onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>  ProfileScreen(),));
                },
                  child: Column(
                    children: [
                      Icon(Icons.person,color:  Colors.yellow,),
                      Text("Account",style: TextStyle(
                          color:  Colors.white,fontFamily: "allerta"
                      ),
                      ),
                    ],
                  ),
                ),
              ),

            ],
          )
      ),
    );
  }
}
