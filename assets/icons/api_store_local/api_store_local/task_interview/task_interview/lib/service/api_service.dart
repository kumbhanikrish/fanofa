import 'dart:developer';

import 'package:dio/dio.dart';

class ApiRepository {
  final Dio dio = Dio();

  Future sendFormData(
      {required String url, required Map<String, dynamic> data}) async {
    FormData formData = FormData.fromMap(data);

    log('formDataformDataformDataformData ::${formData}');
    

    final response = await dio.post(
      url,
      data: formData,
    );

    if (response.statusCode == 200) {
      log('Response Data: ${response.data}');
    } else {
      log('Error: ${response.statusCode}');
    }

    return response;
  }
}
