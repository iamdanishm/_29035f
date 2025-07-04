import 'dart:developer';

import 'package:_29035f/services/api.dart';
import 'package:dio/dio.dart';

import '../model/concept.dart';

class ConceptApiService {
  Future<ConceptResponse> fetch(int page) async {
    try {
      final dio = Dio();

      const url = API.concept;

      final response = await dio.get("$url?page=$page");

      if (response.statusCode == 200) {
        final responsedata = response.data;

        final res = ConceptResponse.fromJson(responsedata);

        return res;
      } else if (response.statusCode == 400) {
        throw Exception("Failed to load Concepts page");
      }
    } on DioException catch (e) {
      log("Error: ${e.message}");
      throw Exception("Failed to load Concepts page");
    }

    throw Exception("Failed to load Concepts page");
  }
}
