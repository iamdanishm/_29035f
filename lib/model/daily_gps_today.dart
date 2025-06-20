class DailyGpsTodayModal {
  bool success;
  String message;
  List<DailyGpsTodayData> data;

  DailyGpsTodayModal({
    required this.success,
    required this.message,
    required this.data,
  });

  factory DailyGpsTodayModal.fromJson(Map<String, dynamic> json) {
    return DailyGpsTodayModal(
      success: json['success'],
      message: json['message'],
      data: List<DailyGpsTodayData>.from(
        json['data'].map((x) => DailyGpsTodayData.fromJson(x)),
      ),
    );
  }

  DailyGpsTodayModal copyWith({
    bool? success,
    String? message,
    List<DailyGpsTodayData>? data,
  }) {
    return DailyGpsTodayModal(
      success: success ?? this.success,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }
}

class DailyGpsTodayData {
  int id;
  String image;
  String title;
  String subtitle;
  bool isCheck;

  DailyGpsTodayData({
    required this.id,
    required this.image,
    required this.title,
    required this.subtitle,
    this.isCheck = false,
  });

  factory DailyGpsTodayData.fromJson(Map<String, dynamic> json) {
    return DailyGpsTodayData(
      id: json['id'],
      image: json['image'],
      title: json['title'],
      subtitle: json['subtitle'],
      isCheck: false,
    );
  }

  DailyGpsTodayData copyWith({
    int? id,
    String? image,
    String? title,
    String? subtitle,
    bool? isCheck,
  }) {
    return DailyGpsTodayData(
      id: id ?? this.id,
      image: image ?? this.image,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      isCheck: isCheck ?? this.isCheck,
    );
  }
}
