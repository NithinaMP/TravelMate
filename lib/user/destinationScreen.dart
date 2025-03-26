// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';
// import 'package:provider/provider.dart';
// import 'package:travelmate/constants/call_functions.dart';
// import 'package:travelmate/models/adminModels.dart';
// import 'package:travelmate/provider/mainProvider.dart';
// import 'package:travelmate/refactors/showBottomSheet.dart';
//
// import 'bookTicket.dart';
// import 'confirmBooking.dart';
//
// class DestinationScreen extends StatelessWidget {
//   DestinationModel destDestails;
//   String userId;
//
//   DestinationScreen({
//     Key? key,
//     required this.destDestails,
//     required this.userId,
//
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     var height=MediaQuery.of(context).size.height;
//     var width=MediaQuery.of(context).size.width;
//     return GestureDetector(
//       onTap: () => FocusScope.of(context).unfocus(),
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text(destDestails.destName, style: TextStyle(color: Colors.white)),
//           backgroundColor: Colors.black,
//         ),
//         body: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               Container(
//                 height: 300,
//                 decoration: BoxDecoration(
//                   image: DecorationImage(
//                     image: NetworkImage(destDestails.destImage),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Consumer<MainProvider>(
//                   builder: (context,dValue,child) {
//                     return Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           destDestails.destName,
//                           style: TextStyle(
//                             fontSize: 28,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         SizedBox(height: 8),
//                         Text(
//                           '${destDestails.destPlace}, ${destDestails.destDistrict}',
//                           style: TextStyle(
//                             fontSize: 20,
//                             color: Colors.grey,
//                           ),
//                         ),
//                         SizedBox(height: 16),
//                         Text(destDestails.destDescription,
//                           style: TextStyle(fontSize: 16),
//                         ),
//
//                         SizedBox(height: 16),
//                         Text("Best time to visit:   ${destDestails.destBestTime}", style: TextStyle(
//                     fontSize: 15,
//                     fontWeight: FontWeight.w800,
//                     ),),
//                         SizedBox(height: 16),
//                         Container(
//                           height: 200,
//                           width: width,
//                           decoration: BoxDecoration(
//                             image: DecorationImage(
//                                 image: AssetImage("assets/location.jpeg"),
//                               fit: BoxFit.fill
//                             ),
//
//                           ),
//                         ),
//                         SizedBox(height: 10,),
//                         ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.yellow.shade600
//                           ),
//                           onPressed: () {
//                             selectCountBottomSheet(context,"Destination", userId, destDestails.destId, null);
//                             // selectCountBottomSheet(context, "DestinationScreen", userId);
//
//                             // Implement the action for booking or more details
//                           },
//                           child: Text("Continue",style: TextStyle(color: Colors.black),),
//                         ),
//                       ],
//                     );
//                   }
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   void Terms_condition(BuildContext context,num selectedCount) {
//
//     //calculate total entry fee
//     num totalEntryFee=destDestails.destEntryFee*selectedCount;
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true, // Allows proper positioning
//       backgroundColor: Colors.transparent, // Make the background transparent to control the width
//       builder: (context) {
//         return Container(
//           width: MediaQuery.of(context).size.width, // Full screen width
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//             child: Column(
//               mainAxisSize: MainAxisSize.min, // Adjust to content height
//               children: [
//                 SizedBox(height: 10),
//                 Text(
//                   "Terms & conditions",
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//                 SizedBox(height: 10),
//                 Text("1. All bookings are subject to availability and confirmation."
//                     "\n2. Payments must be completed at the time of booking."
//                   "\n3. Once a booking is confirmed, it cannot be canceled or refunded unless explicitly mentioned."
// "                  \n4. Users are responsible for ensuring the accuracy of the details entered during the booking process."
// "                  \n5. TravelMate is not liable for any issues caused by third-party service providers."
// "                  \n6. Tickets and bookings are non-transferable unless stated otherwise."
// "                 \n7.  Event timings, availability, and details are subject to changes by the organizer without prior notice."
// "                 \n8.  TravelMate reserves the right to cancel or modify a booking if fraud or misuse is detected."
// "                  \n9. Any disputes arising from bookings must be addressed as per the laws of Kerala."
// "                  \n10. By proceeding, you agree to comply with these terms and conditions."
// "                  "),
//                 SizedBox(height: 20,),
//
//                 ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.red,
//                       minimumSize: Size(double.infinity, 50),
//                     ),
//                     onPressed: () {
//                       print("navigate to confirmbooking $userId");
//
//                       callNext(context,
//                           ConfirmBooking(
//                         userId: userId,
//                         destId: destDestails.destId,
//                         destName: destDestails.destName,
//                         destPlace: destDestails.destPlace,
//                         destDistrict: destDestails.destDistrict,
//                         destEntryFee: totalEntryFee.toString(),
//                             selectedCount:selectedCount.toInt(), destImage: destDestails.destImage,
//                       ));
//
//                 }, child: Text("Ok",style: TextStyle(color: Colors.white,fontSize: 16,
//                   fontWeight: FontWeight.bold,),))
//
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
//
// }



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:travelmate/constants/call_functions.dart';
import 'package:travelmate/models/adminModels.dart';
import 'package:travelmate/provider/mainProvider.dart';

import 'bookTicket.dart';
import 'confirmBooking.dart';
class DestinationScreen extends StatefulWidget {
  DestinationModel item;
  String userId;
  DestinationScreen({super.key,required this.item,
    required this.userId,});

  @override
  State<DestinationScreen> createState() => _DestinationScreenState();
}

class _DestinationScreenState extends State<DestinationScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true); // Add reverse to create pulsing effect

    _animation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Consumer<MainProvider>(
            builder: (context,dValue,child) {
              return Column(
                children: [
                  Stack(
                    children: [
                      // Event Image
                      // Container(
                      //   width: width,
                      //   height: height / 3,
                      //   decoration: BoxDecoration(
                      //     image: DecorationImage(
                      //       image: AssetImage("assets/image/jatayu.jpg"),
                      //       fit: BoxFit.cover,
                      //     ),
                      //   ),
                      // ),

                      Container(
                        width: width,
                        height: height / 3,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(widget.item.destImage),
                            // image: NetworkImage("https://i.pinimg.com/1200x/64/fb/3f/64fb3f6f20e98a7bc2d63e792cff83d1.jpg"),
                            fit: BoxFit.cover,
                            onError: (exception, stackTrace) {
                              // Optional: Add error handling logic
                              print('Error loading image: $exception');
                            },
                          ),
                          color: Colors.grey[300], // Optional: background color while loading
                        ),
                        child: FutureBuilder(
                          future: precacheImage(
                            NetworkImage(widget.item.destImage),
                            context,
                          ),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState != ConnectionState.done) {
                              // return Center(child: CircularProgressIndicator());
                            }
                            return Container(); // Empty container once image is loaded
                          },
                        ),
                      ),
                      // Back Icon (Overlay at Top-Left)
                      Positioned(
                        top: 40,
                        left: 20,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.arrow_back_ios_new_sharp,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  // Event Name + Favorite Icon
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text( widget.item.destName,
                          // "Jatayu Earth Center",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "playfair",
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // Handle favorite action
                            dValue.toggleFavorite(widget.userId, widget.item.destId, context);
                            print("favourite button cliked");
                          },
                          child: Icon(Icons.favorite_border, color: Colors.white, size: 35),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),

                  // About Event Section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "About Destination",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "bakbak",
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(widget.item.destDescription,
                          // "Jatayu Earth's Center, a unique tourism destination that integrates Culture, Art, Adventure, Entertainment and Health with Mother Nature! The eco-friendly tourism destination is a unique combination of the hills, valleys, caves, and vegetation spread across 65 acres of land, almost unaffected even though a crowd-pulling tourist destination is built right there."
                          //     "\n\nMain Attractions:"
                          //     "\n * World's Largest Bird Sculpture"
                          //     "\n * Cable Car Ride"
                          //     "\n * Hilltop camping"
                          //     "\n * Adventure Activities"
                          //     "\n * Helicopter ride"
                          //     "\n * 360-degree nature view"
                          //     "\n * Health Tourism"
                          //     "\n * Family-friendly tourist destination",
                          softWrap: true,
                          style: TextStyle(
                            fontFamily: "baloo",
                            fontSize: 13,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Event Details Section
                  Container(
                    width: width,
                    decoration: BoxDecoration(
                      color: Colors.lightGreen,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // buildDetailRow(Icons.calendar_month_outlined, "Working Days: Monday to Saturday"),
                          // buildDetailRow(Icons.access_time_outlined, "Opens: 10 AM to 3 PM"),
                          // buildDetailRow(Icons.tour_outlined, "Nature park, adventure park"),
                          buildDetailRow(Icons.checklist_sharp, "Best Time to visit: ${widget.item.destBestTime}"),
                          buildDetailRow(Icons.location_on_outlined, '${widget.item.destPlace}, ${widget.item.destDistrict}'),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Location",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "bakbak",
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),

                  GestureDetector(
                    onTap: () {
                      // Handle tap event
                    },
                    child: Container(
                      height: 170,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.blueGrey.shade900, Colors.black87],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 15,
                            spreadRadius: 5,
                            offset: Offset(4, 4),
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: AnimatedBuilder(
                              animation: _animation,
                              builder: (context, child) {
                                return Transform.scale(
                                  scale: _animation.value,
                                  child: Image.network(
                                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQaJLD8kNNXkonPRrnlSI1aD0P8vWI2TZQ5pg&s',
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: double.infinity,
                                    loadingBuilder: (context, child, loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return Center(
                                        child: CircularProgressIndicator(
                                          value: loadingProgress.expectedTotalBytes != null
                                              ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                              : null,
                                        ),
                                      );
                                    },
                                    errorBuilder: (context, error, stackTrace) {
                                      return Center(
                                        child: Icon(Icons.error, color: Colors.red),
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                          Positioned(
                            bottom: 10,
                            left: 10,
                            right: 10,
                            child: InkWell(
                              onTap: () {
                                dValue.launchGoogleMaps();
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.6),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  "Open on Maps",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "playfair",
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Book Now Button
                  // Center(
                  //   child: GestureDetector(
                  //     onTap: () {
                  //       // Handle booking
                  //     },
                  //     child: Container(
                  //       width: width / 1.5,
                  //       height: 70,
                  //       decoration: BoxDecoration(
                  //         color: Colors.redAccent,
                  //         borderRadius: BorderRadius.circular(20),
                  //       ),
                  //       child: Center(
                  //         child: Text(
                  //           "Book Now",
                  //           style: TextStyle(
                  //             fontFamily: "benne",
                  //             fontSize: 25,
                  //             color: Colors.white,
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),

                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle booking
                        showBottomSheet(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        padding: EdgeInsets.symmetric(horizontal: 64, vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 5,
                      ),
                      child: Text(
                        "Book Now",
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),


                  const SizedBox(height: 30),
                ],
              );
            }
        ),
      ),
    );
  }
  void showBottomSheet(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    showModalBottomSheet(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 10),
              Text(
                "How many members ?",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Lottie.asset("assets/lottie/travel.json",height: 100,width: width),

              SizedBox(height: 10),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 50, // Adjust the height of the row container
                      child: Consumer<MainProvider>(
                        builder: (context, dvalue, child) {
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              final selectedIndex = dvalue.selectedIndex;

                              return GestureDetector(
                                onTap: () {
                                  dvalue.selectIndex(index);
                                  print("Selected: ${index + 1} seats");
                                },
                                child: Container(
                                  height: 40,
                                  width: 50,
                                  margin: const EdgeInsets.symmetric(horizontal: 4),
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: selectedIndex == index
                                        ? Colors.redAccent
                                        : Colors.grey[200],
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "${index + 1}",
                                      style: TextStyle(
                                        color: selectedIndex == index
                                            ? Colors.white
                                            : Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    Consumer<MainProvider>(
                      builder: (context, dvalue, child) {
                        return ElevatedButton(
                          onPressed: dvalue.selectedIndex == -1
                              ? null // Button disabled when no number is selected
                              : () {
                            // proceed with booking

                            print("Navigate to terms and conditions ${widget.userId}");
                            Terms_condition(context,dvalue.selectedCount);
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(double.infinity, 50),
                            backgroundColor: dvalue.selectedIndex == -1
                                ? Colors.grey // Disabled button color
                                : Colors.redAccent, // Active button color
                          ),
                          child: Text(
                            "Select",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: dvalue.selectedIndex == -1
                                  ? Colors.black54 // Disabled text color
                                  : Colors.white, // Active text color
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),


            ],
          ),
        );
      },
    );
  }

  void Terms_condition(BuildContext context,num selectedCount) {

    //calculate total entry fee
    num totalEntryFee=widget.item.destEntryFee*selectedCount;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allows proper positioning
      backgroundColor: Colors.transparent, // Make the background transparent to control the width
      builder: (context) {
        return Container(
          width: MediaQuery.of(context).size.width, // Full screen width
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min, // Adjust to content height
              children: [
                SizedBox(height: 10),
                Text(
                  "Terms & conditions",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text("1. All bookings are subject to availability and confirmation."
                    "\n2. Payments must be completed at the time of booking."
                    "\n3. Once a booking is confirmed, it cannot be canceled or refunded unless explicitly mentioned."
                    "                  \n4. Users are responsible for ensuring the accuracy of the details entered during the booking process."
                    "                  \n5. TravelMate is not liable for any issues caused by third-party service providers."
                    "                  \n6. Tickets and bookings are non-transferable unless stated otherwise."
                    "                 \n7.  Event timings, availability, and details are subject to changes by the organizer without prior notice."
                    "                 \n8.  TravelMate reserves the right to cancel or modify a booking if fraud or misuse is detected."
                    "                  \n9. Any disputes arising from bookings must be addressed as per the laws of Kerala."
                    "                  \n10. By proceeding, you agree to comply with these terms and conditions."
                    "                  "),
                SizedBox(height: 20,),

                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      minimumSize: Size(double.infinity, 50),
                    ),
                    onPressed: () {
                      print("navigate to confirmbooking ${widget.userId}");

                      callNext(context,
                          ConfirmBooking(
                            userId: widget.userId,
                            destId: widget.item.destId,
                            Name: widget.item.destName,
                            Place: widget.item.destPlace,
                            District: widget.item.destDistrict,
                            EntryFee: totalEntryFee.toString(),
                            selectedCount:selectedCount.toInt(),
                            Image: widget.item.destImage,
                            from: 'Destination',
                          ));

                    }, child: Text("Ok",style: TextStyle(color: Colors.white,fontSize: 16,
                  fontWeight: FontWeight.bold,),))

              ],
            ),
          ),
        );
      },
    );
  }
  Widget buildDetailRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 25),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 15, fontFamily: "bakbak", color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
//finalcode
// class DestinationScreen extends StatelessWidget {
//   DestinationModel item;
//   String userId;
//
//   DestinationScreen({
//     Key? key,
//     required this.item,
//     required this.userId,
//
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     var height=MediaQuery.of(context).size.height;
//     var width=MediaQuery.of(context).size.width;
//     return GestureDetector(
//       onTap: () => FocusScope.of(context).unfocus(),
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text(item.destName, style: TextStyle(color: Colors.white)),
//           backgroundColor: Colors.black,
//         ),
//         body: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               Container(
//                 height: 300,
//                 decoration: BoxDecoration(
//                   image: DecorationImage(
//                     image: NetworkImage(item.destImage),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Consumer<MainProvider>(
//                   builder: (context,dValue,child) {
//                     return Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               item.destName,
//                               style: TextStyle(
//                                 fontSize: 28,
//                                 fontWeight: FontWeight.bold,
//                               ),
//
//                             ),
//                             GestureDetector(
//                               onTap: () {
//                                 dValue.toggleFavorite(userId, item.destId, context);
//                                 print("favourite button cliked");
//                               },
//                               child: Padding(
//                                 padding: const EdgeInsets.only(right: 8.0),
//                                 child: Icon(dValue.isLiked?Icons.favorite:Icons.favorite_border,color: dValue.isLiked?Colors.red:Colors.red,),
//                               ),
//                             ),
//
//                           ],
//                         ),
//                         SizedBox(height: 8),
//                         Text(
//                           '${item.destPlace}, ${item.destDistrict}',
//                           style: TextStyle(
//                             fontSize: 20,
//                             color: Colors.grey,
//                           ),
//                         ),
//                         SizedBox(height: 16),
//                         Text(item.destDescription,
//                           style: TextStyle(fontSize: 16),
//                         ),
//
//                         SizedBox(height: 16),
//                         Text("Best time to visit:   ${item.destBestTime}", style: TextStyle(
//                     fontSize: 15,
//                     fontWeight: FontWeight.w800,
//                     ),),
//                         SizedBox(height: 16),
//                         Consumer<MainProvider>(
//                           builder: (context1,mapValue,child) {
//                             return InkWell(
//                               onTap: () {
//                                 print("Clicked map");
//                                 mapValue.launchGoogleMaps();
//                                 print("Viewinggg");
//                               },
//                               child: Container(
//                                 height: 200,
//                                 width: width,
//                                 decoration: BoxDecoration(
//                                   image: DecorationImage(
//                                       image: AssetImage("assets/location.jpeg"),
//                                     fit: BoxFit.fill
//                                   ),
//
//
//                                 ),
//                                 child: Center(child: Image.asset("assets/icons/map.png",scale: 8,)),
//                               ),
//                             );
//                           }
//                         ),
//                         SizedBox(height: 10,),
//                         ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.yellow.shade600
//                           ),
//                           onPressed: () {
//                             showBottomSheet(context);
//                             // callNext(context, BookticketWidget());
//                             // Implement the action for booking or more details
//                           },
//                           child: Text("Continue",style: TextStyle(color: Colors.black),),
//                         ),
//                       ],
//                     );
//                   }
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//   void showBottomSheet(BuildContext context) {
//     var height = MediaQuery.of(context).size.height;
//     var width = MediaQuery.of(context).size.width;
//
//     showModalBottomSheet(
//       backgroundColor: Colors.white,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//       ),
//       isScrollControlled: true,
//       context: context,
//       builder: (context) {
//         return Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               SizedBox(height: 10),
//               Text(
//                 "How many members ?",
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 10),
//              Lottie.asset("assets/lottie/travel.json",height: 100,width: width),
//
//               SizedBox(height: 10),
//               Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Container(
//                       height: 50, // Adjust the height of the row container
//                       child: Consumer<MainProvider>(
//                         builder: (context, dvalue, child) {
//                           return ListView.builder(
//                             scrollDirection: Axis.horizontal,
//                             itemBuilder: (context, index) {
//                               final selectedIndex = dvalue.selectedIndex;
//
//                               return GestureDetector(
//                                 onTap: () {
//                                   dvalue.selectIndex(index);
//                                   print("Selected: ${index + 1} seats");
//                                 },
//                                 child: Container(
//                                   height: 40,
//                                   width: 50,
//                                   margin: const EdgeInsets.symmetric(horizontal: 4),
//                                   padding: const EdgeInsets.all(10),
//                                   decoration: BoxDecoration(
//                                     color: selectedIndex == index
//                                         ? Colors.redAccent
//                                         : Colors.grey[200],
//                                     borderRadius: BorderRadius.circular(50),
//                                   ),
//                                   child: Center(
//                                     child: Text(
//                                       "${index + 1}",
//                                       style: TextStyle(
//                                         color: selectedIndex == index
//                                             ? Colors.white
//                                             : Colors.black,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               );
//                             },
//                           );
//                         },
//                       ),
//                     ),
//                     SizedBox(height: 20),
//                     Consumer<MainProvider>(
//                       builder: (context, dvalue, child) {
//                         return ElevatedButton(
//                           onPressed: dvalue.selectedIndex == -1
//                               ? null // Button disabled when no number is selected
//                               : () {
//                             // proceed with booking
//
//                             print("Navigate to terms and conditions $userId");
//                             Terms_condition(context,dvalue.selectedCount);
//                           },
//                           style: ElevatedButton.styleFrom(
//                             minimumSize: Size(double.infinity, 50),
//                             backgroundColor: dvalue.selectedIndex == -1
//                                 ? Colors.grey // Disabled button color
//                                 : Colors.redAccent, // Active button color
//                           ),
//                           child: Text(
//                             "Select",
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                               color: dvalue.selectedIndex == -1
//                                   ? Colors.black54 // Disabled text color
//                                   : Colors.white, // Active text color
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//
//
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   void Terms_condition(BuildContext context,num selectedCount) {
//
//     //calculate total entry fee
//     num totalEntryFee=item.destEntryFee*selectedCount;
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true, // Allows proper positioning
//       backgroundColor: Colors.transparent, // Make the background transparent to control the width
//       builder: (context) {
//         return Container(
//           width: MediaQuery.of(context).size.width, // Full screen width
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//             child: Column(
//               mainAxisSize: MainAxisSize.min, // Adjust to content height
//               children: [
//                 SizedBox(height: 10),
//                 Text(
//                   "Terms & conditions",
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//                 SizedBox(height: 10),
//                 Text("1. All bookings are subject to availability and confirmation."
//                     "\n2. Payments must be completed at the time of booking."
//                   "\n3. Once a booking is confirmed, it cannot be canceled or refunded unless explicitly mentioned."
// "                  \n4. Users are responsible for ensuring the accuracy of the details entered during the booking process."
// "                  \n5. TravelMate is not liable for any issues caused by third-party service providers."
// "                  \n6. Tickets and bookings are non-transferable unless stated otherwise."
// "                 \n7.  Event timings, availability, and details are subject to changes by the organizer without prior notice."
// "                 \n8.  TravelMate reserves the right to cancel or modify a booking if fraud or misuse is detected."
// "                  \n9. Any disputes arising from bookings must be addressed as per the laws of Kerala."
// "                  \n10. By proceeding, you agree to comply with these terms and conditions."
// "                  "),
//                 SizedBox(height: 20,),
//
//                 ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.red,
//                       minimumSize: Size(double.infinity, 50),
//                     ),
//                     onPressed: () {
//                       print("navigate to confirmbooking $userId");
//
//                       callNext(context,
//                           ConfirmBooking(
//                         userId: userId,
//                         destId: item.destId,
//                         Name: item.destName,
//                         Place: item.destPlace,
//                         District: item.destDistrict,
//                         EntryFee: totalEntryFee.toString(),
//                             selectedCount:selectedCount.toInt(),
//                             Image: item.destImage,
//                             from: 'Destination',
//                       ));
//
//                 }, child: Text("Ok",style: TextStyle(color: Colors.white,fontSize: 16,
//                   fontWeight: FontWeight.bold,),))
//
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
//
// }
