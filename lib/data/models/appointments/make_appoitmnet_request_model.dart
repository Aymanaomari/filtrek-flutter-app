class MakeAppoitmnetRequestModel {
  final String slot;
  final String coachId;
  final String date;

  MakeAppoitmnetRequestModel(
      {required this.slot, required this.coachId, required this.date});

  Map<String, dynamic> toJson() {
    return {
      "date": date,
      "slotTime": slot,
      "coachId": coachId,
    };
  }
}
