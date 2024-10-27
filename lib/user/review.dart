import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class reviewWidget extends StatelessWidget {
  const reviewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    List<String>images=[
      "assets/image/jatayu.jpg",
      "assets/image/travel3.jpg",
      "assets/image/jatayu.jpg",
      "assets/image/travel3.jpg",
      "assets/image/jatayu.jpg",
      "assets/image/travel3.jpg",
      "assets/image/jatayu.jpg",
      "assets/image/travel3.jpg",
    ];
    return Scaffold(
          backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text("Review",
          style: TextStyle(color: Colors.white,fontFamily: "benne",fontSize: 32),),
          leading: Icon(Icons.arrow_back_ios,color: Colors.white,size: 40,),
            backgroundColor: Colors.black,

        ),
      body:SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
                itemCount: images.length,
                physics: ScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Container(
                          height: 200,
                          width: 500,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                              image: AssetImage(images[index]),

                              fit: BoxFit.fill
                            )
                          ),


                        ),
                        ListTile(
                          leading: CircleAvatar(backgroundImage: AssetImage("assets/image/profilepic.jpg"),),
                        title: Row(
                          children: [
                            Column(crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("NITHINA",style: TextStyle(color: Colors.white,fontFamily: "benne",fontSize: 10),),
                                Text("Nice place",style: TextStyle(color: Colors.white,fontFamily: "benne",fontSize: 10),),
                              ],
                            ),
                           //Image.asset("assets/image/rating.png",scale: 25,)
                          ],

                        ),

                        ),
                        
                      ],
                    ),
                  );
                },)
          ],
        ),
      )
      // ListView(
      //   children: [
      //     Card(
      //       shape: RoundedRectangleBorder(
      //           borderRadius:BorderRadius.circular(20)),
      //       child: Column(
      //         crossAxisAlignment: CrossAxisAlignment.center,
      //       children: [
      //         Image.asset("assets/image/travel3.jpg"),
      //         ListTile(
      //         title: Text("Nithina MP",style: TextStyle(fontFamily: "bakbak",fontSize:19 ),),
      //         leading: CircleAvatar(
      //           backgroundImage: AssetImage("assets/image/profilepic.jpg"),
      //         ),
      //       ),
      //         ListTile(
      //           title: Text("Nice View",
      //             style:TextStyle(fontSize: 15,fontFamily: "baloo") ,),
      //         )
      //       ],
      //     ),
      //     ),
      //
      //   //   Container(
      //   // decoration: BoxDecoration(
      //   //   borderRadius: BorderRadius.circular(30)
      //   // ),
      //   //     height: 300,width: 300,
      //   //     child: Image.asset("assets/image/jatayu.jpg",
      //   //       // fit: BoxFit.fitWidth,
      //   //     ),
      //   //   )
      //
      //   ],
      // ),

    );
  }
}

