import 'package:filtrek_app/features/fltrik/data/datasources/remote/test_remote_datasource.dart';
import 'package:filtrek_app/features/fltrik/data/models/test_model.dart';
import 'package:filtrek_app/features/fltrik/domain/entities/test.dart';
import 'package:filtrek_app/features/fltrik/domain/repositories/test_repository.dart';

class TestRepositorieImplement extends TestRepository {
  final TestRemoteDatasource remoteDatasource;

  TestRepositorieImplement({required this.remoteDatasource});

  @override
  Future<List<Test>> getTestData() async {
    try {
      final List<TestModel> models = await remoteDatasource.getTestData();
      // Convert models to entities
      return models.map((model) => model.toEntity()).toList();
    } catch (e) {
      // Handle errors appropriately
      throw Exception('Failed to fetch test data: $e');
    }
  }
}
