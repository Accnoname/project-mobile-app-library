import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:library_management_app/configs/themes/gap.dart';
import 'package:library_management_app/models/book_model.dart';

class SelectBookScreen extends StatefulWidget {
  final List<Map<String, dynamic>> existingBooks;

  const SelectBookScreen({super.key, required this.existingBooks});

  @override
  State<SelectBookScreen> createState() => _SelectBookScreenState();
}

class _SelectBookScreenState extends State<SelectBookScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Chỉ lưu id và quantity
  late Map<String, int> _selectedBooksQty;

  @override
  void initState() {
    super.initState();
    _selectedBooksQty = {
      for (var b in widget.existingBooks)
        (b['bookId']?.toString() ?? ''): (b['quantity'] as int? ?? 1),
    };
  }

  bool _isSelected(String id) => _selectedBooksQty.containsKey(id);

  int _getSelectedQuantity(String id) => _selectedBooksQty[id] ?? 0;

  void _toggleSelection(BookModel book) async {
    final maxQuantity = book.availableCount;
    final currentQty = _getSelectedQuantity(book.id);

    final quantity = await _showQuantityDialog(
      book.title,
      initial: currentQty > 0 ? currentQty : 1,
      maxQuantity: maxQuantity,
    );
    //
    if (quantity != null && quantity > 0) {
      setState(() {
        _selectedBooksQty[book.id] = quantity;
      });
    }
  }

  Future<int?> _showQuantityDialog(
    String title, {
    int initial = 1,
    required int maxQuantity,
  }) async {
    final controller = TextEditingController(text: initial.toString());

    return showDialog<int>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Chọn số lượng mượn'),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'Số lượng cho "$title" (tối đa $maxQuantity)',
            border: const OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy'),
          ),
          ElevatedButton(
            onPressed: () {
              final value = int.tryParse(controller.text.trim());
              if (value == null || value <= 0) return;
              if (value > maxQuantity) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Số lượng không được vượt quá $maxQuantity'),
                  ),
                );
                return;
              }
              Navigator.pop(context, value);
            },
            child: const Text('Xác nhận'),
          ),
        ],
      ),
    );
  }

  void _removeBook(String id) {
    setState(() {
      _selectedBooksQty.remove(id);
    });
  }

  void _saveSelection(List<BookModel> allBooks) {
    // Khi lưu, kết hợp id + quantity + thông tin sách
    final selectedBooks = allBooks
        .where((book) => _selectedBooksQty.containsKey(book.id))
        .map(
          (book) => {
            'bookId': book.id,
            'book': book,
            'quantity': _selectedBooksQty[book.id] ?? 1,
          },
        )
        .toList();

    Navigator.pop(context, selectedBooks);
  }

  int _getTotalSelectedBooks() {
    return _selectedBooksQty.values.fold<int>(0, (s, q) => s + q);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        foregroundColor: colorScheme.onSecondary,
        backgroundColor: colorScheme.primary,
        title: Text("Chọn sách mượn"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('books').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final books = snapshot.data!.docs.map((doc) {
            final data = doc.data() as Map<String, dynamic>? ?? {};
            return BookModel.fromJson(data, doc.id);
          }).toList();

          if (books.isEmpty) {
            return const Center(child: Text("Chưa có sách nào trong kho."));
          }

          return ListView.builder(
            padding: const EdgeInsets.only(bottom: 80, left: 10, right: 10),
            itemCount: books.length,
            itemBuilder: (_, i) {
              final book = books[i];
              final isSelected = _isSelected(book.id);
              final selectedQty = _getSelectedQuantity(book.id);

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 6),
                color: isSelected
                    ? colorScheme.primaryContainer.withAlpha(200)
                    : null,
                child: ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      book.imageUrl.isNotEmpty
                          ? book.imageUrl
                          : 'https://via.placeholder.com/50',
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => const Icon(Icons.book),
                    ),
                  ),
                  title: Text(
                    book.title,
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text("${book.availableCount} quyển"),

                  trailing: isSelected
                      ? Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              spacing: Gap.xs,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("Đã chọn: $selectedQty"),
                                InkWell(
                                  onTap: () => _toggleSelection(book),
                                  child: Icon(
                                    Icons.edit,
                                    color: colorScheme.primary,
                                  ),
                                ),
                                InkWell(
                                  child: Icon(
                                    Icons.delete,
                                    color: colorScheme.error,
                                  ),
                                  onTap: () => _removeBook(book.id),
                                ),
                              ],
                            ),
                          ],
                        )
                      : ElevatedButton.icon(
                          onPressed: () => _toggleSelection(book),
                          icon: const Icon(Icons.add),
                          label: const Text("Chọn"),
                        ),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('books').snapshots(),
        builder: (context, snapshot) {
          // Lấy danh sách đầy đủ để kết hợp khi lưu
          final allBooks =
              snapshot.data?.docs
                  .map(
                    (doc) => BookModel.fromJson(
                      doc.data() as Map<String, dynamic>,
                      doc.id,
                    ),
                  )
                  .toList() ??
              [];

          return Container(
            height: 70,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(color: colorScheme.surface),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Tổng: ${_getTotalSelectedBooks()} quyển",
                  style: textTheme.titleMedium,
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.primary,
                  ),
                  onPressed: _selectedBooksQty.isEmpty
                      ? null
                      : () => _saveSelection(allBooks),
                  icon: const Icon(Icons.save, size: 20),
                  label: const Text("Lưu chọn"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
