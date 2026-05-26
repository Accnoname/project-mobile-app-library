import 'package:cloud_firestore/cloud_firestore.dart';

class LoanModel {
  String id;
  String userId;
  String type; // "borrow" hoặc "return"
  DateTime date;
  List<Map<String, dynamic>> books; // [{bookId, title, quantity, imageUrl}]

  LoanModel({
    required this.id,
    required this.userId,
    required this.type,
    required this.date,
    required this.books,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'type': type,
      'date': Timestamp.fromDate(date),
      'books': books,
    };
  }

  LoanModel copyWith({
    String? id,
    String? userId,
    String? type,
    DateTime? date,
    List<Map<String, dynamic>>? books,
  }) {
    return LoanModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      type: type ?? this.type,
      date: date ?? this.date,
      books: books ?? this.books,
    );
  }

  factory LoanModel.fromJson(Map<String, dynamic> json, String id) {
    return LoanModel(
      id: id,
      userId: json['userId'] ?? '',
      type: json['type'] ?? 'borrow',
      date: (json['date'] as Timestamp).toDate(),
      books: List<Map<String, dynamic>>.from(json['books'] ?? []),
    );
  }
}

extension LoanModelExtension on LoanModel {
  /// Tổng số sách đã gộp các cuốn trùng nhau
  int get totalBooks {
    final Map<String, int> bookMap = {};

    for (var b in books) {
      final title = b["title"] as String;
      final quantity = b["quantity"] as int;
      bookMap[title] = (bookMap[title] ?? 0) + quantity;
    }

    return bookMap.values.fold(0, (s, qty) => s + qty);
  }
}
