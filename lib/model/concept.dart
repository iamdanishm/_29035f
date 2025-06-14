class ConceptResponse {
  bool status;
  String message;
  List<ConceptItem> data;
  Pagination pagination;

  ConceptResponse({
    required this.status,
    required this.message,
    required this.data,
    required this.pagination,
  });

  factory ConceptResponse.fromJson(Map<String, dynamic> json) {
    return ConceptResponse(
      status: json['status'],
      message: json['message'],
      data: List<ConceptItem>.from(
        json['data'].map((x) => ConceptItem.fromJson(x)),
      ),
      pagination: Pagination.fromJson(json['pagination']),
    );
  }
}

class ConceptItem {
  int id;
  String title;
  String description;
  String image;
  DateTime createdAt;
  DateTime updatedAt;
  String? imageUrl;

  ConceptItem({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
    this.imageUrl,
  });

  factory ConceptItem.fromJson(Map<String, dynamic> json) {
    return ConceptItem(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      image: json['image'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      imageUrl: json['image_url'] as String?,
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
      nextPageUrl: json['next_page_url'] as String?,
      prevPageUrl: json['prev_page_url'] as String?,
    );
  }
}
