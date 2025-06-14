class FaqResponse {
  bool status;
  String message;
  List<FaqItem> data;
  Pagination pagination;

  FaqResponse({
    required this.status,
    required this.message,
    required this.data,
    required this.pagination,
  });

  factory FaqResponse.fromJson(Map<String, dynamic> json) {
    return FaqResponse(
      status: json['status'],
      message: json['message'],
      data: List<FaqItem>.from(
        json['data'].map((item) => FaqItem.fromJson(item)),
      ),
      pagination: Pagination.fromJson(json['pagination']),
    );
  }
}

class Pagination {
  int total;
  int perPage;
  int currentPage;
  int lastPage;
  String? nextPageUrl;
  String? prevPageUrl;

  Pagination({
    required this.total,
    required this.perPage,
    required this.currentPage,
    required this.lastPage,
    this.nextPageUrl,
    this.prevPageUrl,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      total: json['total'],
      perPage: json['per_page'],
      currentPage: json['current_page'],
      lastPage: json['last_page'],
      nextPageUrl: json['next_page_url'],
      prevPageUrl: json['prev_page_url'],
    );
  }
}

class FaqItem {
  int id;
  String question;
  String answer;
  DateTime createdAt;
  DateTime updatedAt;

  FaqItem({
    required this.id,
    required this.question,
    required this.answer,
    required this.createdAt,
    required this.updatedAt,
  });

  factory FaqItem.fromJson(Map<String, dynamic> json) {
    return FaqItem(
      id: json['id'],
      question: json['question'],
      answer: json['answer'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
