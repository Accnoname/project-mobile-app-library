import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
      _loans = allLoans.where((l) => DateFormat('yyyy-MM-dd').format(l.date) == dateStr).toList();
    } else {
      _loans = allLoans;
    }
    setState(() => _loading = false);
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
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
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, _) => [
          SliverAppBar(
            expandedHeight: 100,
            pinned: true,
            automaticallyImplyLeading: false,
            backgroundColor: colorScheme.primary,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [colorScheme.primary, const Color(0xFF364FC7)],
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Phiếu Mượn Sách',
                          style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${_loans.length} phiếu${_selectedDate != null ? ' • ${DateFormat('dd/MM/yyyy').format(_selectedDate!)}' : ''}',
                          style: const TextStyle(color: Colors.white70, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
        body: Column(
          children: [
            // Filter bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF141520) : Colors.white,
                border: Border(bottom: BorderSide(color: isDark ? const Color(0xFF2C3248) : const Color(0xFFE9ECEF))),
              ),
              child: Row(
                children: [
                  Icon(Icons.calendar_today_rounded, size: 16,
                      color: isDark ? const Color(0xFF6C757D) : const Color(0xFF9FA8B5)),
                  const SizedBox(width: 8),
                  Text(
                    _selectedDate == null ? 'Tất cả ngày' : DateFormat('dd/MM/yyyy').format(_selectedDate!),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: isDark ? const Color(0xFFADB5BD) : const Color(0xFF495057),
                    ),
                  ),
                  const Spacer(),
                  if (_selectedDate != null)
                    GestureDetector(
                      onTap: () { setState(() => _selectedDate = null); _fetchLoans(); },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE03131).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text('Xóa lọc', style: TextStyle(fontSize: 12, color: Color(0xFFE03131), fontWeight: FontWeight.w600)),
                      ),
                    ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: _pickDate,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: colorScheme.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text('Chọn ngày', style: TextStyle(fontSize: 12, color: colorScheme.primary, fontWeight: FontWeight.w600)),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: _loading
                  ? const Center(child: CircularProgressIndicator())
                  : _loans.isEmpty
                      ? _emptyState(isDark)
                      : ListView.separated(
                          padding: const EdgeInsets.fromLTRB(16, 12, 16, 100),
                          itemCount: _loans.length,
                          separatorBuilder: (_, __) => const SizedBox(height: 8),
                          itemBuilder: (_, i) => _LoanCard(
                            loan: _loans[i],
                            index: i,
                            isDark: isDark,
                            primaryColor: colorScheme.primary,
                            onTap: () async {
                              await Navigator.push(context,
                                  MaterialPageRoute(builder: (_) => LoanDetailScreen(loan: _loans[i])));
                              _fetchLoans();
                            },
                            onDelete: () async {
                              final confirm = await _confirmDelete(context);
                              if (confirm == true) {
                                await _loanService.deleteLoan(_loans[i].id);
                                _fetchLoans();
                              }
                            },
                          ),
                        ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await Navigator.push(context, MaterialPageRoute(builder: (_) => const AddBorrowScreen()));
          _fetchLoans();
        },
        icon: const Icon(Icons.add_rounded),
        label: const Text('Thêm phiếu mượn', style: TextStyle(fontWeight: FontWeight.w600)),
        shape: RoundedRectangleBorder(borderRadius: radius100),
      ),
    );
  }

  Widget _emptyState(bool isDark) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.receipt_long_outlined, size: 64,
              color: isDark ? const Color(0xFF2C3248) : const Color(0xFFCED4DA)),
          const SizedBox(height: 12),
          Text('Không có phiếu mượn nào',
              style: TextStyle(color: isDark ? const Color(0xFF6C757D) : const Color(0xFFADB5BD))),
        ],
      ),
    );
  }

  Future<bool?> _confirmDelete(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Xác nhận xóa', style: TextStyle(fontWeight: FontWeight.w700)),
        content: const Text('Bạn có chắc muốn xóa phiếu mượn này không?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Hủy')),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Xóa', style: TextStyle(color: Color(0xFFE03131), fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }
}

class _LoanCard extends StatelessWidget {
  final LoanModel loan;
  final int index;
  final bool isDark;
  final Color primaryColor;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const _LoanCard({
    required this.loan,
    required this.index,
    required this.isDark,
    required this.primaryColor,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E2130) : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: isDark ? const Color(0xFF2C3248) : const Color(0xFFE9ECEF)),
          boxShadow: isDark ? [] : [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 2))],
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: primaryColor.withOpacity(isDark ? 0.2 : 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  '#${index + 1}',
                  style: TextStyle(color: primaryColor, fontWeight: FontWeight.w700, fontSize: 13),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Phiếu mượn số ${index + 1}',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: isDark ? Colors.white : const Color(0xFF212529),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.calendar_today_rounded, size: 12,
                          color: isDark ? const Color(0xFF6C757D) : const Color(0xFFADB5BD)),
                      const SizedBox(width: 4),
                      Text(
                        DateFormat('dd/MM/yyyy').format(loan.date),
                        style: TextStyle(
                          fontSize: 12,
                          color: isDark ? const Color(0xFF6C757D) : const Color(0xFFADB5BD),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Icon(Icons.menu_book_rounded, size: 12,
                          color: isDark ? const Color(0xFF6C757D) : const Color(0xFFADB5BD)),
                      const SizedBox(width: 4),
                      Text(
                        '${loan.totalBooks} cuốn',
                        style: TextStyle(
                          fontSize: 12,
                          color: isDark ? const Color(0xFF6C757D) : const Color(0xFFADB5BD),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.delete_outline_rounded, color: const Color(0xFFE03131).withOpacity(0.7)),
              onPressed: onDelete,
            ),
            Icon(Icons.chevron_right_rounded,
                color: isDark ? const Color(0xFF2C3248) : const Color(0xFFCED4DA)),
          ],
        ),
      ),
    );
  }
}
