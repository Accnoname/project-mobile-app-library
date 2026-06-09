import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:library_management_app/models/loan_model.dart';

void main() {
  group('LoanModel Tests', () {
    final now = DateTime.now();
    final timestamp = Timestamp.fromDate(now);

    test('Tạo LoanModel thành công', () {
      final loan = LoanModel(
        id: 'loan1',
        userId: 'user1',
        type: 'borrow',
        date: now,
        books: [
          {'bookId': 'b1', 'title': 'Sách 1', 'quantity': 2, 'imageUrl': ''},
        ],
      );

      expect(loan.id, 'loan1');
      expect(loan.type, 'borrow');
      expect(loan.books.length, 1);
      expect(loan.books.first['quantity'], 2);
    });

    test('Chuyển đổi LoanModel sang JSON (toJson)', () {
      final loan = LoanModel(
        id: 'loan2',
        userId: 'user2',
        type: 'return',
        date: now,
        books: [
          {'bookId': 'b2', 'title': 'Sách 2', 'quantity': 1},
          {'bookId': 'b3', 'title': 'Sách 3', 'quantity': 3},
        ],
      );

      final json = loan.toJson();

      expect(json['userId'], 'user2');
      expect(json['type'], 'return');
      expect(json['date'], isA<Timestamp>());
      expect(json['books'], isA<List>());
      expect((json['books'] as List).length, 2);
    });

    test('Tạo LoanModel từ JSON (fromJson)', () {
      final json = {
        'userId': 'user3',
        'type': 'borrow',
        'date': timestamp,
        'books': [
          {'bookId': 'b1', 'title': 'S1', 'quantity': 1},
          {'bookId': 'b2', 'title': 'S2', 'quantity': 4},
        ],
      };

      final loan = LoanModel.fromJson(json, 'loan3');

      expect(loan.id, 'loan3');
      expect(loan.userId, 'user3');
      expect(loan.type, 'borrow');
      expect(loan.date.year, now.year);
      expect(loan.books.length, 2);
      expect(loan.books[1]['quantity'], 4);
      expect(loan.books[1]['bookId'], 'b2');
    });

    test('Test Extension totalBooks', () {
      final loan = LoanModel(
        id: 'test',
        userId: 'u',
        type: 'borrow',
        date: now,
        books: [
          {'bookId': 'b1', 'title': 'A', 'quantity': 2},
          {'bookId': 'b2', 'title': 'B', 'quantity': 3},
        ],
      );

      expect(loan.totalBooks, 5); // 2 + 3
    });
  });
}
