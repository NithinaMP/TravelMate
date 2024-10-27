
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:travelmate/user/loginScreen.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;
    return Scaffold(
      body: SizedBox.expand(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/getstarted.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(35),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: height/2,),
                Text(
                  "Plan \nunforgettable \nroad trips",
                  style: TextStyle(
                    fontSize: 25,
                    fontFamily: "archivo",
                    fontWeight: FontWeight.bold,
                    color: Colors.white,

                  ),
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 20),
                Text(
                  "Use roadly to discover and schedule stunning\nroad trips. Made by travellers, for travellers.",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "benne",
                    fontSize: 15,
                    shadows: [
                      Shadow(
                        offset: Offset(1.0, 1.0),
                        blurRadius: 2.0,
                        color: Color.fromARGB(150, 0, 0, 0),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20,),

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
                      // Text on top of blurred container
                      GestureDetector(onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage(),));
                      },
                        child: Container(
                          height: 50,
                          width: 200,
                          decoration: BoxDecoration(
                            color: Color(0xff0C1229).withOpacity(0.5), // Adjust opacity as needed
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Center(
                            child: Text(
                              "GET STARTED",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
