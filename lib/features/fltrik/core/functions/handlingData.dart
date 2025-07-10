import 'package:filtrek_app/features/fltrik/core/enums/StatusRequest.dart';

handlingData(response) {
  if (response is StatusRequest) {
    print("response is status Request");
    return response;
  } else {
    return StatusRequest.SUCCESS;
  }
}
