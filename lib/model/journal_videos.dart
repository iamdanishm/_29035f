class JournalVideoModal {
  bool status;
  String message;
  List<JournalVideoData> data;
  Pagination pagination;

  JournalVideoModal({
    required this.status,
    required this.message,
    required this.data,
    required this.pagination,
  });

  factory JournalVideoModal.fromJson(Map<String, dynamic> json) {
    return JournalVideoModal(
      status: json['status'],
      message: json['message'],
      data: List<JournalVideoData>.from(
        json['data'].map((x) => JournalVideoData.fromJson(x)),
      ),
      pagination: Pagination.fromJson(json['pagination']),
    );
  }
}

class JournalVideoData {
  int id;
  String title;
  String slug;
  int categoryId;
  int authorId;
  String content;
  String video;
  String photo;
  int isPublished;
  DateTime? publishedAt;
  DateTime createdAt;
  DateTime updatedAt;
  String videoUrl;
  String photoUrl;
  Category category;

  JournalVideoData({
    required this.id,
    required this.title,
    required this.slug,
    required this.categoryId,
    required this.authorId,
    required this.content,
    required this.video,
    required this.photo,
    required this.isPublished,
    required this.publishedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.videoUrl,
    required this.photoUrl,
    required this.category,
  });

  factory JournalVideoData.fromJson(Map<String, dynamic> json) {
    return JournalVideoData(
      id: json['id'],
      title: json['title'],
      slug: json['slug'],
      categoryId: json['category_id'],
      authorId: json['author_id'],
      content: json['content'],
      video: json['video'],
      photo: json['photo'],
      isPublished: json['is_published'],
      publishedAt: json['published_at'] == null
          ? null
          : DateTime.parse(json['published_at']),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      videoUrl: json['video_url'],
      photoUrl: json['photo_url'],
      category: Category.fromJson(json['category']),
    );
  }
}

class Category {
  int id;
  String name;
  String title;
  String? slug;
  String? description;
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
  String? nextPageUrl;
  String? prevPageUrl;

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
