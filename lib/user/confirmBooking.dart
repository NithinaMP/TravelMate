import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../constants/call_functions.dart';
import '../constants/constant_colors.dart';
import '../constants/globalMethods.dart';
import '../provider/mainProvider.dart';
import '../user/payment.dart';

class ConfirmBooking extends StatelessWidget {
  final String userId, destId, Name, Place, District, EntryFee, Image;
  final String from; // Indicates "Destination" or "Event"
  final int selectedCount;

  ConfirmBooking({
    super.key,
    required this.userId,
    required this.destId,
    required this.Name,
    required this.Place,
    required this.District,
    required this.EntryFee,
    required this.Image,
    required this.selectedCount,
    required this.from,
  });

  @override
  Widget build(BuildContext context) {
    final num unitPrice = num.tryParse(EntryFee) ?? 0;
    final num totalFee = unitPrice * selectedCount;
    final num gst = totalFee * 0.02;
    final num totalAmount = totalFee + gst;

    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xffe6f7f5),
      appBar: AppBar(
        title: Text(
          from == "Destination"
              ? "Confirm Destination Booking"
              : "Confirm Event Booking",
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          _BookingDetails(
            Name: Name,
            Place: Place,
            District: District,
            selectedCount: selectedCount,
            isEventBooking: from == "Event",
            destId: destId,
          ),
          _CancellationPolicy(height: height, width: width),
          _PaymentSummary(
            height: height,
            width: width,
            unitPrice: unitPrice,
            totalFee: totalFee,
            gst: gst,
            totalAmount: totalAmount,
          ),
          _ConsentText(height: height, width: width),
          const Spacer(),
          _BottomBar(
            width: width,
            totalAmount: totalAmount,
            onContinue: () => _handleContinue(context, totalFee, totalAmount),
          ),
        ],
      ),
    );
  }

  // void _handleContinue(BuildContext context, num totalFee, num totalAmount) {
  //   final selectedDate = context.read<MainProvider>().selectedDate;
  //
  //   if (selectedDate == null && from == "Destination") {
  //     showSnackBarAlert(context, "Please select a date before proceeding");
  //   } else {
  //     callNext(
  //       context,
  //       PaymentScreen(
  //         userId: userId,
  //         destId: destId,
  //         destName: Name,
  //         destPlace: Place,
  //         destDistrict: District,
  //         destEntryFee: EntryFee,
  //         destImage: Image,
  //         selectedCount: selectedCount,
  //         totalAmount: totalAmount,
  //         subTotal: totalFee,
  //         from: from,// Pass the 'from' parameter to indicate the booking type ,that is it came from "Event"
  //       ),
  //     );
  //   }
  // }
  void _handleContinue(BuildContext context, num totalFee, num totalAmount) {
    final selectedDate = context.read<MainProvider>().selectedDate;

    String? eventDate;

    if(from=="Event"){
      // fetch  the event date from firestore
      FirebaseFirestore.instance.collection("EVENT").doc(destId).get().then((value) {
        if(value.exists){

          /// assuming "EVENT_DATE" is stored as a Timestamp field

          Timestamp timestamp=value.get("EVENT_DATE");
          eventDate=DateFormat("EEEE,MMMM,d,yyyy").format(timestamp.toDate());
          print("Fetched event date--:$eventDate");

          if(eventDate==null){

            showSnackBarAlert(context, "Event date not found");
            return;
          }

          //Navigate to payment screen with the eventDate

          callNext(context, PaymentScreen(
              userId: userId,
              destId: destId,
              destName: Name,
              destPlace: Place,
              destDistrict: District,
              destEntryFee: EntryFee,
              destImage: Image,
              subTotal: totalFee,
              selectedCount: selectedCount,
              totalAmount: totalAmount,
              from: from,
            eventDate:eventDate??"Default Event Date" ///paass the eventDate
          )
          );
          print("confirmation of event date *****:$eventDate");

        }

        else{
          showSnackBarAlert(context, "Event details not found");
        }
      },).catchError((error){
        showSnackBarAlert(context, "Failed to fetch event details: $error");
      }
      );
    }else{
      if (selectedDate == null && from == "Destination") {
        showSnackBarAlert(context, "Please select a date before proceeding");
      } else {

        String formattedDate=selectedDate!=null
            ?DateFormat("EEEE,MMMM,d,yyyy").format(selectedDate)
            :"No date selected";
        callNext(
          context,
          PaymentScreen(
            userId: userId,
            destId: destId,
            destName: Name,
            destPlace: Place,
            destDistrict: District,
            destEntryFee: EntryFee,
            destImage: Image,
            selectedCount: selectedCount,
            totalAmount: totalAmount,
            subTotal: totalFee,
            from: from,// Pass the 'from' parameter to indicate the booking type
            eventDate:formattedDate
            // selectedDate!=null
            //     ?DateFormat("EEEE,MMMM,d,y ").format(selectedDate)
            // :"No date selected",///for destination bookings,use the selected date

          ),

        );
        print("Selected date : $formattedDate");
        print("Navigate to the Payment Screen");
      }
    }


  }
}

