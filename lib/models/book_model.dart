class BookModel {
  final String id;
  final String title;
  final String author;
  final String publisher;
  final String year;
  final String imageUrl;
  final int availableCount;

  BookModel({
    required this.id,
    required this.title,
    required this.author,
    required this.publisher,
    required this.year,
    required this.imageUrl,
    required this.availableCount,
  });

  factory BookModel.fromJson(Map<String, dynamic> json, String id) {
    return BookModel(
      id: id,
      title: json['title'] ?? '',
      author: json['author'] ?? '',
      publisher: json['publisher'] ?? '',
      year: json['year'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      availableCount: json['availableCount'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'author': author,
      'publisher': publisher,
      'year': year,
      'imageUrl': imageUrl,
      'availableCount': availableCount,
    };
  }
}


