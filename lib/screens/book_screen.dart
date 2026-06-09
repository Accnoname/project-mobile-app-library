import 'package:flutter/material.dart';
import 'package:library_management_app/configs/themes/common.dart';
import 'package:library_management_app/models/book_model.dart';
import 'package:library_management_app/services/book_service.dart';
import 'package:library_management_app/screens/add_book_screen.dart';
import 'package:library_management_app/screens/edit_book_screen.dart';

class BookScreen extends StatefulWidget {
  const BookScreen({super.key});

  @override
  State<BookScreen> createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {
  final BookService _bookService = BookService();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onSecondary,
          title: const Text('Sách'),
          leading: SizedBox.shrink(),
          centerTitle: true,
        ),

        body: Column(
          children: [
            TabBar(
              labelColor: colorScheme.primary,
              dividerColor: Colors.transparent,
              tabs: const [
                Tab(text: 'Tất cả'),
                Tab(text: 'Thể loại'),
              ],
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                children: [
                  // product count will be updated via stream below; display placeholder here
                  Expanded(
                    child: StreamBuilder<List<BookModel>>(
                      stream: _bookService.getBooks(),
                      builder: (context, snapshot) {
                        final count = snapshot.hasData
                            ? snapshot.data!.length
                            : 0;
                        return Text(
                          '$count sản phẩm',
                          style: TextStyle(
                            color: colorScheme.onPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        );
                      },
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.filter_alt, color: colorScheme.primary),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: TabBarView(
                children: [
                  // Tab 1: Tất cả
                  _buildAllTab(context),

                  // Tab 2: Thể loại (tạm hiện danh sách theo thể loại; bạn có thể thay bằng filter)
                  _buildCategoryTab(context),
                ],
              ),
            ),
          ],
        ),

        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: colorScheme.primary,
          onPressed: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AddBookScreen()),
            );
            // nếu dùng stream thì tự cập nhật; nếu dùng get once thì cần reload
          },
          icon: Icon(Icons.add, color: colorScheme.onSecondary),
          label: Text(
            'Thêm sách',
            style: textTheme.titleLarge?.copyWith(
              color: colorScheme.onSecondary,
              fontSize: 20,
            ),
          ),
          shape: RoundedRectangleBorder(borderRadius: radius100),
        ),
      ),
    );
  }

  Widget _buildAllTab(BuildContext context) {
    return StreamBuilder<List<BookModel>>(
      stream: _bookService.getBooks(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final books = snapshot.data ?? [];

        if (books.isEmpty) {
          return const Center(child: Text('Chưa có sách nào'));
        }

        return ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          itemCount: books.length,
          separatorBuilder: (_, __) => const Divider(height: 1),
          itemBuilder: (context, index) {
            final BookModel book = books[index];
            return ListTile(
              contentPadding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 4,
              ),
              leading: _buildLeadingImage(book),
              title: Text(
                book.title,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 6.0),
                child: Text.rich(
                  TextSpan(
                    text: 'Có thể mượn : ',
                    style: const TextStyle(color: Colors.black54),
                    children: [
                      TextSpan(
                        text: '${book.availableCount}',
                        style: const TextStyle(color: Colors.blue),
                      ),
                    ],
                  ),
                ),
              ),
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => EditBookScreen(book: book)),
                );
              },
            );
          },
        );
      },
    );
  }

  //m
  Widget _buildLeadingImage(BookModel book) {
    const double w = 48;
    const double h = 64;
    if (book.imageUrl.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: Image.network(
          book.imageUrl,
          width: w,
          height: h,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stack) => _placeholderBox(w, h),
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return SizedBox(
              width: w,
              height: h,
              child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
            );
          },
        ),
      );
    } else {
      return _placeholderBox(w, h);
    }
  }

  Widget _placeholderBox(double w, double h) {
    return Container(
      width: w,
      height: h,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(6),
      ),
      child: const Icon(Icons.menu_book, color: Colors.grey, size: 28),
    );
  }

  Widget _buildCategoryTab(BuildContext context) {
    // Tạm: hiển thị list thể loại; nếu bạn có trường category trong BookModel
    // có thể nhóm theo category. Ở đây mình chỉ show tất cả theo fallback.
    return StreamBuilder<List<BookModel>>(
      stream: _bookService.getBooks(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final books = snapshot.data!;

        // Nếu bạn có category field, bạn có thể build danh sách thể loại:
        final categories = <String>{};
        for (final b in books) {
          // giả sử BookModel có field 'category'
          // categories.add(b.category ?? 'Không phân loại');
          // hiện tại không biết, sẽ gán 'Tất cả' cho demo
          categories.add('Tất cả');
        }

        final catList = categories.toList();

        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: catList.length,
          itemBuilder: (context, idx) {
            final cat = catList[idx];
            return ListTile(
              title: Text(
                cat,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                // TODO: lọc theo thể loại
                // Navigator.push(... lọc ...)
              },
            );
          },
        );
      },
    );
  }
}
