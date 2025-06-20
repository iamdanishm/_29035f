import 'package:_29035f/model/daily_gps_today.dart';

class DailyGpsService {
  Future<DailyGpsTodayModal> fetch() async {
    try {
      Future.delayed(const Duration(seconds: 2));

      return DailyGpsTodayModal.fromJson(sampleData);
    } catch (e) {
      throw Exception("Failed to load Daily GPS page");
    }
  }
}

final sampleData = {
  "success": true,
  "message": "Success",
  "data": [
    {
      "id": 1,
      "image":
          "https://cdn.pixabay.com/photo/2015/04/23/22/00/new-year-background-736885_1280.jpg",
      "title": "Declutter and Flow",
      "subtitle": "0/1 Steps",
    },
    {
      "id": 2,
      "image": "",
      "title": "Brisk Walking",
      "subtitle": "2000 steps/ day",
    },
    {
      "id": 3,
      "image":
          "https://cdn.pixabay.com/photo/2015/04/23/22/00/new-year-background-736885_1280.jpg",
      "title": "Ahara Mindful Eating",
      "subtitle": "Target Here",
    },
    {
      "id": 4,
      "image": "",
      "title": "Reading Journal",
      "subtitle": "20 pages / day",
    },
    {
      "id": 5,
      "image":
          "https://cdn.pixabay.com/photo/2015/04/23/22/00/new-year-background-736885_1280.jpg",
      "title": "Practice Empathetic Presence",
      "subtitle": "Target Here",
    },
    {
      "id": 6,
      "image":
          "https://cdn.pixabay.com/photo/2015/04/23/22/00/new-year-background-736885_1280.jpg",
      "title": "Sleep 7-8 Hours",
      "subtitle": "Target Here",
    },
    {
      "id": 7,
      "image": "",
      "title": "Brisk Walking",
      "subtitle": "2000 steps/ day",
    },
    {
      "id": 8,
      "image":
          "https://cdn.pixabay.com/photo/2015/04/23/22/00/new-year-background-736885_1280.jpg",
      "title": "Ahara Mindful Eating",
      "subtitle": "Target Here",
    },
    {
      "id": 9,
      "image": "",
      "title": "Reading Journal",
      "subtitle": "20 pages / day",
    },
    {
      "id": 10,
      "image":
          "https://cdn.pixabay.com/photo/2015/04/23/22/00/new-year-background-736885_1280.jpg",
      "title": "Practice Empathetic Presence",
      "subtitle": "Target Here",
    },
  ],
};
