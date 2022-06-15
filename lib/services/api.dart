import 'package:dio/dio.dart';
import '../model/api_model.dart';

class DioClient {
  final Dio _dio = Dio();

  Future<Binary?> getBinary({required int number}) async {
    Binary? data;
    try {
      Response res = await _dio
          .get('https://networkcalc.com/api/binary/$number?from=10&to=2');

      // ignore: avoid_print
      print(res.data);
      Binary data = Binary.fromJson(res.data);

      return data;
    } on DioError catch (e) {
      if (e.response != null) {
        print('Dio error!'); // ignore: avoid_print
        print('STATUS: ${e.response?.statusCode}'); // ignore: avoid_print
        print('DATA: ${e.response?.data}'); // ignore: avoid_print
        print('HEADERS: ${e.response?.headers}'); // ignore: avoid_print
      } else {
        print('Error sending request!'); // ignore: avoid_print
        print(e.message); // ignore: avoid_print
      }
    }
    return data;
  }
}
