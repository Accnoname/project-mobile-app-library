import 'package:flutter/material.dart';
import 'package:library_management_app/common/helpers/extentions.dart';
import 'package:library_management_app/configs/themes/common.dart';
import 'package:library_management_app/configs/themes/gap.dart';
import 'package:library_management_app/models/loan_model.dart';
import 'package:library_management_app/services/loan_service.dart';
import 'package:intl/intl.dart';
import 'package:library_management_app/services/user_services.dart';

class AddReturnScreen extends StatefulWidget {
  const AddReturnScreen({super.key});

  @override
  State<AddReturnScreen> createState() => _AddReturnScreenState();
}

class _AddReturnScreenState extends State<AddReturnScreen> {
  List<LoanModel> borrowList = [];
  LoanModel? selectedLoan;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchBorrowList();
  }

  Future<void> fetchBorrowList() async {
    try {
      final loans = await LoanService().getLoansOnce('borrow');
      setState(() {
        borrowList = loans;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> confirmReturn() async {
    if (selectedLoan != null) {
      try {
        await LoanService().updateLoanType(selectedLoan!.id, 'return');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Phiếu mượn đã được trả!')),
        );
        Navigator.pop(context, true);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Có lỗi xảy ra, thử lại!')),
        );
      }
    }
  }

  String formatDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.theme.colorScheme;
    final textTheme = context.theme.textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Thêm Phiếu Trả'),
        foregroundColor: colorScheme.onSecondary,
        backgroundColor: colorScheme.primary,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : borrowList.isEmpty
          ? Center(
              child: Text(
                'Không có phiếu mượn nào cần trả.',
                style: textTheme.titleMedium,
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: borrowList.length,
                    itemBuilder: (context, index) {
                      final loan = borrowList[index];
                      final isSelected = selectedLoan == loan;

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedLoan = loan;
                          });
                        },
                        child: Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: radius12,
                          ),
                          color: isSelected
                              ? colorScheme.primary.withAlpha(200)
                              : colorScheme.onSecondary,
                          margin: const EdgeInsets.symmetric(
                            vertical: 6,
                            horizontal: 4,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(Gap.md),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Mã phiếu: ${loan.id}',
                                        style: textTheme.titleMedium,
                                      ),
                                      const SizedBox(height: 6),
                                      FutureBuilder<String>(
                                        future: UserService().getUserName(
                                          loan.userId,
                                        ),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return const Text('Đang tải...');
                                          }
                                          final userName =
                                              snapshot.data ?? 'Không rõ';
                                          return Text(
                                            'Người mượn: $userName',
                                            style: textTheme.titleSmall,
                                          );
                                        },
                                      ),
                                      Gap.xsHeight,
                                      Text(
                                        'Ngày mượn: ${formatDate(loan.date)}',
                                        style: textTheme.bodySmall?.copyWith(
                                          color: !isSelected
                                              ? colorScheme.primary
                                              : colorScheme.onSecondary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorScheme.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: selectedLoan == null ? null : confirmReturn,
                      child: Text('Xác nhận trả'),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
