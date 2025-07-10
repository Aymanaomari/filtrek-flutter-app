import 'package:filtrek_app/features/fltrik/core/class/crud.dart';
import 'package:filtrek_app/features/fltrik/data/models/test_model.dart';

class TestRemoteDatasource {
  final Crud _crud;

  TestRemoteDatasource({required Crud crud}) : _crud = crud;

  Future<List<TestModel>> getTestData() async {
    var response = await _crud.getData("http://localhost:3000/api/test");
    return response.fold((l) {
      throw Exception('Network error: $l');
    }, (r) {
      if (r['data'] is List) {
        final List<dynamic> dataList = r['data'];
        return dataList.map((json) => TestModel.fromJson(json)).toList();
      }
      return <TestModel>[];
    });
  }
}
