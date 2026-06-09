import 'package:flutter/material.dart';
import 'package:library_management_app/common/helpers/extentions.dart';
import 'package:library_management_app/configs/themes/common.dart';
import 'package:library_management_app/configs/themes/gap.dart';
import 'package:library_management_app/models/loan_model.dart';
import 'package:intl/intl.dart';

// chi tiet phieu tra
class ReturnDetailScreen extends StatelessWidget {
  final LoanModel loan;

  const ReturnDetailScreen({super.key, required this.loan});

  String formatDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.theme.colorScheme;
    final textTheme = context.theme.textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chi tiết Phiếu Trả'),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onSecondary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: loan.books.isEmpty
            ? Center(
                child: Text(
                  'Không có sách nào trong phiếu trả.',
                  style: textTheme.titleMedium,
                ),
              )
            : ListView.builder(
                itemCount: loan.books.length,
                itemBuilder: (context, index) {
                  final book = loan.books[index];
                  return Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(borderRadius: radius12),
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child: Padding(
                      padding: const EdgeInsets.all(Gap.md),
                      child: Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: colorScheme.primary.withAlpha(51),
                              borderRadius: radius8,
                            ),
                            child:
                                book['imageUrl'] == null ||
                                    book['imageUrl'].toString().isEmpty
                                ? Icon(Icons.book, color: colorScheme.primary)
                                : Image.network(book['imageUrl']),
                          ),
                          Gap.sMWidth,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  book['title'],
                                  style: textTheme.titleMedium,
                                ),
                                Gap.xsHeight,
                                Text(
                                  'Số lượng: ${book['quantity'] ?? 'Không xác định'}',
                                  style: textTheme.bodyMedium?.copyWith(
                                    color: colorScheme.shadow,
                                  ),
                                ),
                                Text(
                                  'Ngày mượn: ${formatDate(loan.date)}',
                                  style: textTheme.bodyMedium?.copyWith(
                                    color: colorScheme.shadow,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
