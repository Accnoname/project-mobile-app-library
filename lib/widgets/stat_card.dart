import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final String? subtitle;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E2130) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? const Color(0xFF2C3248) : const Color(0xFFE9ECEF),
        ),
        boxShadow: isDark
            ? []
            : [
                BoxShadow(
                  color: color.withOpacity(0.08),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                )
              ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              if (subtitle != null)
                Text(
                  subtitle!,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: color,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: isDark ? Colors.white : const Color(0xFF212529),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: isDark ? const Color(0xFF6C757D) : const Color(0xFF9FA8B5),
            ),
          ),
        ],
      ),
    );
  }
}

@widgetbook.UseCase(
  name: 'Primary Stat',
  type: StatCard,
)
Widget buildStatCardUseCase(BuildContext context) {
  return const Padding(
    padding: EdgeInsets.all(16.0),
    child: StatCard(
      title: 'Tổng số sách',
      value: '1,240',
      icon: Icons.menu_book_rounded,
      color: Color(0xFF3B5BDB),
      subtitle: '+12% tháng này',
    ),
  );
}

@widgetbook.UseCase(
  name: 'Warning Stat',
  type: StatCard,
)
Widget buildWarningStatUseCase(BuildContext context) {
  return const Padding(
    padding: EdgeInsets.all(16.0),
    child: StatCard(
      title: 'Sách quá hạn',
      value: '15',
      icon: Icons.warning_amber_rounded,
      color: Color(0xFFE03131),
      subtitle: 'Cần xử lý',
    ),
  );
}
