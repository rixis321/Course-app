import 'package:course_app/common/entities/user.dart';
import 'package:course_app/common/utils/http_util.dart';

class UserAPI{

 static login({LoginRequestEntity? params}) async {
    var response = await HttpUtil().post(
      'api/login',
    queryParameters:params?.toJson()
    );
    return UserLoginResponseEntity.fromJson(response);

  }
}