import 'package:flutter/material.dart';
import 'package:library_management_app/models/book_model.dart';
import 'package:library_management_app/models/loan_model.dart';
import 'package:library_management_app/screens/select_book_screen.dart';
import 'package:library_management_app/services/loan_service.dart';

class LoanDetailScreen extends StatefulWidget {
  final LoanModel loan;

  const LoanDetailScreen({super.key, required this.loan});

  @override
  State<LoanDetailScreen> createState() => _LoanDetailScreenState();
}

class _LoanDetailScreenState extends State<LoanDetailScreen> {
  late LoanModel _loan;
  final LoanService _loanService = LoanService();

  @override
  void initState() {
    super.initState();
    _loan = widget.loan;
    _reloadLoan();
  }

  /// Reload lại thông tin phiếu từ Firestore
  Future<void> _reloadLoan() async {
    final updated = await _loanService.getLoanById(_loan.id);
    if (updated != null) {
      setState(() {
        _loan = updated;
      });
    }
  }

  /// Xóa 1 cuốn sách khỏi phiếu
  Future<void> _removeBook(String bookId) async {
    final updatedBooks = List<Map<String, dynamic>>.from(_loan.books)
      ..removeWhere((book) => book['id'] == bookId);

    setState(() {
      _loan = _loan.copyWith(books: updatedBooks);
    });

    await _loanService.updateLoan(_loan);
    await _reloadLoan();
  }

  Future<void> _addBook() async {
    // Mở màn chọn sách, trả về danh sách đã chọn (bao gồm quantity)
    final selected = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SelectBookScreen(existingBooks: _loan.books),
      ),
    );

    // Nếu không chọn gì thì bỏ qua
    if (selected == null || selected is! List) return;

    // Chuẩn hóa lại kiểu dữ liệu
    final List<Map<String, dynamic>> normalized = selected
        .map<Map<String, dynamic>>((item) {
          if (item is Map) {
            final id =
                (item['id'] ?? item['bookId'] ?? item['book_id'])?.toString() ??
                '';
            final book = item['book'] as BookModel?;
            final quantity = (item['quantity'] is int)
                ? item['quantity']
                : int.tryParse(item['quantity'].toString()) ?? 1;

            return {
              'id': id,
              'title': book?.title ?? item['title'] ?? '',
              'imageUrl': book?.imageUrl ?? item['imageUrl'] ?? '',
              'quantity': quantity,
            };
          }
          return {};
        })
        .where((e) => e.isNotEmpty)
        .toList();

    if (normalized.isEmpty) return;

    // Cập nhật loan mới
    final updatedLoan = _loan.copyWith(books: normalized);

    // Cập nhật Firestore
    await _loanService.updateLoan(updatedLoan);

    // Cập nhật lại UI
    setState(() {
      _loan = updatedLoan;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onSecondary,
        title: Text("Chi tiết phiếu mượn"),
      ),
      body: RefreshIndicator(
        onRefresh: _reloadLoan,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Row(
              children: [
                const Icon(Icons.receipt_long, color: Colors.orange),
                const SizedBox(width: 8),
                Text(
                  "Phiếu số: ${_loan.id.substring(0, 6)}",
                  style: textTheme.titleMedium,
                ),
              ],
            ),
            const SizedBox(height: 16),

            // --- Danh sách sách trong phiếu ---
            if (_loan.books.isEmpty)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Text("Chưa có sách nào trong phiếu này."),
                ),
              )
            else
              ..._loan.books.map((book) {
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    leading:
                        (book['imageUrl'] != null &&
                            book['imageUrl'].toString().isNotEmpty)
                        ? Image.network(
                            book['imageUrl'],
                            width: 50,
                            fit: BoxFit.cover,
                          )
                        : const Icon(Icons.book, size: 40, color: Colors.grey),
                    title: Text(book['title'] ?? 'Không rõ tên'),
                    subtitle: Text(
                      "${_loan.type == "borrow" ? "Mượn" : "Trả"}: ${book['quantity']} quyển",
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.remove_circle, color: Colors.red),
                      onPressed: () => _removeBook(book['id']),
                    ),
                  ),
                );
              }),

            const SizedBox(height: 20),

            // --- Nút thêm sách ---
            Center(
              child: ElevatedButton.icon(
                onPressed: _addBook,
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.primary,
                  foregroundColor: colorScheme.onSecondary,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
                icon: const Icon(Icons.edit),
                label: Text("Chỉnh sửa"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
