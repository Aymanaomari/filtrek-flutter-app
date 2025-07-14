import 'package:filtrek_app/features/fltrik/domain/entities/test.dart';

class TestModel extends Test {
  TestModel({required String text}) : super(text: text);

  factory TestModel.fromJson(Map<String, dynamic> json) {
    return TestModel(
      text: json['new'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'new': text,
    };
  }

  // Convert TestModel to Test entity
  Test toEntity() {
    return Test(text: text);
  }

  // Create TestModel from Test entity
  factory TestModel.fromEntity(Test test) {
    return TestModel(text: test.text);
  }
}
