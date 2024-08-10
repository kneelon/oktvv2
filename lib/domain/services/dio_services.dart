
import 'package:dio/dio.dart';
import 'package:oktvv2/presentation/utility/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioServices {
  late Dio _dio;
  late SharedPreferences _sharedPreferences;
  String token = AppStrings.empty;

  DioServices() {
    _dio = Dio(BaseOptions(
      baseUrl: Api.baseUrl,
    ));

    _initializeInterceptors();
  }

  Future<String> _initializeSharedPreference() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    if (_sharedPreferences.getString(Api.token) != null) {
      token = _sharedPreferences.getString(Api.token)!;
      return token;
    }
    return AppStrings.empty;
  }

  Future<Response> getRequest(String endPoint) async {
    Response response;
    token = await _initializeSharedPreference();

    var headers = {
      AppStrings.capAccept: Api.applicationJson,
      //AppStrings.capAuthorization: '${AppStrings.capBearer} $token',
    };

    try {
      response = await _dio.get(endPoint, options: Options(
        method: AppStrings.capsGet,
        headers: headers,
      ));
    } on DioException catch (e) {
      throw Exception(e.message);
    }
    return response;
  }



  _initializeInterceptors() {
    _dio.interceptors.add(InterceptorsWrapper());
  }
}