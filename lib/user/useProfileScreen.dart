import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:travelmate/constants/call_functions.dart';
import 'package:travelmate/constants/constant_colors.dart';
import 'package:travelmate/provider/loginProvider.dart';
import 'package:travelmate/provider/mainProvider.dart';
import 'package:travelmate/user/myTicketScreen.dart';
import 'package:travelmate/user/profileEditScreen.dart';

class ProfileScreen extends StatelessWidget {
  String userId;
  ProfileScreen({super.key,required this.userId});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var hieght = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          "TravelMate",
          style: TextStyle(
              fontSize: 28,
              fontFamily: "bakbak",
              color: Colors.white,
              // fontWeight: FontWeight.bold
          ),
        ),
        leading: Image.asset(
          "assets/icons/Bar chart-2.png",
          scale: 4,
        ),
        backgroundColor: Colors.black,
      ),

      body: SingleChildScrollView(
        child: Column(

          children: [
            // SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: hieght / 3.5,
                ),

                  Padding(
                  padding: const EdgeInsets.only(left: 40),
                  child: Consumer<LoginProvider>(
                    builder: (context,pValue,child) {
                      return CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 60,
                        child: Icon(Icons.image_rounded),
                        backgroundImage: NetworkImage(pValue.loginPhoto),
                      );
                    }
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20,),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Consumer<LoginProvider>(
                        builder: (context,nValue,child) {
                          return Text(nValue.loginName,
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "benne",
                                fontSize: 25),
                          );
                        }
                      ),
                      Consumer<LoginProvider>(
                        builder: (context,pValue,child) {
                          return Text(pValue.loginPhone,
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "belleza",
                                fontSize: 17),
                          );
                        }
                      ),
                      SizedBox(height: 5,),

                      //edit profile
                      Consumer<LoginProvider>(
                        builder: (context2,eValue,child) {
                          return InkWell(
                            onTap: () {
                              eValue.editRegistration(userId);
                              callNext(context, ProfileEditScreen(userId: userId,));

                            },
                            splashColor: Colors.transparent, // Remove splash color
                            highlightColor: Colors.transparent, // Remove highlight color
                            child: Container(height: 40,width: width/3,
                            decoration: BoxDecoration(border: Border.all(color: Colors.brown),
                                borderRadius: BorderRadius.circular(20)),
                            child: Center(
                              child:
                              Text("Edit",style: TextStyle(color: Colors.white,fontFamily: "belleza",),),)),
                          );
                        }
                      ),

                    ],
                  ),
                ),

              ],
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(7.0),
                child: Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Consumer<MainProvider>(
                          builder: (context1,tValue,child) {
                            return Container(
                              height: hieght/8,
                              width: width/1.05,
                              decoration: BoxDecoration(gradient: admingradient,borderRadius: BorderRadius.circular(20)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    ListTile(
                                      leading: Image.asset("assets/image/tickets.png",height: 32,width: 32),
                                      title: Text("My Tickets",style: TextStyle(fontFamily: "benne",fontSize: 18,color: Colors.white),),
                                      subtitle: Text("Find booked tickets, price and more",style: TextStyle(fontFamily: "baloo",fontSize: 12,color: Colors.grey),),
                                      trailing: Icon(Icons.arrow_forward_ios_sharp,size: 20,color: Colors.white,),
                                      onTap: () {
                                        tValue.getDestReceipt(userId);
                                        callNext(context, MyTicketScreen(userId: userId,));
                                      },
                                    )
                                  ],
                                ),
                              ),
                            );
                          }
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Container(
                          height: hieght/8,
                          width: width/1.05,
                          decoration: BoxDecoration(gradient: admingradient,borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                ListTile(
                                  leading: Icon(Icons.favorite_outline,size: 32,color: Color(0xffD1A25f)),
                                  title: Text("Wish List",style: TextStyle(fontFamily: "benne",fontSize: 18,color: Colors.white),),
                                  subtitle: Text("Your favourite destinations and more",style: TextStyle(fontFamily: "baloo",fontSize: 12,color: Colors.grey),),
                                  trailing: Icon(Icons.arrow_forward_ios_sharp,size: 20,color: Colors.white,),
                                  onTap: () {},
                                )
                              ],
                            ),
                          ),
                        ),
                      ),

                      Consumer<MainProvider>(
                        builder: (context1,logValue,child) {
                          return Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Container(
                              height: hieght/8,
                              width: width/1.05,
                              decoration: BoxDecoration(gradient: admingradient,borderRadius: BorderRadius.circular(20)),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  children: [
                                    ListTile(
                                      leading: Icon(Icons.sign_language_outlined,size: 32,color: Color(0xffD1A25f),),
                                      title: Text("Sign Out",style: TextStyle(fontFamily: "benne",fontSize: 18,color: Colors.white),),
                                      trailing: Icon(Icons.arrow_forward_ios_sharp,size: 20,color: Colors.white,),
                                      onTap: () {
                                        logValue.logOutAlert(context1);
                                      },
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                      ),


                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
