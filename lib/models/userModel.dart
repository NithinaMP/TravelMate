class DestTicketModel{
  String bookingId;
  String destName;
  String destPlace;
  String destDistrict;
  String travelDate;
  int totalMembers;
  num unitPrice;
  num subTotal;
  // num gst;
  num totalAmount;
  String destImage;
  DestTicketModel(
      this.bookingId,
      this.destName,
      this.destPlace,
      this.destDistrict,
      this.travelDate,
      this.totalMembers,
      this.unitPrice,
      this.subTotal,
      // this.gst,
      this.totalAmount,
      this.destImage
      );
}

class UserModel{
  String uid;
  String uname;
  String uPhone;
  String uPlace;
  String uPhoto;
  UserModel(this.uid,this.uname,this.uPhone,this.uPhoto,this.uPlace);
}


// class DestTicketModel {
//   String bookingId;
//   String destName;
//   String destPlace;
//   String destDistrict;
//   String travelDate;
//   int totalMembers;
//   num unitPrice;
//   num subTotal;
//   num totalAmount;
//
//   DestTicketModel({
//     required this.bookingId,
//     required this.destName,
//     required this.destPlace,
//     required this.destDistrict,
//     required this.travelDate,
//     required this.totalMembers,
//     required this.unitPrice,
//     required this.subTotal,
//     required this.totalAmount,
//   });
//
//   // Factory constructor to create an instance from Firestore data
//   factory DestTicketModel.fromFirestore(Map<String, dynamic> data) {
//     return DestTicketModel(
//       bookingId: data['BOOKING_ID'] ?? '',
//       destName: data['DEST_NAME'] ?? '',
//       destPlace: data['DEST_PLACE'] ?? '',
//       destDistrict: data['DEST_DISTRICT'] ?? '',
//       travelDate: data['DATE'] ?? '',
//       totalMembers: data['TOTAL_TICKET'] ?? 0,
//       unitPrice: data['DEST_ENTRY_FEE'] ?? 0,
//       subTotal: data['SUB_TOTAL'] ?? 0,
//       totalAmount: data['TOTAL_PRICE'] ?? 0,
//     );
//   }
// }
