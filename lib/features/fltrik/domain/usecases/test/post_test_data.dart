import 'package:filtrek_app/features/fltrik/domain/repositories/test_repository.dart';

class PostTestData {
  final TestRepository testRepository;

  PostTestData({required this.testRepository});

  Future<dynamic> call() {
    return testRepository.postTestData();
  }
}
