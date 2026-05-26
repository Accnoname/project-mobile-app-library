import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:library_management_app/configs/themes/common.dart';
import 'package:library_management_app/models/loan_model.dart';
import 'package:library_management_app/screens/return_detail_screen.dart';
import 'package:library_management_app/services/loan_service.dart';
import 'package:library_management_app/services/user_services.dart';
import 'add_return_screen.dart';

class LoanReturnScreen extends StatefulWidget {
  const LoanReturnScreen({super.key});

  @override
  State<LoanReturnScreen> createState() => _LoanReturnScreenState();
}

class _LoanReturnScreenState extends State<LoanReturnScreen> {
  final LoanService _loanService = LoanService();

  DateTime? _selectedDate;
  List<LoanModel> _returns = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _fetchReturns();
  }

  Future<void> _fetchReturns() async {
    setState(() => _loading = true);
    final allReturns = await _loanService.getLoansOnce(
      "return",
    ); // chỉ lấy phiếu trả

    if (_selectedDate != null) {
      final dateStr = DateFormat('yyyy-MM-dd').format(_selectedDate!);
      _returns = allReturns.where((loan) {
        final loanDate = DateFormat('yyyy-MM-dd').format(loan.date);
        return loanDate == dateStr;
      }).toList();
    } else {
      _returns = allReturns;
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
      _fetchReturns();
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onSecondary,
        centerTitle: true,
        leading: const SizedBox(),
        title: Text("Phiếu trả sách"),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            style: textTheme.titleMedium,
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
                                _fetchReturns();
                              },
                            ),
                        ],
                      ),
                    ],
                  ),
                ),

                // --- Danh sách phiếu trả ---
                Expanded(
                  child: _returns.isEmpty
                      ? const Center(child: Text("Không có phiếu trả nào"))
                      : ListView.builder(
                          padding: const EdgeInsets.all(8),
                          itemCount: _returns.length,
                          itemBuilder: (_, i) {
                            final loan = _returns[i];
                            return Card(
                              child: ListTile(
                                title: Text("Phiếu số ${i + 1}"),
                                subtitle: FutureBuilder<String>(
                                  future: UserService().getUserName(
                                    loan.userId,
                                  ),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Text('Đang tải...');
                                    }
                                    final userName =
                                        snapshot.data ?? 'Không rõ';
                                    return Text(userName);
                                  },
                                ),
                                trailing: IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  onPressed: () async {
                                    final confirm = await showDialog<bool>(
                                      context: context,
                                      builder: (_) => AlertDialog(
                                        title: const Text('Xác nhận xóa'),
                                        content: const Text(
                                          'Bạn có chắc muốn xóa phiếu trả này không?',
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
                                      _fetchReturns();
                                    }
                                  },
                                ),
                                onTap: () async {
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          ReturnDetailScreen(loan: loan),
                                    ),
                                  );
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
        foregroundColor: colorScheme.onSecondary,
        shape: RoundedRectangleBorder(borderRadius: radius100),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddReturnScreen()),
          );
          _fetchReturns();
        },
        label: Text("Thêm phiếu trả sách"),
        icon: Icon(Icons.add),
      ),
    );
  }
}
