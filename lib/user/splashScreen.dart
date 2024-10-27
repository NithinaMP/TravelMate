import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travelmate/user/getStartedScreen.dart';

import '../constants/constant_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState(){
    super.initState();
    Future.delayed(Duration(seconds: 4),() {
      Navigator.push(context, MaterialPageRoute(builder: (context) => GetStarted(),));
    },);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
            Center(child: ShaderMask(
              shaderCallback: (Rect bounds){
                return textGradient.createShader(bounds);
              },
                child: Text("TravelMate",style: TextStyle(fontFamily: "bakbak",fontSize: 32,color: Colors.white),)))
        ],
      ),
    );
  }
}
