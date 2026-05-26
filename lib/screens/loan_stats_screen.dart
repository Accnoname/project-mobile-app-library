import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:library_management_app/common/helpers/extentions.dart';
import 'package:library_management_app/configs/themes/common.dart';
import 'package:library_management_app/configs/themes/gap.dart';
import 'package:library_management_app/models/loan_model.dart';
import 'package:library_management_app/services/loan_service.dart';
import 'package:library_management_app/services/user_services.dart';

class LoanStatsScreen extends StatefulWidget {
  const LoanStatsScreen({super.key});

  @override
  State<LoanStatsScreen> createState() => _LoanStatsScreenState();
}

class _LoanStatsScreenState extends State<LoanStatsScreen> {
  DateTime? startDate;
  DateTime? endDate;
  bool isMonthly = false;

  List<LoanModel> borrowList = [];
  List<LoanModel> returnList = [];
  bool isLoading = false;

  final dateFormat = DateFormat('dd/MM/yyyy');
  final monthFormat = DateFormat('MM/yyyy');

  Future<void> pickStartDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: startDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() => startDate = picked);
      if (endDate != null) fetchLoans();
    }
  }

  Future<void> pickEndDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: endDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() => endDate = picked);
      if (startDate != null) fetchLoans();
    }
  }

  Future<void> fetchLoans() async {
    if (startDate == null) return;
    setState(() => isLoading = true);

    try {
      final allBorrows = await LoanService().getLoansOnce('borrow');
      final allReturns = await LoanService().getLoansOnce('return');

      setState(() {
        borrowList = allBorrows.where((loan) {
          final d = loan.date;
          if (isMonthly) {
            return d.year == startDate!.year && d.month == startDate!.month;
          }
          if (endDate == null) return false;
          return d.isAfter(startDate!.subtract(const Duration(days: 1))) &&
              d.isBefore(endDate!.add(const Duration(days: 1)));
        }).toList();

        returnList = allReturns.where((loan) {
          final d = loan.date;
          if (isMonthly) {
            return d.year == startDate!.year && d.month == startDate!.month;
          }
          if (endDate == null) return false;
          return d.isAfter(startDate!.subtract(const Duration(days: 1))) &&
              d.isBefore(endDate!.add(const Duration(days: 1)));
        }).toList();
      });
    } catch (e) {
      if (kDebugMode) {
        print('Lỗi khi fetch thống kê: $e');
      }
    }

    setState(() => isLoading = false);
  }

  Widget buildLoanCard(BuildContext context, LoanModel loan, Color color) {
    final colorScheme = context.theme.colorScheme;
    final textTheme = context.theme.textTheme;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: radius12),
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(Icons.receipt, color: color, size: 30),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Mã phiếu: ${loan.id}', style: textTheme.titleMedium),
                  const SizedBox(height: 4),
                  Text(
                    'Ngày: ${dateFormat.format(loan.date)}',
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.shadow,
                    ),
                  ),
                  FutureBuilder<String>(
                    future: UserService().getUserName(loan.userId),
                    builder: (context, snapshot) {
                      final name = snapshot.data ?? 'Không rõ';
                      return Text(
                        'Người mượn: $name',
                        style: textTheme.bodyMedium?.copyWith(
                          color: colorScheme.shadow,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPieChart() {
    final total = borrowList.length + returnList.length;
    if (total == 0) {
      return const Padding(
        padding: EdgeInsets.all(20),
        child: Text('Không có dữ liệu thống kê.'),
      );
    }

    final data = [
      _ChartData('Mượn', borrowList.length.toDouble(), Colors.blue),
      _ChartData('Trả', returnList.length.toDouble(), Colors.green),
    ];

    return SfCircularChart(
      title: ChartTitle(
        text: 'Tỷ lệ Phiếu Mượn/Trả',
        textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      legend: const Legend(isVisible: true, position: LegendPosition.bottom),
      series: <CircularSeries>[
        PieSeries<_ChartData, String>(
          dataSource: data,
          xValueMapper: (_ChartData d, _) => d.label,
          yValueMapper: (_ChartData d, _) => d.value,
          pointColorMapper: (_ChartData d, _) => d.color,
          dataLabelMapper: (_ChartData d, _) =>
              '${d.label}: ${(d.value / total * 100).toStringAsFixed(1)}%',
          dataLabelSettings: const DataLabelSettings(isVisible: true),
          explode: true,
          explodeIndex: 0,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.theme.colorScheme;
    final textTheme = context.theme.textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Thống kê Phiếu Mượn/Trả'),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onSecondary,
        leading: SizedBox(),
      ),
      body: Padding(
        padding: paddingApp,
        child: Column(
          children: [
            // chọn khoảng thời gian
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: pickStartDate,
                    child: Text(
                      textAlign: TextAlign.center,
                      startDate != null
                          ? 'Từ: ${dateFormat.format(startDate!)}'
                          : 'Ngày bắt đầu',
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: pickEndDate,
                    child: Text(
                      endDate != null
                          ? 'Đến: ${dateFormat.format(endDate!)}'
                          : 'Ngày kết thúc',
                    ),
                  ),
                ),
              ],
            ),
            Gap.sMHeight,
            if (isLoading) const LinearProgressIndicator(),
            if (!isLoading && (startDate != null || endDate != null))
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildPieChart(),
                      const SizedBox(height: 20),
                      buildColumnChart(),
                      const SizedBox(height: 20),
                      Text(
                        'Phiếu mượn: ${borrowList.length}',
                        style: textTheme.titleMedium?.copyWith(
                          color: Colors.blue,
                        ),
                      ),
                      ...borrowList.map(
                        (loan) => buildLoanCard(context, loan, Colors.blue),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Phiếu trả: ${returnList.length}',
                        style: textTheme.titleMedium?.copyWith(
                          color: Colors.green,
                        ),
                      ),
                      ...returnList.map(
                        (loan) => buildLoanCard(context, loan, Colors.green),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget buildColumnChart() {
    if (borrowList.isEmpty && returnList.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(20),
        child: Text('Không có dữ liệu để vẽ biểu đồ cột.'),
      );
    }

    // Gom dữ liệu theo ngày hoặc tháng
    final Map<String, int> borrowCount = {};
    final Map<String, int> returnCount = {};

    final format = isMonthly ? monthFormat : dateFormat;

    for (var loan in borrowList) {
      final key = format.format(loan.date);
      borrowCount[key] = (borrowCount[key] ?? 0) + 1;
    }

    for (var loan in returnList) {
      final key = format.format(loan.date);
      returnCount[key] = (returnCount[key] ?? 0) + 1;
    }

    // Gộp tất cả các ngày/tháng có dữ liệu
    final allKeys = {...borrowCount.keys, ...returnCount.keys}.toList()
      ..sort((a, b) {
        try {
          final da = format.parse(a);
          final db = format.parse(b);
          return da.compareTo(db);
        } catch (_) {
          return a.compareTo(b);
        }
      });

    final chartData = allKeys.map((key) {
      return _DayChartData(key, borrowCount[key] ?? 0, returnCount[key] ?? 0);
    }).toList();

    return SfCartesianChart(
      title: ChartTitle(
        text: 'Thống kê phiếu theo ${isMonthly ? "tháng" : "ngày"}',
        textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      legend: const Legend(isVisible: true, position: LegendPosition.bottom),
      primaryXAxis: CategoryAxis(
        labelRotation: 60,
        title: AxisTitle(text: isMonthly ? 'Tháng' : 'Ngày'),
      ),
      primaryYAxis: NumericAxis(title: AxisTitle(text: 'Số lượng phiếu')),
      tooltipBehavior: TooltipBehavior(enable: true),
      series: [
        ColumnSeries<_DayChartData, String>(
          name: 'Mượn',
          dataSource: chartData,
          xValueMapper: (_DayChartData data, _) => data.label,
          yValueMapper: (_DayChartData data, _) => data.borrow,
          color: Colors.blue,
          borderRadius: const BorderRadius.all(Radius.circular(6)),
        ),
        ColumnSeries<_DayChartData, String>(
          name: 'Trả',
          dataSource: chartData,
          xValueMapper: (_DayChartData data, _) => data.label,
          yValueMapper: (_DayChartData data, _) => data.returned,
          color: Colors.green,
          borderRadius: const BorderRadius.all(Radius.circular(6)),
        ),
      ],
    );
  }
}

class _DayChartData {
  final String label;
  final int borrow;
  final int returned;

  _DayChartData(this.label, this.borrow, this.returned);
}

class _ChartData {
  final String label;
  final double value;
  final Color color;
  _ChartData(this.label, this.value, this.color);
}
