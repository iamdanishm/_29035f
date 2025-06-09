class ConceptItem {
  final String header;
  final String body;
  final String image;
  final bool isExpanded;

  ConceptItem({
    required this.header,
    required this.body,
    required this.image,
    this.isExpanded = false,
  });

  ConceptItem copyWith({
    String? header,
    String? body,
    String? image,
    bool? isExpanded,
  }) {
    return ConceptItem(
      header: header ?? this.header,
      body: body ?? this.body,
      image: image ?? this.image,
      isExpanded: isExpanded ?? this.isExpanded,
    );
  }

  factory ConceptItem.fromJson(Map<String, dynamic> json) {
    return ConceptItem(
      header: json['header'] as String,
      body: json['body'] as String,
      image: json['image'] as String,
      isExpanded: false, // Always initialize to false when loading from API
    );
  }
}
