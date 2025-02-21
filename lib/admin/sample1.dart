import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelmate/admin/eventBookedPeoples.dart';
import 'package:travelmate/constants/call_functions.dart';
import 'package:travelmate/constants/constant_colors.dart';

import 'package:flutter/cupertino.dart';
import 'package:travelmate/models/userModel.dart';
import 'package:travelmate/provider/mainProvider.dart';
///
// class BookingListScreen extends StatelessWidget {
//
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 2, // Two tabs: Events and Destinations
//       child: Scaffold(
//         appBar: AppBar(
//           leading: InkWell(
//             onTap: () {
//               backto(context);
//             },
//             child: Icon(Icons.arrow_back_ios_new_sharp, size: 32),
//           ),
//           title: const Text(
//             "My Bookings",
//             style: TextStyle(
//               fontSize: 24,
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//             ),
//           ),
//           flexibleSpace: Container(
//             decoration: BoxDecoration(
//               gradient: admingradient,
//             ),
//           ),
//           bottom: const TabBar(
//             tabs: [
//               Tab(
//                 icon: Icon(Icons.event, color: Colors.white),
//                 child: Text("Events", style: TextStyle(color: Colors.white)),
//               ),
//               Tab(
//                 icon: Icon(Icons.place, color: Colors.white),
//                 child: Text("Destinations", style: TextStyle(color: Colors.white)),
//               ),
//             ],
//             indicatorColor: Colors.white,
//             indicatorWeight: 4,
//           ),
//         ),
//         body: Container(
//           decoration: BoxDecoration(
//             color: Colors.white,
//           ),
//           child: Consumer<MainProvider>(
//             builder: (context, value, child) {
//               return TabBarView(
//                 children: [
//                   // Events Tab
//                   _buildBookingList(),
//                   // Destinations Tab
//                   _buildDBookingList(),
//                 ],
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildBookingList() {
//     return Consumer<MainProvider>(
//       builder: (context, eValue, child) {
//         return ListView.builder(
//           padding: const EdgeInsets.all(16),
//           itemCount: eValue.loadAllEventBookingsList.length,
//           itemBuilder: (context, index) {
//             var booking = eValue.loadAllEventBookingsList[index];
//             return Card(
//               margin: const EdgeInsets.only(bottom: 16),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               elevation: 4,
//               child: InkWell(
//                 onTap: () {
//                   showDialog(
//                     context: context,
//                     builder: (context) => AlertDialog(
//                       backgroundColor: Colors.black,
//                       title: Text(booking.eventName, style: const TextStyle(color: Colors.white)),
//                       content: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Image.network(
//                             booking.eventImage,
//                             height: 150,
//                             fit: BoxFit.cover,
//                           ),
//                           const SizedBox(height: 10),
//                           Text("Date: ${booking.eventDate}", style: const TextStyle(color: Colors.white)),
//                           Text("Location: ${booking.eventPlace}, ${booking.eventDistrict}", style: const TextStyle(color: Colors.white)),
//                           Text("Tickets: ${booking.totalMembers}", style: const TextStyle(color: Colors.white)),
//                           Text("Total Price: ₹${booking.totalAmount}", style: const TextStyle(color: Colors.white)),
//                         ],
//                       ),
//                       actions: [
//                         TextButton(
//                           onPressed: () {
//                             callNext(context, EventBookedPeoples());
//                           },
//                           child: const Text("View", style: TextStyle(color: Colors.orange)),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     ClipRRect(
//                       borderRadius: const BorderRadius.only(
//                         topLeft: Radius.circular(16),
//                         bottomLeft: Radius.circular(16),
//                       ),
//                       child: Image.network(
//                         booking.eventImage,
//                         width: 120,
//                         height: 120,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                     Expanded(
//                       child: Padding(
//                         padding: const EdgeInsets.all(12),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               booking.eventName,
//                               style: const TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.deepPurple,
//                               ),
//                             ),
//                             const SizedBox(height: 8),
//                             Text("Date: ${booking.eventDate}", style: TextStyle(color: Colors.grey.shade700)),
//                             Text("Tickets: ${booking.totalMembers}", style: TextStyle(color: Colors.grey.shade700)),
//                             Text("Total Price: ₹${booking.totalAmount}", style: const TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold)),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
//
//   Widget _buildDBookingList() {
//     return Consumer<MainProvider>(
//       builder: (context, eValue, child) {
//         return ListView.builder(
//           padding: const EdgeInsets.all(16),
//           itemCount: eValue.loadAllDestBookingsList.length,
//           itemBuilder: (context, index) {
//             var dbooking = eValue.loadAllDestBookingsList[index];
//             return Card(
//               margin: const EdgeInsets.only(bottom: 16),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               elevation: 4,
//               child: InkWell(
//                 onTap: () {
//                   showDialog(
//                     context: context,
//                     builder: (context) => AlertDialog(
//                       backgroundColor: Colors.black,
//                       title: Text(dbooking.destName, style: const TextStyle(color: Colors.white)),
//                       content: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Image.network(
//                             dbooking.destImage,
//                             height: 150,
//                             fit: BoxFit.cover,
//                           ),
//                           const SizedBox(height: 10),
//                           Text("Date: ${dbooking.travelDate}", style: const TextStyle(color: Colors.white)),
//                           Text("Location: ${dbooking.destPlace}, ${dbooking.destDistrict}", style: const TextStyle(color: Colors.white)),
//                           Text("Tickets: ${dbooking.totalMembers}", style: const TextStyle(color: Colors.white)),
//                           Text("Total Price: ₹${dbooking.totalAmount}", style: const TextStyle(color: Colors.white)),
//                         ],
//                       ),
//                       actions: [
//                         TextButton(
//                           onPressed: () {
//                             callNext(context, EventBookedPeoples());
//                           },
//                           child: const Text("View", style: TextStyle(color: Colors.orange)),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     ClipRRect(
//                       borderRadius: const BorderRadius.only(
//                         topLeft: Radius.circular(16),
//                         bottomLeft: Radius.circular(16),
//                       ),
//                       child: Image.network(
//                         dbooking.destImage,
//                         width: 120,
//                         height: 120,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                     Expanded(
//                       child: Padding(
//                         padding: const EdgeInsets.all(12),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               dbooking.destName,
//                               style: const TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.deepPurple,
//                               ),
//                             ),
//                             const SizedBox(height: 8),
//                             Text("Date: ${dbooking.travelDate}", style: TextStyle(color: Colors.grey.shade700)),
//                             Text("Tickets: ${dbooking.totalMembers}", style: TextStyle(color: Colors.grey.shade700)),
//                             Text("Total Price: ₹${dbooking.totalAmount}", style: const TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold)),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
// }
///
class BookingListScreen extends StatelessWidget {
  // Shared dialog content builder
  Widget _buildDialogContent({
    required String title,
    required String imageUrl,
    required String date,
    required String location,
    required String district,
    required int tickets,
    required num totalPrice,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SafeNetworkImage(
          imageUrl: imageUrl,
          height: 150,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        const SizedBox(height: 10),
        Text("Date: $date",
            style: const TextStyle(color: Colors.white)),
        Text("Location: $location, $district",
            style: const TextStyle(color: Colors.white)),
        Text("Tickets: $tickets",
            style: const TextStyle(color: Colors.white)),
        Text("Total Price: ₹$totalPrice",
            style: const TextStyle(color: Colors.white)),
      ],
    );
  }

  // Shared booking card builder
  Widget _buildBookingCard({
    required BuildContext context,
    required String title,
    required String imageUrl,
    required String date,
    required int tickets,
    required num totalPrice,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                bottomLeft: Radius.circular(16),
              ),
              child: SafeNetworkImage(
                imageUrl: imageUrl,
                width: 120,
                height: 120,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text("Date: $date",
                        style: TextStyle(color: Colors.grey.shade700)),
                    Text("Tickets: $tickets",
                        style: TextStyle(color: Colors.grey.shade700)),
                    Text("Total Price: ₹$totalPrice",
                        style: const TextStyle(
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.bold
                        )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBookingList() {
    return Consumer<MainProvider>(
      builder: (context, provider, _) {
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: provider.loadAllEventBookingsList.length,
          itemBuilder: (context, index) {
            final booking = provider.loadAllEventBookingsList[index];
            return _buildBookingCard(
              context: context,
              title: booking.eventName,
              imageUrl: booking.eventImage,
              date: booking.eventDate,
              tickets: booking.totalMembers,
              totalPrice: booking.totalAmount,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    backgroundColor: Colors.black,
                    title: Text(booking.eventName,
                        style: const TextStyle(color: Colors.white)),
                    content: _buildDialogContent(
                      title: booking.eventName,
                      imageUrl: booking.eventImage,
                      date: booking.eventDate,
                      location: booking.eventPlace,
                      district: booking.eventDistrict,
                      tickets: booking.totalMembers,
                      totalPrice: booking.totalAmount,
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          callNext(context, EventBookedPeoples());
                        },
                        child: const Text("View",
                            style: TextStyle(color: Colors.orange)),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  Widget _buildDBookingList() {
    return Consumer<MainProvider>(
      builder: (context, provider, _) {
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: provider.loadAllDestBookingsList.length,
          itemBuilder: (context, index) {
            final booking = provider.loadAllDestBookingsList[index];
            return _buildBookingCard(
              context: context,
              title: booking.destName,
              imageUrl: booking.destImage,
              date: booking.travelDate,
              tickets: booking.totalMembers,
              totalPrice: booking.totalAmount,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    backgroundColor: Colors.black,
                    title: Text(booking.destName,
                        style: const TextStyle(color: Colors.white)),
                    content: _buildDialogContent(
                      title: booking.destName,
                      imageUrl: booking.destImage,
                      date: booking.travelDate,
                      location: booking.destPlace,
                      district: booking.destDistrict,
                      tickets: booking.totalMembers,
                      totalPrice: booking.totalAmount,
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          callNext(context, EventBookedPeoples());
                        },
                        child: const Text("View",
                            style: TextStyle(color: Colors.orange)),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: () => backto(context),
            child: const Icon(Icons.arrow_back_ios_new_sharp, size: 32),
          ),
          title: const Text(
            "My Bookings",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: admingradient,
            ),
          ),
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.event, color: Colors.white),
                child: Text("Events", style: TextStyle(color: Colors.white)),
              ),
              Tab(
                icon: Icon(Icons.place, color: Colors.white),
                child: Text("Destinations", style: TextStyle(color: Colors.white)),
              ),
            ],
            indicatorColor: Colors.white,
            indicatorWeight: 4,
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: TabBarView(
            children: [
              _buildBookingList(),
              _buildDBookingList(),
            ],
          ),
        ),
      ),
    );
  }
}

// Modified Image widget to handle empty URLs
class SafeNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;
  final BoxFit fit;

  const SafeNetworkImage({
    required this.imageUrl,
    this.width = 120,
    this.height = 120,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    if (imageUrl.isEmpty) {
      return Container(
        width: width,
        height: height,
        color: Colors.grey[300],
        child: Icon(Icons.image_not_supported, color: Colors.grey[600]),
      );
    }

    return Image.network(
      imageUrl,
      width: width,
      height: height,
      fit: fit,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          width: width,
          height: height,
          color: Colors.grey[300],
          child: Icon(Icons.broken_image, color: Colors.grey[600]),
        );
      },
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Container(
          width: width,
          height: height,
          color: Colors.grey[300],
          child: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
///old
// class BookingListScreen extends StatelessWidget {
//
//   @override
//   Widget build(BuildContext context) {
//
//     return DefaultTabController(
//       length: 2, // Two tabs: Events and Destinations
//       child: Scaffold(
//         appBar: AppBar(
//           leading: InkWell(
//             onTap: () {
//               backto(context);
//             },
//               child: Icon(Icons.arrow_back_ios_new_sharp,size: 32,)),
//           title: const Text(
//             "My Bookings",
//             style: TextStyle(
//               fontSize: 24,
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//             ),
//           ),
//           // centerTitle: true,
//           flexibleSpace: Container(
//             decoration: BoxDecoration(
//               gradient: admingradient
//               // gradient: LinearGradient(
//               //   colors: [Colors.deepPurple, Colors.purpleAccent],
//               //   begin: Alignment.topLeft,
//               //   end: Alignment.bottomRight,
//               // ),
//             ),
//           ),
//           bottom: const TabBar(
//             tabs: [
//               Tab(
//                 icon: Icon(Icons.event, color: Colors.white),
//                 child: Text("Events",style: TextStyle(color: Colors.white),),
//               ),
//               Tab(
//                 icon: Icon(Icons.place, color: Colors.white),
//                 // text: "Destinations",
//                 child: Text("Destinations",style: TextStyle(color: Colors.white),),
//               ),
//             ],
//             indicatorColor: Colors.white,
//             indicatorWeight: 4,
//           ),
//         ),
//         body: Container(
//           decoration: BoxDecoration(
//             color: Colors.white
//             // gradient: LinearGradient(
//             //   colors: [Colors.deepPurple.shade800, Colors.purple.shade900],
//             //   begin: Alignment.topCenter,
//             //   end: Alignment.bottomCenter,
//             // ),
//           ),
//           child: Consumer<MainProvider>(
//             builder: (context,value,child) {
//               print('Event Bookings: ${value.loadAllEventBookingsList.length}');
//               print('Destination Bookings: ${value.loadAllDestBookingsList.length}');
//               return TabBarView(
//                 children: [
//
//                   // Events Tab
//                   _buildBookingList(),
//                   // Destinations Tab
//                   _buildDBookingList(),
//                 ],
//               );
//             }
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildBookingList() {
//     return Consumer<MainProvider>(
//       builder: (context,eValue,child) {
//         return ListView.builder(
//           padding: const EdgeInsets.all(16),
//           itemCount: eValue.loadAllEventBookingsList.length,
//           itemBuilder: (context, index) {
//             var booking =eValue.loadAllEventBookingsList[index];
//             return Card(
//               margin: const EdgeInsets.only(bottom: 16),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               elevation: 4,
//               child: InkWell(
//                 onTap: () {
//                   // Pop-up window functionality (unchanged)
//                   showDialog(
//                     context: context,
//                     builder: (context) => AlertDialog(
//                       backgroundColor: Colors.black,
//                       title: Text(booking.eventName,
//                         style: const TextStyle(color: Colors.white),
//                       ),
//                       content: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Image.network(
//                             booking.eventImage,
//                             height: 150,
//                             fit: BoxFit.cover,
//                           ),
//                           const SizedBox(height: 10),
//                           Text(
//                             "Date: ${booking.eventDate}",
//                             style: const TextStyle(color: Colors.white),
//                           ),
//                           Text(
//                             "Location: ${booking.eventPlace}, ${booking.eventDistrict}",
//                             style: const TextStyle(color: Colors.white),
//                           ),
//                           Text(
//                             "Tickets: ${booking.totalMembers}",
//                             style: const TextStyle(color: Colors.white),
//                           ),
//                           Text(
//                             "Total Price: ₹${booking.totalAmount}",
//                             style: const TextStyle(color: Colors.white),
//                           ),
//                         ],
//                       ),
//                       actions: [
//                         TextButton(
//                           onPressed: () {
//                             callNext(context, EventBookedPeoples());
//                           },
//                           child: const Text(
//                             "View",
//                             style: TextStyle(color: Colors.orange),
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     ClipRRect(
//                       borderRadius: const BorderRadius.only(
//                         topLeft: Radius.circular(16),
//                         bottomLeft: Radius.circular(16),
//                       ),
//                       child: Image.network(
//                         booking.eventImage,
//                         width: 120,
//                         height: 120,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                     Expanded(
//                       child: Padding(
//                         padding: const EdgeInsets.all(12),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               booking.eventName,
//                               style: const TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.deepPurple,
//                               ),
//                             ),
//                             const SizedBox(height: 8),
//                             Text(
//                               "Date: ${booking.eventDate}",
//                               style: TextStyle(color: Colors.grey.shade700),
//                             ),
//                             Text(
//                               "Tickets: ${booking.totalMembers}",
//                               style: TextStyle(color: Colors.grey.shade700),
//                             ),
//                             Text(
//                               "Total Price: ₹${booking.totalAmount}",
//                               style: const TextStyle(
//                                 color: Colors.deepPurple,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         );
//       }
//     );
//   }
//   Widget _buildDBookingList() {
//     return Consumer<MainProvider>(
//       builder: (context,eValue,child) {
//         return ListView.builder(
//           padding: const EdgeInsets.all(16),
//           itemCount: eValue.loadAllDestBookingsList.length,
//           itemBuilder: (context, index) {
//             var dbooking =eValue.loadAllDestBookingsList[index];
//             return Card(
//               margin: const EdgeInsets.only(bottom: 16),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               elevation: 4,
//               child: InkWell(
//                 onTap: () {
//                   // Pop-up window functionality (unchanged)
//                   showDialog(
//                     context: context,
//                     builder: (context) => AlertDialog(
//                       backgroundColor: Colors.black,
//                       title: Text(dbooking.destName,
//                         style: const TextStyle(color: Colors.white),
//                       ),
//                       content: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Image.network(
//                             dbooking.destImage,
//                             height: 150,
//                             fit: BoxFit.cover,
//                           ),
//                           const SizedBox(height: 10),
//                           Text(
//                             "Date: ${dbooking.travelDate}",
//                             style: const TextStyle(color: Colors.white),
//                           ),
//                           Text(
//                             "Location: ${dbooking.destPlace}, ${dbooking.destDistrict}",
//                             style: const TextStyle(color: Colors.white),
//                           ),
//                           Text(
//                             "Tickets: ${dbooking.totalMembers}",
//                             style: const TextStyle(color: Colors.white),
//                           ),
//                           Text(
//                             "Total Price: ₹${dbooking.totalAmount}",
//                             style: const TextStyle(color: Colors.white),
//                           ),
//                         ],
//                       ),
//                       actions: [
//                         TextButton(
//                           onPressed: () {
//                             callNext(context, EventBookedPeoples());
//                           },
//                           child: const Text(
//                             "View",
//                             style: TextStyle(color: Colors.orange),
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     ClipRRect(
//                       borderRadius: const BorderRadius.only(
//                         topLeft: Radius.circular(16),
//                         bottomLeft: Radius.circular(16),
//                       ),
//                       child: Image.network(
//                         dbooking.destImage,
//                         width: 120,
//                         height: 120,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                     Expanded(
//                       child: Padding(
//                         padding: const EdgeInsets.all(12),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               dbooking.destName,
//                               style: const TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.deepPurple,
//                               ),
//                             ),
//                             const SizedBox(height: 8),
//                             Text(
//                               "Date: ${dbooking.travelDate}",
//                               style: TextStyle(color: Colors.grey.shade700),
//                             ),
//                             Text(
//                               "Tickets: ${dbooking.totalMembers}",
//                               style: TextStyle(color: Colors.grey.shade700),
//                             ),
//                             Text(
//                               "Total Price: ₹${dbooking.totalAmount}",
//                               style: const TextStyle(
//                                 color: Colors.deepPurple,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         );
//       }
//     );
//   }
//
// }
///
// Widget _buildBookingList(List<Map<String, dynamic>> bookings) {
//   return ListView.builder(
//     padding: const EdgeInsets.all(16),
//     itemCount: bookings.length,
//     itemBuilder: (context, index) {
//       var booking = bookings[index];
//       return Card(
//         margin: const EdgeInsets.only(bottom: 16),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(15),
//         ),
//         elevation: 4,
//         child: InkWell(
//           onTap: () {
//             // Pop-up window functionality (unchanged)
//             showDialog(
//               context: context,
//               builder: (context) => AlertDialog(
//                 backgroundColor: Colors.black,
//                 title: Text(
//                   booking["EVENT_NAME"],
//                   style: const TextStyle(color: Colors.white),
//                 ),
//                 content: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Image.network(
//                       booking["IMAGE"],
//                       height: 150,
//                       fit: BoxFit.cover,
//                     ),
//                     const SizedBox(height: 10),
//                     Text(
//                       "Date: ${booking["DATE"]}",
//                       style: const TextStyle(color: Colors.white),
//                     ),
//                     Text(
//                       "Location: ${booking["EVENT_PLACE"]}, ${booking["EVENT_DISTRICT"]}",
//                       style: const TextStyle(color: Colors.white),
//                     ),
//                     Text(
//                       "Tickets: ${booking["TOTAL_TICKET"]}",
//                       style: const TextStyle(color: Colors.white),
//                     ),
//                     Text(
//                       "Total Price: ₹${booking["TOTAL_PRICE"]}",
//                       style: const TextStyle(color: Colors.white),
//                     ),
//                   ],
//                 ),
//                 actions: [
//                   TextButton(
//                     onPressed: () {
//                       callNext(context, EventBookedPeoples());
//                     },
//                     child: const Text(
//                       "View",
//                       style: TextStyle(color: Colors.orange),
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           },
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               ClipRRect(
//                 borderRadius: const BorderRadius.only(
//                   topLeft: Radius.circular(16),
//                   bottomLeft: Radius.circular(16),
//                 ),
//                 child: Image.network(
//                   booking["IMAGE"],
//                   width: 120,
//                   height: 120,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               Expanded(
//                 child: Padding(
//                   padding: const EdgeInsets.all(12),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         booking["EVENT_NAME"],
//                         style: const TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.deepPurple,
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                       Text(
//                         "Date: ${booking["DATE"]}",
//                         style: TextStyle(color: Colors.grey.shade700),
//                       ),
//                       Text(
//                         "Tickets: ${booking["TOTAL_TICKET"]}",
//                         style: TextStyle(color: Colors.grey.shade700),
//                       ),
//                       Text(
//                         "Total Price: ₹${booking["TOTAL_PRICE"]}",
//                         style: const TextStyle(
//                           color: Colors.deepPurple,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//     },
//   );
// }