import 'package:flutter_test/flutter_test.dart';
import 'package:library_management_app/models/book_model.dart';

void main() {
  group('BookModel Tests', () {
    test('Khởi tạo BookModel thành công', () {
      final book = BookModel(
        id: '1',
        title: 'Flutter Cơ Bản',
        author: 'Nguyễn Văn A',
        publisher: 'NXB ABC',
        year: '2023',
        availableCount: 10,
        imageUrl: 'https://example.com/image.jpg',
      );

      expect(book.id, '1');
      expect(book.title, 'Flutter Cơ Bản');
      expect(book.author, 'Nguyễn Văn A');
      expect(book.availableCount, 10);
    });

    test('Chuyển đổi BookModel sang JSON (toJson) chính xác', () {
      final book = BookModel(
        id: '1',
        title: 'Lập trình Dart',
        author: 'Trần B',
        publisher: 'NXB IT',
        year: '2022',
        availableCount: 5,
        imageUrl: '',
      );

      final map = book.toJson();

      expect(map['title'], 'Lập trình Dart');
      expect(map['author'], 'Trần B');
      expect(map['availableCount'], 5);
      expect(map['imageUrl'], '');
    });

    test('Tạo BookModel từ JSON (fromJson) chính xác', () {
      final map = {
        'title': 'Cấu trúc dữ liệu',
        'author': 'Lê C',
        'publisher': 'NXB Khoa học',
        'year': '2021',
        'availableCount': 3,
        'imageUrl': 'test.png',
      };

      final book = BookModel.fromJson(map, 'doc123');

      expect(book.id, 'doc123');
      expect(book.title, 'Cấu trúc dữ liệu');
      expect(book.availableCount, 3);
    });
  });
}
