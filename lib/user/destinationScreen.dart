import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travelmate/constants/call_functions.dart';

import 'bookTicket.dart';

class DestinationScreen extends StatelessWidget {
  final String imagePath;
  final String destinationName;
  final String location;

  const DestinationScreen({
    Key? key,
    required this.imagePath,
    required this.destinationName,
    required this.location,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(destinationName, style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    destinationName,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    location,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Description of $destinationName goes here. You can include details about the place, activities to do, best time to visit, and other relevant information.",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  Container(
                    height: 200,
                    width: width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/location.jpeg"),
                        fit: BoxFit.fill
                      ),

                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      callNext(context, BookticketWidget());
                      // Implement the action for booking or more details
                    },
                    child: Text("Book Now"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}