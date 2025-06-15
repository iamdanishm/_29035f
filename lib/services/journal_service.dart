import 'dart:developer';

import 'package:_29035f/model/journal.dart';
import 'package:_29035f/services/api.dart';
import 'package:dio/dio.dart';

class JournalApiService {
  Future<JournalModel> fetchJournal() async {
    try {
      final dio = Dio();
      const url = API.blogs;

      final response = await dio.get(url);

      if (response.statusCode == 200) {
        final responsedata = response.data;
        final journalRes = JournalModel.fromJson(responsedata);
        return journalRes;
      } else if (response.statusCode == 400) {
        throw Exception("Failed to load Journal page");
      }
    } on DioException catch (e) {
      log("Error: ${e.message}");
      throw Exception("Failed to load Journal page");
    }

    throw Exception("Failed to load Journal page");
  }
}