class _BookingDetails extends StatelessWidget {
  final String Name, Place, District;
  final int selectedCount;
  final bool isEventBooking;
  final String destId; // Event ID to fetch the event date

  const _BookingDetails({
    required this.Name,
    required this.Place,
    required this.District,
    required this.selectedCount,
    this.isEventBooking = false, // Defaults to false (destination booking)
    required this.destId, // Event ID
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade200),
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
        ),
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    Name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),

                ),
                SizedBox(width: 5,),
                RichText(
                  text: TextSpan(
                    text: "Total members:",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        fontSize: 12),
                    children: [
                      TextSpan(
                        text: " $selectedCount",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: cstRed),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Text("$Place, $District"),

            SizedBox(height: 5),

            /// For event booking
            if (isEventBooking)
              FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance
                    .collection('EVENT')
                    .doc(destId)
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator(); // Show loading indicator
                  }

                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }

                  final eventDate = snapshot.data?['EVENT_DATE']?.toDate();

                  /// print the event date to the terminal
                  ///
                  if(eventDate!=null){
                    print("Event Date : ${DateFormat("EEEE,MMMM,d,y").format(eventDate)}");
                  }
                  else{
                    print("Event Date not available");
                  }


                  return eventDate != null
                      ? Row(
                          children: [
                            Icon(Icons.calendar_today, size: 18),
                            SizedBox(width: 5),
                            RichText(
                              text: TextSpan(
                                text: "Event Date:",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                                children: [
                                  TextSpan(
                                    text: DateFormat("EEEE, MMMM d, y")
                                        .format(eventDate),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: cstRed),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      : Text("Event Date not available");
                },
              ),

            /// For destination booking
            if (!isEventBooking)
              Consumer<MainProvider>(
                builder: (context, dValue, child) {
                  final selectedDate = dValue.selectedDate;
                  return Row(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2100),
                          );
                          if (pickedDate != null) {
                            dValue.setSelectedDate(pickedDate);
                          }
                        },
                        child: Icon(Icons.calendar_today),
                      ),
                      SizedBox(width: 10),
                      Text(
                        selectedDate != null
                            ? DateFormat('EEEE,MMMM d,y').format(selectedDate)
                            : "Select Date",
                        style: TextStyle(
                          fontSize: 16,
                          color: selectedDate != null ? cstRed : Colors.black,
                          fontWeight: selectedDate != null
                              ? FontWeight.normal
                              : FontWeight.bold,
                        ),
                      ),
                    ],
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}

class _CancellationPolicy extends StatelessWidget {
  final double height, width;

  const _CancellationPolicy({required this.height, required this.width});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        height: height / 8.5,
        width: width,
        decoration: BoxDecoration(
          color: const Color(0xffc0fce3),
          borderRadius:
              const BorderRadius.vertical(bottom: Radius.circular(10)),
          border: Border.all(color: Colors.grey.shade200),
        ),
        padding: const EdgeInsets.all(10),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Cancellation Available"),
            Text("This venue supports booking cancellation. To know more view",
                style: TextStyle(fontSize: 11)),
            Text("cancellation policy", style: TextStyle(color: Colors.blue)),
          ],
        ),
      ),
    );
  }
}

class _PaymentSummary extends StatelessWidget {
  final double height, width;
  final num unitPrice, totalFee, gst, totalAmount;

  const _PaymentSummary({
    required this.height,
    required this.width,
    required this.unitPrice,
    required this.totalFee,
    required this.gst,
    required this.totalAmount,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        height: height / 5,
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade200),
        ),
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            _summaryRow("Entry Fee", unitPrice),
            _summaryRow("Total", totalFee),
            _summaryRow("GST(2%)", gst),
            const Divider(),
            _summaryRow(
              "Amount to pay",
              totalAmount,
            ),
          ],
        ),
      ),
    );
  }

  Widget _summaryRow(String title, num value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        Text(
          "₹ ${value.toStringAsFixed(2)}",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class _ConsentText extends StatelessWidget {
  final double height, width;

  const _ConsentText({required this.height, required this.width});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        height: height / 14,
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade200),
        ),
        padding: const EdgeInsets.all(10),
        child: const Text(
          "By proceeding, I express my consent to complete this transaction.",
          style: TextStyle(fontSize: 10.35),
        ),
      ),
    );
  }
}

class _BottomBar extends StatelessWidget {
  final double width;
  final num totalAmount;
  final VoidCallback onContinue;

  const _BottomBar({
    required this.width,
    required this.totalAmount,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.black12, width: 1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Total: ₹ ${totalAmount.toStringAsFixed(2)}",
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: onContinue,
            child:
                const Text("Continue", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
