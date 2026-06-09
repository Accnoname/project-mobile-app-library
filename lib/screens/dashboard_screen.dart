import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:library_management_app/models/loan_model.dart';
import 'package:library_management_app/screens/setting_screen.dart';
import 'package:library_management_app/services/loan_service.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  DateTime? _startDate;
  DateTime? _endDate;
  String _selectedCategory = 'Tất cả'; // Thể loại sách giả lập filter
  
  List<LoanModel> _allBorrows = [];
  List<LoanModel> _allReturns = [];
  bool _isLoading = true;

  final dateFormat = DateFormat('dd/MM/yyyy');

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    setState(() => _isLoading = true);
    try {
      _allBorrows = await LoanService().getLoansOnce('borrow');
      _allReturns = await LoanService().getLoansOnce('return');
    } catch (e) {
      debugPrint('Error fetching dashboard data: $e');
    }
    if (mounted) setState(() => _isLoading = false);
  }

  // Lọc dữ liệu theo ngày
  List<LoanModel> _getFiltered(List<LoanModel> source) {
    return source.where((loan) {
      if (_startDate != null && loan.date.isBefore(_startDate!.subtract(const Duration(days: 1)))) {
        return false;
      }
      if (_endDate != null && loan.date.isAfter(_endDate!.add(const Duration(days: 1)))) {
        return false;
      }
      // TODO: Thêm logic lọc theo loại sách nếu model Loan hỗ trợ lưu danh mục sách
      // Hiện tại ta giả lập filter category
      return true;
    }).toList();
  }

  Future<void> _pickDateRange() async {
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      initialDateRange: _startDate != null && _endDate != null 
          ? DateTimeRange(start: _startDate!, end: _endDate!) 
          : null,
    );
    if (picked != null) {
      setState(() {
        _startDate = picked.start;
        _endDate = picked.end;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final filteredBorrows = _getFiltered(_allBorrows);
    final filteredReturns = _getFiltered(_allReturns);
    
    int totalBooksBorrowed = filteredBorrows.fold(0, (sum, item) => sum + item.totalBooks);
    int totalBooksReturned = filteredReturns.fold(0, (sum, item) => sum + item.totalBooks);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // ── Header với Settings ──────────────────────────────────────────
          SliverAppBar(
            expandedHeight: 140,
            floating: false,
            pinned: true,
            automaticallyImplyLeading: false,
            backgroundColor: colorScheme.primary,
            actions: [
              IconButton(
                icon: const Icon(Icons.settings_rounded, color: Colors.white),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsScreen()));
                },
              ),
              const SizedBox(width: 8),
            ],
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
                          'Báo cáo & Thống kê',
                          style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Tổng quan tình hình thư viện',
                          style: TextStyle(color: Colors.white70, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: _isLoading 
                ? const Padding(padding: EdgeInsets.all(40), child: Center(child: CircularProgressIndicator()))
                : Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ── Bộ Lọc (Filters) ────────────────────────────────
                        Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: GestureDetector(
                                onTap: _pickDateRange,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                  decoration: BoxDecoration(
                                    color: isDark ? const Color(0xFF1E2130) : Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: isDark ? const Color(0xFF2C3248) : const Color(0xFFE9ECEF)),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(Icons.date_range_rounded, size: 16, color: colorScheme.primary),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          _startDate != null && _endDate != null
                                              ? '${dateFormat.format(_startDate!)} - ${dateFormat.format(_endDate!)}'
                                              : 'Toàn thời gian',
                                          style: TextStyle(fontSize: 12, color: isDark ? Colors.white : Colors.black87),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              flex: 2,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                                decoration: BoxDecoration(
                                  color: isDark ? const Color(0xFF1E2130) : Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: isDark ? const Color(0xFF2C3248) : const Color(0xFFE9ECEF)),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: _selectedCategory,
                                    isExpanded: true,
                                    icon: Icon(Icons.arrow_drop_down, color: colorScheme.primary),
                                    style: TextStyle(fontSize: 12, color: isDark ? Colors.white : Colors.black87),
                                    onChanged: (v) {
                                      if (v != null) setState(() => _selectedCategory = v);
                                    },
                                    items: ['Tất cả', 'Khoa học', 'Lịch sử', 'Văn học']
                                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                                        .toList(),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        if (_startDate != null)
                           Padding(
                             padding: const EdgeInsets.only(top: 8),
                             child: GestureDetector(
                               onTap: () => setState(() { _startDate = null; _endDate = null; }),
                               child: const Text('Xóa bộ lọc ngày', style: TextStyle(color: Colors.red, fontSize: 12, fontWeight: FontWeight.w600)),
                             ),
                           ),
                        const SizedBox(height: 20),

                        // ── Thẻ thống kê nhanh ─────────────────────────────
                        Row(
                          children: [
                            Expanded(child: _SummaryCard(title: 'Phiếu Mượn', count: filteredBorrows.length, icon: Icons.receipt_long_rounded, color: Colors.blue, isDark: isDark)),
                            const SizedBox(width: 12),
                            Expanded(child: _SummaryCard(title: 'Phiếu Trả', count: filteredReturns.length, icon: Icons.assignment_return_rounded, color: Colors.green, isDark: isDark)),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(child: _SummaryCard(title: 'Sách đã mượn', count: totalBooksBorrowed, icon: Icons.menu_book_rounded, color: Colors.orange, isDark: isDark)),
                            const SizedBox(width: 12),
                            Expanded(child: _SummaryCard(title: 'Sách đã trả', count: totalBooksReturned, icon: Icons.check_circle_outline_rounded, color: Colors.teal, isDark: isDark)),
                          ],
                        ),
                        const SizedBox(height: 24),

                        // ── Biểu đồ Tròn (Tỷ lệ phiếu) ─────────────────────
                        _ChartContainer(
                          title: 'Tỷ lệ Mượn / Trả',
                          isDark: isDark,
                          child: _buildPieChart(filteredBorrows.length, filteredReturns.length, isDark),
                        ),
                        const SizedBox(height: 20),

                        // ── Biểu đồ Cột (Theo ngày) ─────────────────────────
                        _ChartContainer(
                          title: 'Biến động theo thời gian',
                          isDark: isDark,
                          child: _buildColumnChart(filteredBorrows, filteredReturns, isDark),
                        ),
                        const SizedBox(height: 80),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildPieChart(int borrowCount, int returnCount, bool isDark) {
    if (borrowCount == 0 && returnCount == 0) {
      return const Center(child: Padding(padding: EdgeInsets.all(20), child: Text('Không có dữ liệu')));
    }
    final data = [
      _PieData('Mượn', borrowCount.toDouble(), Colors.blue),
      _PieData('Trả', returnCount.toDouble(), Colors.green),
    ];
    return SfCircularChart(
      legend: Legend(
        isVisible: true, 
        position: LegendPosition.bottom,
        textStyle: TextStyle(color: isDark ? Colors.white70 : Colors.black87),
      ),
      series: <CircularSeries>[
        PieSeries<_PieData, String>(
          dataSource: data,
          xValueMapper: (_PieData d, _) => d.label,
          yValueMapper: (_PieData d, _) => d.value,
          pointColorMapper: (_PieData d, _) => d.color,
          dataLabelMapper: (_PieData d, _) => '${d.value.toInt()}',
          dataLabelSettings: const DataLabelSettings(isVisible: true, textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
        )
      ],
    );
  }

  Widget _buildColumnChart(List<LoanModel> borrows, List<LoanModel> returns, bool isDark) {
    if (borrows.isEmpty && returns.isEmpty) {
      return const Center(child: Padding(padding: EdgeInsets.all(20), child: Text('Không có dữ liệu')));
    }

    final Map<String, int> bCount = {};
    final Map<String, int> rCount = {};

    for (var l in borrows) {
      final k = dateFormat.format(l.date);
      bCount[k] = (bCount[k] ?? 0) + 1;
    }
    for (var l in returns) {
      final k = dateFormat.format(l.date);
      rCount[k] = (rCount[k] ?? 0) + 1;
    }

    final keys = {...bCount.keys, ...rCount.keys}.toList()
      ..sort((a, b) => dateFormat.parse(a).compareTo(dateFormat.parse(b)));

    final chartData = keys.map((k) => _ColData(k, bCount[k] ?? 0, rCount[k] ?? 0)).toList();

    return SfCartesianChart(
      legend: Legend(isVisible: true, position: LegendPosition.bottom, textStyle: TextStyle(color: isDark ? Colors.white70 : Colors.black87)),
      primaryXAxis: CategoryAxis(
        labelRotation: 45,
        labelStyle: TextStyle(fontSize: 10, color: isDark ? Colors.white70 : Colors.black87),
      ),
      primaryYAxis: NumericAxis(
        labelStyle: TextStyle(color: isDark ? Colors.white70 : Colors.black87),
      ),
      tooltipBehavior: TooltipBehavior(enable: true),
      series: [
        ColumnSeries<_ColData, String>(
          name: 'Mượn',
          dataSource: chartData,
          xValueMapper: (_ColData d, _) => d.label,
          yValueMapper: (_ColData d, _) => d.borrow,
          color: Colors.blue,
          borderRadius: BorderRadius.circular(4),
        ),
        ColumnSeries<_ColData, String>(
          name: 'Trả',
          dataSource: chartData,
          xValueMapper: (_ColData d, _) => d.label,
          yValueMapper: (_ColData d, _) => d.returned,
          color: Colors.green,
          borderRadius: BorderRadius.circular(4),
        ),
      ],
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String title;
  final int count;
  final IconData icon;
  final Color color;
  final bool isDark;

  const _SummaryCard({required this.title, required this.count, required this.icon, required this.color, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E2130) : Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: isDark ? const Color(0xFF2C3248) : const Color(0xFFE9ECEF)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, size: 16, color: color),
              ),
              const Spacer(),
              Text(
                count.toString(),
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: isDark ? Colors.white : Colors.black87),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(title, style: TextStyle(fontSize: 12, color: isDark ? const Color(0xFFADB5BD) : const Color(0xFF6C757D))),
        ],
      ),
    );
  }
}

class _ChartContainer extends StatelessWidget {
  final String title;
  final Widget child;
  final bool isDark;

  const _ChartContainer({required this.title, required this.child, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E2130) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isDark ? const Color(0xFF2C3248) : const Color(0xFFE9ECEF)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: isDark ? Colors.white : Colors.black87)),
          const SizedBox(height: 16),
          SizedBox(height: 250, child: child),
        ],
      ),
    );
  }
}

class _PieData {
  final String label;
  final double value;
  final Color color;
  _PieData(this.label, this.value, this.color);
}
class _ColData {
  final String label;
  final int borrow;
  final int returned;
  _ColData(this.label, this.borrow, this.returned);
}
