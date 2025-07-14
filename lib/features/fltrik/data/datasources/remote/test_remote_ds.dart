import 'package:filtrek_app/end_points.dart';
import 'package:filtrek_app/features/fltrik/core/class/crud.dart';

class TestRemoteDs {
  final Crud crud;

  TestRemoteDs({required this.crud});

  Future<dynamic> getData() async {
    var response = await crud.getData(EndPoints.endPointsPrefix);
    return response.fold(
      (l) {
        print("Error: $l");
        return l;
      },
      (r) {
        print("Success: $r");
        return r;
      },
    );
  }

  Future<dynamic> postData() async {
    var response = await crud.postData(EndPoints.test, {});
    return response.fold(
      (l) {
        print(response);
        print("Error: $l");
        return l;
      },
      (r) {
        print("Success: $r");
        return r;
      },
    );
  }
}
