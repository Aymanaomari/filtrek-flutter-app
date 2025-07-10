import 'package:filtrek_app/features/fltrik/domain/repositories/test_repository.dart';

class GetTestData {
  final TestRepository repository;

  GetTestData({required this.repository});

  call() {
    repository.getTestData();
  }
}
