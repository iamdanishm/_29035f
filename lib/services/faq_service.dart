import 'dart:developer';

import 'package:_29035f/model/faq.dart';
import 'package:_29035f/services/api.dart';
import 'package:dio/dio.dart';

class FaqApiService {
  Future<FaqResponse> fetchFaq(int page) async {
    try {
      final dio = Dio();

      const url = API.faq;

      final response = await dio.get("$url?page=$page");

      if (response.statusCode == 200) {
        final responsedata = response.data;

        final faqRes = FaqResponse.fromJson(responsedata);

        return faqRes;
      } else if (response.statusCode == 400) {
        throw Exception("Failed to load FAQ page");
      }
    } on DioException catch (e) {
      log("Error: ${e.message}");
      throw Exception("Failed to load FAQ page");
    }

    throw Exception("Failed to load FAQ page");
  }
}
