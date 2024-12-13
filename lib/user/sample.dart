// void getDestReceipt(String userId) {
//   db
//       .collection("USERS")
//       .doc(userId)
//       .collection("DEST_TICKET")
//       .get()
//       .then((value) {
//     if (value.docs.isNotEmpty) {
//       destTicketList.clear(); // Clear the old data to avoid duplication
//       for (var element in value.docs) {
//         Map<dynamic, dynamic> ticket = element.data();
//
//         String travelDate = "";
//         if (ticket["DATE"] is Timestamp) {
//           travelDate = (ticket["DATE"] as Timestamp).toDate().toString();
//         } else {
//           travelDate = ticket["DATE"] ?? "";
//         }
//
//         // Safely parse the ticket values
//         int totalTickets = int.tryParse(ticket["TOTAL_TICKET"].toString()) ?? 0;
//         num entryFee =
//             num.tryParse(ticket["DEST_ENTRY_FEE"]?.toString() ?? '0') ?? 0.0;
//         num subTotal =
//             num.tryParse(ticket["SUB_TOTAL"]?.toString() ?? '0') ?? 0.0;
//         num totalPrice =
//             num.tryParse(ticket["TOTAL_PRICE"]?.toString() ?? '0') ?? 0.0;
//
//         destTicketList.add(DestTicketModel(
//           element.id,
//           ticket["DEST_NAME"] ?? "",
//           ticket["DEST_PLACE"] ?? "",
//           ticket["DEST_DISTRICT"] ?? "",
//           travelDate,
//           totalTickets,
//           entryFee,
//           subTotal,
//           totalPrice,
//         ));
//       }
//     }
//   }).catchError((error) {
//     print("Failed to fetch booking data: $error");
//   });
// }
