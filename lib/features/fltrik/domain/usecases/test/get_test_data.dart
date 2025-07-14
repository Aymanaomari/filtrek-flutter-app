import 'package:filtrek_app/features/fltrik/data/repositories/test_repository_imp.dart';
import 'package:filtrek_app/features/fltrik/domain/entities/test.dart';
import 'package:filtrek_app/features/fltrik/domain/repositories/test_repository.dart';

class GetTestData {
  final TestRepository testRepository;
  GetTestData({required this.testRepository});

  Future<Test> call() {
    return testRepository.getTestData();
  }
}
