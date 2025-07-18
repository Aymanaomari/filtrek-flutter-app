class CoachAvailableSlotsModel {
  final List<String> slots;

  CoachAvailableSlotsModel({required this.slots});

  factory CoachAvailableSlotsModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> data = json['data'] ?? [];
    return CoachAvailableSlotsModel(
      slots: List<String>.from(data),
    );
  }

  List<String> getSlots() => slots;
}
