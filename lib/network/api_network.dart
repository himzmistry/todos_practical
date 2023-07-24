import 'package:dio/dio.dart';

import 'api_sheet.dart';

final dio = Dio();

class ApiNetwork {
  Future<dynamic> getRequest(String endpoint) async {
    try {
      String finalUrl = ApiSheet.baseUrl + endpoint;
      print('url: $finalUrl');
      final response = await dio.get(finalUrl);
      // print('Response: ${response}');
      return response;
    } catch (e) {
      print('getRequest: $e');
    }
  }
}
