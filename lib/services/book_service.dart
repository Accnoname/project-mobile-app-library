import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:library_management_app/models/book_model.dart';

class BookService {
  final CollectionReference _books = FirebaseFirestore.instance.collection(
    'books',
  );

  Future<List<BookModel>> getBooksOnce() async {
    final snapshot = await _books.get();
    return snapshot.docs
        .map(
          (doc) =>
              BookModel.fromJson(doc.data() as Map<String, dynamic>, doc.id),
        )
        .toList();
  }

  Future<void> addBook(BookModel book) async {
    await _books.add(book.toJson());
  }

  Future<void> updateBook(BookModel book) async {
    await _books.doc(book.id).update(book.toJson());
  }

  Future<void> deleteBook(String id) async {
    await _books.doc(id).delete();
  }

  Stream<List<BookModel>> getBooks() {
    return _books.snapshots().map((snapshot) {
      return snapshot.docs
          .map(
            (doc) =>
                BookModel.fromJson(doc.data() as Map<String, dynamic>, doc.id),
          )
          .toList();
    });
  }
}
