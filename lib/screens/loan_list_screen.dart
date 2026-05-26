import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:library_management_app/common/helpers/extentions.dart';
import 'package:library_management_app/configs/themes/common.dart';
import 'package:library_management_app/models/loan_model.dart';
import 'package:library_management_app/screens/add_borrow_screen.dart';
import 'package:library_management_app/services/loan_service.dart';
import 'loan_detail_screen.dart';

class LoanListScreen extends StatefulWidget {
  const LoanListScreen({super.key});

  @override
  State<LoanListScreen> createState() => _LoanListScreenState();
}

class _LoanListScreenState extends State<LoanListScreen> {
  final LoanService _loanService = LoanService();
  DateTime? _selectedDate;
  List<LoanModel> _loans = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _fetchLoans();
  }

  Future<void> _fetchLoans() async {
    setState(() => _loading = true);
    final allLoans = await _loanService.getLoansOnce("borrow");

    if (_selectedDate != null) {
      final dateStr = DateFormat('yyyy-MM-dd').format(_selectedDate!);
      _loans = allLoans.where((loan) {
        final loanDate = DateFormat('yyyy-MM-dd').format(loan.date);
        return loanDate == dateStr;
      }).toList();
    } else {
      _loans = allLoans;
    }

    setState(() => _loading = false);
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? now,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
      _fetchLoans();
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.theme.colorScheme;
    final textTheme = context.theme.textTheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.primary,
        centerTitle: true,
        leading: const SizedBox(),
        title: Text(
          "Phiếu mượn",
          style: TextStyle(color: colorScheme.onSecondary),
        ),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // --- Bộ lọc ngày ---
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "Ngày",
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            _selectedDate == null
                                ? "Tất cả"
                                : DateFormat(
                                    'dd/MM/yyyy',
                                  ).format(_selectedDate!),
                            style: textTheme.titleMedium?.copyWith(
                              color: colorScheme.shadow,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.calendar_today),
                            onPressed: _pickDate,
                          ),
                          if (_selectedDate != null)
                            IconButton(
                              icon: const Icon(
                                Icons.filter_alt_off,
                                color: Colors.redAccent,
                              ),
                              onPressed: () {
                                setState(() => _selectedDate = null);
                                _fetchLoans();
                              },
                            ),
                        ],
                      ),
                    ],
                  ),
                ),

                // --- Danh sách phiếu ---
                Expanded(
                  child: _loans.isEmpty
                      ? const Center(child: Text("Không có phiếu mượn nào"))
                      : ListView.builder(
                          padding: const EdgeInsets.all(8),
                          itemCount: _loans.length,
                          itemBuilder: (_, i) {
                            final loan = _loans[i];
                            return Card(
                              child: ListTile(
                                title: Text("Phiếu mượn số ${i + 1}"),
                                subtitle: Text(
                                  "Số quyển sách: ${loan.totalBooks}",
                                ),
                                trailing: IconButton(
                                  icon: const Icon(Icons.delete_forever),
                                  onPressed: () async {
                                    final confirm = await showDialog<bool>(
                                      context: context,
                                      builder: (_) => AlertDialog(
                                        title: const Text('Xác nhận xóa'),
                                        content: const Text(
                                          'Bạn có chắc muốn xóa phiếu mượn này không?',
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context, false),
                                            child: const Text('Hủy'),
                                          ),
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context, true),
                                            child: const Text(
                                              'Xóa',
                                              style: TextStyle(
                                                color: Colors.red,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );

                                    if (confirm == true) {
                                      await _loanService.deleteLoan(loan.id);
                                      _fetchLoans();
                                    }
                                  },
                                ),
                                onTap: () async {
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          LoanDetailScreen(loan: loan),
                                    ),
                                  );
                                  _fetchLoans();
                                },
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: colorScheme.primary,
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddBorrowScreen()),
          );
          _fetchLoans();
        },
        label: Text(
          "Thêm phiếu mượn",
          style: textTheme.titleMedium?.copyWith(
            color: colorScheme.onSecondary,
          ),
        ),
        shape: RoundedRectangleBorder(borderRadius: radius100),
        icon: Icon(Icons.add, color: colorScheme.onSecondary),
      ),
    );
  }
}
