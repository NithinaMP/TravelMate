import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:travelmate/constants/call_functions.dart';
import 'package:travelmate/constants/globalMethods.dart';
import 'package:travelmate/provider/mainProvider.dart';
import 'package:travelmate/user/payment.dart';

class ConfirmBooking extends StatelessWidget {
  String userId,
      destId,
      destName,
      destPlace,
      destDistrict,
      destFee,destImage;
  int  selectedCount;
  ConfirmBooking({
    super.key,
    required this.userId,
    required this.destId,
    required this.destName,
    required this.destPlace,
    required this.destDistrict,
    required this.destFee,
    required this.destImage,
    required this.selectedCount
  });

  @override
  Widget build(BuildContext context) {


    final num unitPrice=num.tryParse(destFee)??0;
    final num totalFee=unitPrice*selectedCount;
    final num gst=totalFee*0.02;
    final num totalAmount=totalFee+gst;

    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xffe6f7f5),
    appBar: AppBar(
      title: Text("Confirm booking"),
      centerTitle: true,
    ),
      body: Column(
        children: [
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Container(
              height:height/7.5,
              width: width,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade200),
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10)
                )
              ),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(destName),
                        Text("Total members:${selectedCount}"),
                      ],
                    ),
                    Text("${destPlace},${destDistrict}"),

                    //for calnder

                    Consumer<MainProvider>(
                      builder: (context,dValue,child) {
                        final selectedDate=dValue.selectedDate;

                        // formating the selected date in dd-mm-yyyy format
                        String formattedDate=selectedDate!=null?DateFormat('dd-MM-yyyy').format(selectedDate)
                            :"Select Date";
                        return GestureDetector(
                            onTap: () async{
                              DateTime? pickedDate=await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2100)
                              );
                              if(pickedDate!=null){
                                dValue.setSelectedDate(pickedDate);
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(Icons.calendar_today),
                                SizedBox(width: 8,),
                                // Text(
                                //   selectedDate!=null
                                //     ?"Date :${selectedDate.toLocal().toString().split('')[0]}"
                                //       :"Select Date",style: TextStyle(color: Colors.blue),),
                                Text(formattedDate,
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ],
                            ));
                      }
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Container(
              height:height/8.5,
              width: width,
              decoration: BoxDecoration(
                color: Color(0xffc0fce3 ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)
                ),
                border: Border.all(color: Colors.grey.shade200)


              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Cancellation Available"),
                    Text("This venue supports booking cancellation. To know more view",style: TextStyle(fontSize: 11),),
                    Text("cancellation policy",style: TextStyle(color: Colors.blue),),

                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Container(
              height: height/5,
              width: width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade200)
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    SizedBox(height: 15,),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Entry Fee"),
                        Text("₹ ${unitPrice.toStringAsFixed(2)}"),
                      ],
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Total"),
                        Text("₹ ${totalFee}"),
                      ],
                    ),
                    SizedBox(height: 5,),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("GST(2 %)"),
                        Text("₹ ${gst.toStringAsFixed(2)}"),
                      ],
                    ),
                    SizedBox(height: 5,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(68, (index) {
                        return const Text(
                          "-",
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        );
                      }),
                    ),
                    SizedBox(height: 5,),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Amount to pay"),
                        Text("₹ ${totalAmount.toStringAsFixed(2)}"),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Container(
              height: height/14,
              width: width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade200)
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    SizedBox(height: 15,),
                    Text("By proceeding ,I express my consent to complete this transaction.",style: TextStyle(fontSize: 10.35),),


                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: height/5,),

          Expanded(
            child: Container(
              height: height / 9,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                border: const Border(
                  top: BorderSide(
                    color: Colors.black12,
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Text Section (Left Side)
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Total",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "₹ ${totalAmount.toStringAsFixed(2)}", // Removed `const` keyword
                          style: const TextStyle(fontSize: 14, color: Colors.black87,fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  // Elevated Button (Right Side)
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: SizedBox(
                      width: width / 2.2,
                      child: Consumer<MainProvider>(
                        builder: (context,sValue,child) {
                          return ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            onPressed: () {

                              //validate if the user has selected a date

                              final selectedDate=context.read<MainProvider>().selectedDate;
                              if(selectedDate==null){
                                //show a sckbar message if no date is selected

                                showSnackBarAlert(context, "Please select a date before proceeding");
                              }
                              else{
                                // Move to payment screen
                                // sValue.destinationBooking(userId, destId, destName, destDistrict, destPlace, destFee, selectedCount, totalAmount, destImage);
                                callNext(context, PaymentScreen(userId: userId, destId: destId,  destName: destName, destPlace: destPlace, destDistrict: destDistrict, destFee: destFee, destImage: destImage, selectedCount: selectedCount, totalAmount: totalAmount,));
                              }




                            },
                            child: const Text(
                              "Continue",
                              style: TextStyle(color: Colors.white),
                            ),
                          );
                        }
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )

        ],
      ),
    );
  }


}


