class JournalModel {
  bool status;
  String message;
  List<Journal> data;
  Pagination pagination;

  JournalModel({
    required this.status,
    required this.message,
    required this.data,
    required this.pagination,
  });

  factory JournalModel.fromJson(Map<String, dynamic> json) {
    return JournalModel(
      status: json['status'],
      message: json['message'],
      data: List<Journal>.from(json['data'].map((x) => Journal.fromJson(x))),
      pagination: Pagination.fromJson(json['pagination']),
    );
  }
}

class Journal {
  int id;
  String title;
  String slug;
  int categoryId;
  int authorId;
  String content;
  String image;
  int isPublished;
  dynamic publishedAt;
  DateTime createdAt;
  DateTime updatedAt;
  String imageUrl;
  Category category;

  Journal({
    required this.id,
    required this.title,
    required this.slug,
    required this.categoryId,
    required this.authorId,
    required this.content,
    required this.image,
    required this.isPublished,
    required this.publishedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.imageUrl,
    required this.category,
  });

  factory Journal.fromJson(Map<String, dynamic> json) {
    return Journal(
      id: json['id'],
      title: json['title'],
      slug: json['slug'],
      categoryId: json['category_id'],
      authorId: json['author_id'],
      content: json['content'],
      image: json['image'],
      isPublished: json['is_published'],
      publishedAt: json['published_at'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      imageUrl: json['image_url'],
      category: Category.fromJson(json['category']),
    );
  }
}

class Category {
  int id;
  String name;
  String title;
  dynamic slug;
  dynamic description;
  int status;
  DateTime createdAt;
  DateTime updatedAt;

  Category({
    required this.id,
    required this.name,
    required this.title,
    required this.slug,
    required this.description,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      title: json['title'],
      slug: json['slug'],
      description: json['description'],
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}

class Pagination {
  int total;
  int perPage;
  int currentPage;
  int lastPage;
  dynamic nextPageUrl;
  dynamic prevPageUrl;

  Pagination({
    required this.total,
    required this.perPage,
    required this.currentPage,
    required this.lastPage,
    required this.nextPageUrl,
    required this.prevPageUrl,
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
