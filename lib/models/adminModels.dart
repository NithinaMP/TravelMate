class DestinationModel{
  String destId;
  String destName;
  String destPlace;
  String destDistrict;
  String destBestTime;
  String destImage;
  String destDescription;
  String destEntryFee;
  String destSlotAvailability;

  DestinationModel(
      this.destId,
      this.destName,
      this.destPlace,
      this.destDistrict,
      this.destBestTime,
      this.destImage,
      this.destDescription,
      this.destEntryFee,
      this.destSlotAvailability
      );

}


class EventsModel{
  String eventId;
  String eventName;
  String eventPlace;
  String eventDistrict;
  String eventImage;
  String eventDescription;
  String eventEntryFee;
  String eventSlotAvailability;
  EventsModel(
      this.eventId,
      this.eventName,
      this.eventPlace,
      this.eventDistrict,
      this.eventImage,
      this.eventDescription,
      this.eventEntryFee,
      this.eventSlotAvailability
      );
}