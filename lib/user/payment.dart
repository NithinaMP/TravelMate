import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/globalMethods.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Container(
            color: Colors.black12,
            height: 0.5,
          ),
        ),
      ),
      backgroundColor: Color(0xfff8f8f1  ),
      body: Column(
        children: [
          ClipPath(
            clipper: ZigZagClipper(),  // Apply the custom zigzag clip
            child: Container(
              width: double.infinity,  // Make the container full width
              height:height/10,             // Set the height of the container
              decoration: BoxDecoration(
                  color: Color(0xffeef1b9
              ),

              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    Text("Amount Payable"),
                    Text("₹1000"),
                  ],
                ),
              ),// Container color
            ),
          ),
          SizedBox(height: 20,),
          Text("PAYMENT OPTIONS",style: TextStyle(color: Colors.black),),
          SizedBox(height: 20,),

          InkWell(
            onTap: () {
              showPaymentConfirmation(context);
            },

            child: Container(
              height: height/10,
              width: width,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.symmetric(horizontal: BorderSide(color: Colors.grey.shade300))
              ),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset("assets/image/gpay.png",scale: 14,),
                  Text("Google Pay",style: TextStyle(fontSize: 16),),
                  Icon(Icons.arrow_drop_down_outlined)
                ],
              ),
            ),
          ),
          SizedBox(height: 10,),
          InkWell(
            onTap: () {
              showPaymentConfirmation(context);
            },
            child: Container(
              height: height/10,
              width: width,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.symmetric(horizontal: BorderSide(color: Colors.grey.shade300))
              ),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset("assets/image/Paytm_logo.jpg",scale: 10,),
                  Text("Paytm",style: TextStyle(fontSize: 16),),
                  Icon(Icons.arrow_drop_down_outlined)
                ],
              ),
            ),
          ),
          SizedBox(height: 10,),
          Container(
            height: height/10,
            width: width,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.symmetric(horizontal: BorderSide(color: Colors.grey.shade300))
            ),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset("assets/image/bpi.png",scale: 4,),
                Text("Bhim",style: TextStyle(fontSize: 16),),
                Icon(Icons.arrow_drop_down_outlined)
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ZigZagClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double zigzagHeight = 10.0;  // Height of each zigzag
    double zigzagWidth = 20.0;   // Width of each zigzag

    final Path path = Path();
    path.moveTo(0, 0);  // Start at the top-left corner

    // Draw the top straight line
    path.lineTo(size.width, 0); // Top-right corner

    // Start the zigzag pattern at the bottom
    path.lineTo(size.width, size.height - zigzagHeight); // Right side

    // Create the zigzag pattern
    for (double x = size.width; x > 0; x -= zigzagWidth) {
      path.lineTo(x - zigzagWidth / 2, size.height);  // Peak of the zigzag
      path.lineTo(x - zigzagWidth, size.height - zigzagHeight);  // Bottom of the zigzag
    }

    // Finish the zigzag pattern
    path.lineTo(0, size.height - zigzagHeight); // Left side of the last zigzag
    path.lineTo(0, 0);  // Back to the top-left corner
    path.close();  // Close the path to complete the shape

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}


// import 'package:flutter/material.dart';
// import 'package:travelmate/user/paymentSuccessfull.dart';
//
// class PaymentScreen extends StatefulWidget {
//   const PaymentScreen({super.key});
//
//   @override
//   State<PaymentScreen> createState() => _PaymentScreenState();
// }
//
// class _PaymentScreenState extends State<PaymentScreen> {
//   int? openDropdownIndex; // Track which dropdown is open
//
//   @override
//   Widget build(BuildContext context) {
//     var height = MediaQuery.of(context).size.height;
//     var width = MediaQuery.of(context).size.width;
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Payment"),
//         centerTitle: true,
//         elevation: 0,
//         backgroundColor: Colors.white,
//         bottom: PreferredSize(
//           preferredSize: const Size.fromHeight(1.0),
//           child: Container(
//             color: Colors.black12,
//             height: 0.5,
//           ),
//         ),
//       ),
//       backgroundColor: const Color(0xfff8f8f1),
//       body: Column(
//         children: [
//           ClipPath(
//             clipper: ZigZagClipper(),
//             child: Container(
//               width: double.infinity,
//               height: height / 10,
//               decoration: const BoxDecoration(
//                 color: Color(0xffeef1b9),
//               ),
//               child: const Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 15),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text("Amount Payable"),
//                     Text("₹1000"),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(height: 20),
//           const Text(
//             "PAYMENT OPTIONS",
//             style: TextStyle(color: Colors.grey),
//           ),
//           const SizedBox(height: 20),
//           Column(
//             children: [
//               buildPaymentOption(
//                 index: 0,
//                 height: height,
//                 width: width,
//                 imagePath: "assets/image/gpay.png",
//                 paymentMethod: "Google Pay",
//                 context: context,
//               ),
//               buildPaymentOption(
//                 index: 1,
//                 height: height,
//                 width: width,
//                 imagePath: "assets/image/Paytm_logo.jpg",
//                 paymentMethod: "Paytm",
//                 context: context,
//               ),
//               buildPaymentOption(
//                 index: 2,
//                 height: height,
//                 width: width,
//                 imagePath: "assets/image/bpi.png",
//                 paymentMethod: "Bhim",
//                 context: context,
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget buildPaymentOption({
//     required int index,
//     required double height,
//     required double width,
//     required String imagePath,
//     required String paymentMethod,
//     required BuildContext context,
//   }) {
//     return Column(
//       children: [
//         GestureDetector(
//           onTap: () {
//             setState(() {
//               openDropdownIndex = openDropdownIndex == index ? null : index;
//             });
//           },
//           child: Container(
//             height: height / 10,
//             width: width,
//             decoration: BoxDecoration(
//               color: Colors.white,
//               border: Border.symmetric(
//                 horizontal: BorderSide(color: Colors.grey.shade300),
//               ),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 Image.asset(imagePath, scale: 14),
//                 Text(
//                   paymentMethod,
//                   style: const TextStyle(fontSize: 16),
//                 ),
//                 Icon(
//                   openDropdownIndex == index
//                       ? Icons.arrow_drop_up_outlined
//                       : Icons.arrow_drop_down_outlined,
//                 ),
//               ],
//             ),
//           ),
//         ),
//         if (openDropdownIndex == index)
//           Container(
//             width: width,
//             color: Colors.green,
//             padding: const EdgeInsets.all(10),
//             child: Center(
//               child: GestureDetector(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => const PaymentSuccess(),
//                     ),
//                   );
//                 },
//                 child: const Text(
//                   "Pay",
//                   style: TextStyle(color: Colors.white, fontSize: 16),
//                 ),
//               ),
//             ),
//           ),
//       ],
//     );
//   }
// }
//
// class ZigZagClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     double zigzagHeight = 10.0;
//     double zigzagWidth = 20.0;
//
//     final Path path = Path();
//     path.moveTo(0, 0);
//     path.lineTo(size.width, 0);
//     path.lineTo(size.width, size.height - zigzagHeight);
//
//     for (double x = size.width; x > 0; x -= zigzagWidth) {
//       path.lineTo(x - zigzagWidth / 2, size.height);
//       path.lineTo(x - zigzagWidth, size.height - zigzagHeight);
//     }
//
//     path.lineTo(0, size.height - zigzagHeight);
//     path.lineTo(0, 0);
//     path.close();
//
//     return path;
//   }
//
//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) => false;
// }
