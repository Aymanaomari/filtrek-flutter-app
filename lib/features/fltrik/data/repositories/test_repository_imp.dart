import 'package:filtrek_app/features/fltrik/core/class/crud.dart';
import 'package:filtrek_app/features/fltrik/core/enums/StatusRequest.dart';
import 'package:filtrek_app/features/fltrik/core/functions/handlingData.dart';
import 'package:filtrek_app/features/fltrik/data/datasources/remote/test_remote_ds.dart';
import 'package:filtrek_app/features/fltrik/data/models/test_model.dart';
import 'package:filtrek_app/features/fltrik/domain/entities/test.dart';
import 'package:filtrek_app/features/fltrik/domain/repositories/test_repository.dart';

class TestRepositoryImp extends TestRepository {
  final TestRemoteDs remoteDs;

  TestRepositoryImp({required this.remoteDs});

  @override
  Future<Test> getTestData() async {
    var response = await remoteDs.getData();

    if (response is StatusRequest) {
      throw Exception('Request failed with status: $response');
    } else {
      TestModel testModel = TestModel.fromJson(response);
      return testModel.toEntity();
    }
  }

  @override
  Future postTestData() async {
    var response = await remoteDs.getData();

    if (response is StatusRequest) {
      throw Exception('Request failed with status: $response');
    } else {
      print("post passed successfully");
    }
  }
}
