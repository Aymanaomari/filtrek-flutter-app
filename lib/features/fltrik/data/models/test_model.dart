import 'package:filtrek_app/features/fltrik/domain/entities/test.dart';

class TestModel {
  final String text;
  final int value;
  TestModel({required this.text, required this.value});

  factory TestModel.fromJson(Map<String, dynamic> json) {
    return TestModel(text: json["text"], value: json["value"]);
  }
  factory TestModel.fromEntity(Test test) {
    return TestModel(text: test.text, value: test.value);
  }

  Test toEntity() => Test(text: text, value: value);
}
