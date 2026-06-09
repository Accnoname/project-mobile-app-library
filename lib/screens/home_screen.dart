import 'package:flutter/material.dart';
import 'package:library_management_app/common/helpers/extentions.dart';
import 'package:library_management_app/screens/loan_list_screen.dart';
import 'package:library_management_app/screens/loan_return_screen.dart';
import 'package:library_management_app/screens/dashboard_screen.dart';
import 'package:library_management_app/screens/setting_screen.dart';
import 'package:library_management_app/services/loan_service.dart';
import 'book_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [];

  @override
  void initState() {
    super.initState();
    _screens.addAll([
      HomeTab(onTabSelected: _onItemTapped),
      const BookScreen(),
      const DashboardScreen(),
      const LoanListScreen(),
      const LoanReturnScreen(),
    ]);
  }

  void _onItemTapped(int index) {
    // Nếu index vượt quá màn hình (do Quick Access gọi Setting, chuyển về Dashboard 2)
    if (index >= _screens.length) {
      index = 2; // Default to dashboard where settings live
    }
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF141520) : Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isDark ? 0.4 : 0.08),
              blurRadius: 20,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _NavItem(icon: Icons.home_rounded, label: 'Trang chủ', index: 0, selected: _selectedIndex, onTap: _onItemTapped),
                _NavItem(icon: Icons.menu_book_rounded, label: 'Sách', index: 1, selected: _selectedIndex, onTap: _onItemTapped),
                _NavItem(icon: Icons.dashboard_rounded, label: 'Dashboard', index: 2, selected: _selectedIndex, onTap: _onItemTapped),
                _NavItem(icon: Icons.receipt_long_rounded, label: 'Mượn', index: 3, selected: _selectedIndex, onTap: _onItemTapped),
                _NavItem(icon: Icons.assignment_return_rounded, label: 'Trả', index: 4, selected: _selectedIndex, onTap: _onItemTapped),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final int index;
  final int selected;
  final void Function(int) onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.index,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = index == selected;
    final color = Theme.of(context).colorScheme.primary;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () => onTap(index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.12) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 22,
              color: isSelected ? color : (isDark ? const Color(0xFF6C757D) : const Color(0xFF9FA8B5)),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
                color: isSelected ? color : (isDark ? const Color(0xFF6C757D) : const Color(0xFF9FA8B5)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── HomeTab Dashboard ────────────────────────────────────────────────────────
class HomeTab extends StatefulWidget {
  final void Function(int index) onTabSelected;
  const HomeTab({super.key, required this.onTabSelected});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int borrowCount = 0;
  int returnCount = 0;

  @override
  void initState() {
    super.initState();
    fetchCounts();
  }

  void fetchCounts() async {
    int borrows = await LoanService().getBorrowCount();
    int returns = await LoanService().getReturnCount();
    setState(() {
      borrowCount = borrows;
      returnCount = returns;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF0F1117) : const Color(0xFFF8F9FE);

    return Scaffold(
      backgroundColor: bgColor,
      body: CustomScrollView(
        slivers: [
          // ── Header SliverAppBar ──────────────────────────────────────────
          SliverAppBar(
            expandedHeight: 160,
            floating: false,
            pinned: true,
            backgroundColor: colorScheme.primary,
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                icon: const Icon(Icons.settings_rounded, color: Colors.white),
                onPressed: () {
                  Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (_) => const SettingsScreen())
                  );
                },
              ),
              const SizedBox(width: 4),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      colorScheme.primary,
                      const Color(0xFF364FC7),
                    ],
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(Icons.local_library_rounded, color: Colors.white, size: 20),
                            ),
                            const SizedBox(width: 10),
                            const Text(
                              'Quản lý Thư Viện',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Xin chào, Thủ thư! 👋',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const Text(
                          'Hôm nay thư viện có gì mới?',
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
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Stat Cards ─────────────────────────────────────────
                  Row(
                    children: [
                      Expanded(
                        child: _StatCard(
                          label: 'Lượt mượn',
                          count: borrowCount,
                          icon: Icons.download_rounded,
                          color: colorScheme.primary,
                          bg: colorScheme.primary.withOpacity(0.1),
                          onTap: () => widget.onTabSelected(3),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _StatCard(
                          label: 'Lượt trả',
                          count: returnCount,
                          icon: Icons.upload_rounded,
                          color: const Color(0xFF0CA678),
                          bg: const Color(0xFF0CA678).withOpacity(0.1),
                          onTap: () => widget.onTabSelected(4),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // ── Quick Access ─────────────────────────────────────
                  _SectionHeader(title: 'Truy cập nhanh'),
                  const SizedBox(height: 12),
                  GridView.count(
                    crossAxisCount: 4,
                    shrinkWrap: true,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    physics: const NeverScrollableScrollPhysics(),
                    childAspectRatio: 0.9,
                    children: [
                      _QuickItem(
                        icon: Icons.menu_book_rounded,
                        label: 'Sách',
                        color: colorScheme.primary,
                        onTap: () => widget.onTabSelected(1),
                      ),
                      _QuickItem(
                        icon: Icons.receipt_long_rounded,
                        label: 'Phiếu mượn',
                        color: const Color(0xFFF59F00),
                        onTap: () => widget.onTabSelected(3),
                      ),
                      _QuickItem(
                        icon: Icons.assignment_return_rounded,
                        label: 'Phiếu trả',
                        color: const Color(0xFF0CA678),
                        onTap: () => widget.onTabSelected(4),
                      ),
                      _QuickItem(
                        icon: Icons.bar_chart_rounded,
                        label: 'Báo cáo',
                        color: const Color(0xFFE03131),
                        onTap: () => widget.onTabSelected(2),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // ── Activity Shortcuts ─────────────────────────────────
                  _SectionHeader(title: 'Hoạt động'),
                  const SizedBox(height: 12),
                  _ActivityTile(
                    icon: Icons.menu_book_rounded,
                    iconColor: colorScheme.primary,
                    title: 'Quản lý sách',
                    subtitle: 'Thêm, sửa, xóa sách trong thư viện',
                    onTap: () => widget.onTabSelected(1),
                    isDark: isDark,
                  ),
                  const SizedBox(height: 8),
                  _ActivityTile(
                    icon: Icons.receipt_long_rounded,
                    iconColor: const Color(0xFFF59F00),
                    title: 'Phiếu mượn',
                    subtitle: 'Tạo và quản lý phiếu mượn sách',
                    onTap: () => widget.onTabSelected(3),
                    isDark: isDark,
                  ),
                  const SizedBox(height: 8),
                  _ActivityTile(
                    icon: Icons.bar_chart_rounded,
                    iconColor: const Color(0xFF0CA678),
                    title: 'Thống kê báo cáo',
                    subtitle: 'Xem biểu đồ mượn/trả theo thời gian',
                    onTap: () => widget.onTabSelected(2),
                    isDark: isDark,
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Widgets ─────────────────────────────────────────────────────────────────

class _StatCard extends StatelessWidget {
  final String label;
  final int count;
  final IconData icon;
  final Color color;
  final Color bg;
  final VoidCallback onTap;

  const _StatCard({
    required this.label,
    required this.count,
    required this.icon,
    required this.color,
    required this.bg,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E2130) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isDark ? const Color(0xFF2C3248) : const Color(0xFFE9ECEF),
          ),
          boxShadow: isDark
              ? []
              : [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 2))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(10)),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(height: 12),
            Text(
              count.toString(),
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: color),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: isDark ? const Color(0xFFADB5BD) : const Color(0xFF6C757D),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: Theme.of(context).colorScheme.onSurface,
      ),
    );
  }
}

class _QuickItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _QuickItem({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: color.withOpacity(isDark ? 0.2 : 0.1),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            textAlign: TextAlign.center,
            maxLines: 2,
            style: TextStyle(
              fontSize: 10.5,
              fontWeight: FontWeight.w500,
              color: isDark ? const Color(0xFFADB5BD) : const Color(0xFF495057),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActivityTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final bool isDark;

  const _ActivityTile({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.onTap,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E2130) : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: isDark ? const Color(0xFF2C3248) : const Color(0xFFE9ECEF)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: iconColor.withOpacity(isDark ? 0.2 : 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: iconColor, size: 20),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: isDark ? Colors.white : const Color(0xFF212529),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark ? const Color(0xFF6C757D) : const Color(0xFF9FA8B5),
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios_rounded, size: 14,
                color: isDark ? const Color(0xFF495057) : const Color(0xFFCED4DA)),
          ],
        ),
      ),
    );
  }
}
