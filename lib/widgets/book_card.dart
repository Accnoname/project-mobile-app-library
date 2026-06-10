import 'package:flutter/material.dart';
import 'package:library_management_app/models/book_model.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

class BookCard extends StatelessWidget {
  final BookModel book;
  final bool isDark;
  final VoidCallback onTap;

  const BookCard({
    super.key,
    required this.book,
    required this.isDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const double imgW = 56;
    const double imgH = 76;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E2130) : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: isDark ? const Color(0xFF2C3248) : const Color(0xFFE9ECEF)),
          boxShadow: isDark
              ? []
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  )
                ],
        ),
        child: Row(
          children: [
            // Cover
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: book.imageUrl.isNotEmpty
                  ? Image.network(
                      book.imageUrl,
                      width: imgW,
                      height: imgH,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => _placeholder(imgW, imgH, isDark),
                      loadingBuilder: (_, child, progress) => progress == null
                          ? child
                          : SizedBox(
                              width: imgW,
                              height: imgH,
                              child: const Center(
                                child: CircularProgressIndicator(strokeWidth: 2),
                              ),
                            ),
                    )
                  : _placeholder(imgW, imgH, isDark),
            ),
            const SizedBox(width: 14),
            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    book.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: isDark ? Colors.white : const Color(0xFF212529),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    book.author,
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark ? const Color(0xFF6C757D) : const Color(0xFF9FA8B5),
                    ),
                  ),
                  if (book.publisher.isNotEmpty) ...[
                    const SizedBox(height: 2),
                    Text(
                      book.publisher,
                      style: TextStyle(
                        fontSize: 11,
                        color: isDark ? const Color(0xFF495057) : const Color(0xFFCED4DA),
                      ),
                    ),
                  ],
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: book.availableCount > 0
                              ? const Color(0xFF0CA678).withOpacity(0.12)
                              : const Color(0xFFE03131).withOpacity(0.12),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          'Còn ${book.availableCount} cuốn',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: book.availableCount > 0
                                ? const Color(0xFF0CA678)
                                : const Color(0xFFE03131),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              color: isDark ? const Color(0xFF2C3248) : const Color(0xFFCED4DA),
            ),
          ],
        ),
      ),
    );
  }

  Widget _placeholder(double w, double h, bool isDark) {
    return Container(
      width: w,
      height: h,
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2C3248) : const Color(0xFFF1F3F9),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(
        Icons.menu_book_rounded,
        color: isDark ? const Color(0xFF495057) : const Color(0xFFCED4DA),
        size: 28,
      ),
    );
  }
}

@widgetbook.UseCase(
  name: 'Default',
  type: BookCard,
  designLink: 'https://www.figma.com/file/your-file-id/your-node-id', // Thay link thiết kế Figma của bạn vào đây
)
Widget buildBookCardUseCase(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: BookCard(
      book: BookModel(
        id: '1',
        title: 'Flutter Architecture',
        author: 'Google',
        publisher: 'Google Press',
        year: '2024',
        imageUrl: '',
        availableCount: 3,
      ),
      isDark: Theme.of(context).brightness == Brightness.dark,
      onTap: () {},
    ),
  );
}

