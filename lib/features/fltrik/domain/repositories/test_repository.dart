import 'package:filtrek_app/features/fltrik/domain/entities/test.dart';

abstract class TestRepository {
  Future<List<Test>> getTestData();
}
