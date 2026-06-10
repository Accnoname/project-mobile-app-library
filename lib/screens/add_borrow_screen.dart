import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:library_management_app/models/book_model.dart';
import 'package:library_management_app/models/loan_model.dart';
import 'package:library_management_app/services/book_service.dart';
import 'package:library_management_app/services/loan_service.dart';

//them phieu muon moi
class AddBorrowScreen extends StatefulWidget {
  const AddBorrowScreen({super.key});

  @override
  State<AddBorrowScreen> createState() => _AddBorrowScreenState();
}

class _AddBorrowScreenState extends State<AddBorrowScreen> {
  final LoanService _loanService = LoanService();
  final BookService _bookService = BookService();

  List<BookModel> _books = [];
  final List<Map<String, dynamic>> _selectedBooks = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchBooks();
  }

  Future<void> _fetchBooks() async {
    final books = await _bookService.getBooksOnce();
    setState(() => _books = books);
  }

  void _toggleBook(BookModel book) {
    final index = _selectedBooks.indexWhere((b) => b['bookId'] == book.id);
    if (index >= 0) {
      _selectedBooks.removeAt(index);
    } else {
      _selectedBooks.add({
        'bookId': book.id,
        'title': book.title,
        'quantity': 1,
        'imageUrl': book.imageUrl,
      });
    }
    setState(() {});
  }

  void _updateQuantity(String bookId, int delta) {
    final index = _selectedBooks.indexWhere((b) => b['bookId'] == bookId);
    if (index >= 0) {
      int current = _selectedBooks[index]['quantity'];
      int newQty = current + delta;
      if (newQty < 1) newQty = 1;
      _selectedBooks[index]['quantity'] = newQty;
      setState(() {});
    }
  }

  Future<void> _saveLoan() async {
    if (_selectedBooks.isEmpty) return;

    setState(() => _isLoading = true);
    final user = FirebaseAuth.instance.currentUser;

    final loan = LoanModel(
      id: '',
      userId: user?.uid ?? '',
      type: 'borrow',
      date: DateTime.now(),
      books: _selectedBooks,
    );

    await _loanService.addLoan(loan);
    setState(() => _isLoading = false);

    if (mounted) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Đã thêm phiếu mượn thành công!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Thêm phiếu mượn')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const Text(
                  'Chọn sách muốn mượn:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 12),

                // Danh sách sách hiển thị
                ..._books.map((book) {
                  final selectedIndex = _selectedBooks.indexWhere(
                    (b) => b['bookId'] == book.id,
                  );
                  final isSelected = selectedIndex >= 0;
                  final quantity = isSelected
                      ? _selectedBooks[selectedIndex]['quantity'] as int
                      : 0;

                  return Card(
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(
                        color: isSelected
                            ? colorScheme.primary
                            : Colors.grey.shade300,
                        width: 1,
                      ),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(12),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          book.imageUrl,
                          width: 55,
                          height: 80,
                          fit: BoxFit.cover,
                          errorBuilder: (context, _, __) => Container(
                            width: 55,
                            height: 80,
                            color: Colors.grey.shade200,
                            child: const Icon(Icons.book, color: Colors.grey),
                          ),
                        ),
                      ),
                      title: Text(
                        book.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      subtitle: isSelected
                          ? Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove_circle_outline),
                                  color: colorScheme.primary,
                                  onPressed: () => _updateQuantity(book.id, -1),
                                ),
                                Text(
                                  '$quantity',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.add_circle_outline),
                                  color: colorScheme.primary,
                                  onPressed: () {
                                    if (quantity < book.availableCount) {
                                      _updateQuantity(book.id, 1);
                                    }
                                  },
                                ),
                              ],
                            )
                          : null,
                      trailing: Checkbox(
                        value: isSelected,
                        onChanged: (_) => _toggleBook(book),
                      ),
                      onTap: () => _toggleBook(book),
                    ),
                  );
                }),

                const SizedBox(height: 24),

                // Nút lưu phiếu mượn
                ElevatedButton.icon(
                  onPressed: _selectedBooks.isEmpty ? null : _saveLoan,
                  icon: const Icon(Icons.save),
                  label: const Text('Lưu phiếu mượn'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    backgroundColor: colorScheme.primary,
                    foregroundColor: colorScheme.onPrimary,
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
