// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:travelmate/provider/mainProvider.dart';

// /// State Management Class
// class SelectedIndexProvider extends ChangeNotifier {
//   int _selectedIndex = -1;
//
//   int get selectedIndex => _selectedIndex;
//
//   void selectIndex(int index) {
//     _selectedIndex = index;
//     notifyListeners(); // Notify listeners to rebuild the UI
//   }
// }


//
// class InfiniteNumberSelector extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Infinite Number Selector"),
//       ),
//       body:
//       Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               height: 50, // Adjust the height of the row container
//               child: Consumer<MainProvider>(
//                 builder: (context, dvalue, child) {
//                   return ListView.builder(
//                     scrollDirection: Axis.horizontal,
//                     itemBuilder: (context, index) {
//                       final selectedIndex = dvalue.selectedIndex;
//
//                       return GestureDetector(
//                         onTap: () {
//                           dvalue.selectIndex(index);
//                           print("Selected: ${index + 1} seats");
//                         },
//                         child: Container(
//                           margin: const EdgeInsets.symmetric(horizontal: 4),
//                           padding: const EdgeInsets.all(10),
//                           decoration: BoxDecoration(
//                             color: selectedIndex == index
//                                 ? Colors.redAccent
//                                 : Colors.grey[200],
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           child: Text(
//                             "${index + 1}",
//                             style: TextStyle(
//                               color: selectedIndex == index
//                                   ? Colors.white
//                                   : Colors.black,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   );
//                 },
//               ),
//             ),
//             SizedBox(height: 20),
//             Consumer<MainProvider>(
//               builder: (context, dvalue, child) {
//                 return ElevatedButton(
//                   onPressed: dvalue.selectedIndex == -1
//                       ? null // Button disabled when no number is selected
//                       : () {
//                     // Handle "Select seats" button press
//                     Navigator.pop(context);
//                   },
//                   style: ElevatedButton.styleFrom(
//                     minimumSize: Size(double.infinity, 50),
//                     backgroundColor: dvalue.selectedIndex == -1
//                         ? Colors.grey // Disabled button color
//                         : Colors.redAccent, // Active button color
//                   ),
//                   child: Text(
//                     "Select seats",
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: dvalue.selectedIndex == -1
//                           ? Colors.black54 // Disabled text color
//                           : Colors.white, // Active text color
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travelmate/user/payment.dart';

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
      backgroundColor: Color(0xfff8f8f1),
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

  void showPaymentConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm Payment"),
          content: Text("Are you sure you want to make this payment?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                // Close the payment confirmation dialog
                Navigator.pop(context);

                // Use StatefulWidget to handle CircularProgressIndicator
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaymentProgressScreen(),
                  ),
                );
              },
              child: Text("Pay"),
            ),
          ],
        );
      },
    );
  }
}

class PaymentProgressScreen extends StatefulWidget {
  @override
  _PaymentProgressScreenState createState() => _PaymentProgressScreenState();
}

class _PaymentProgressScreenState extends State<PaymentProgressScreen> {
  @override
  void initState() {
    super.initState();

    // Simulate payment process and navigate once done
    _processPayment();
  }

  Future<void> _processPayment() async {
    await Future.delayed(Duration(seconds: 2)); // Simulate processing time

    if (mounted) {
      // Ensure the widget is still in the tree
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => PaymentSuccess()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Processing Payment")),
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class PaymentSuccess extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Payment Successful")),
      body: Center(child: Text("Your payment was successful!")),
    );
  }
}
