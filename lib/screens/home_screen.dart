import 'package:flutter/material.dart';
import 'package:library_management_app/common/helpers/extentions.dart';
import 'package:library_management_app/configs/themes/common.dart';
import 'package:library_management_app/configs/themes/gap.dart';
import 'package:library_management_app/screens/loan_list_screen.dart';
import 'package:library_management_app/screens/loan_return_screen.dart';
import 'package:library_management_app/screens/loan_stats_screen.dart';
import 'package:library_management_app/screens/setting_screen.dart';
import 'package:library_management_app/services/loan_service.dart';
import 'book_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int borrowCount = 0;
  int returnCount = 10;
  int _selectedIndex = 0;

  final List<Widget> _screens = [];

  @override
  void initState() {
    super.initState();
    _screens.addAll([
      HomeTab(onTabSelected: _onItemTapped),
      const BookScreen(),
      LoanStatsScreen(),
      LoanListScreen(),
      LoanReturnScreen(),
      SettingsScreen(),
    ]);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: colorScheme.primary,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Trang chủ"),
          BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: "Sách"),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: "Báo cáo",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: "Độc giả"),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: "Phiếu trả",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Cài đặt"),
        ],
      ),
    );
  }
}

/// Tab Trang chủ
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

  Widget _statCard(BuildContext context, String label, int count) {
    final textTheme = context.theme.textTheme;
    final colorScheme = context.theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: colorScheme.onSecondary),
      child: Column(
        children: [
          Text(label, style: textTheme.bodyMedium),
          Text(count.toString(), style: textTheme.bodyMedium),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox(),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onSecondary,
        title: const Text("Quản lý thư viện"),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              widget.onTabSelected(5);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thống kê mượn - trả
            IntrinsicHeight(
              child: Row(
                children: [
                  Expanded(
                    child: _statCard(context, "Lượt mượn sách", borrowCount),
                  ),
                  VerticalDivider(color: colorScheme.primary, width: 1),
                  Expanded(
                    child: _statCard(context, "Lượt trả sách", returnCount),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Danh mục yêu thích
            const Text(
              "Danh mục yêu thích",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: colorScheme.onSecondary,
                borderRadius: radius12,
              ),
              child: GridView.count(
                crossAxisCount: 4,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _menuItem(
                    context,
                    Icons.menu_book,
                    "Sách",
                    () => widget.onTabSelected(1),
                  ),
                  _menuItem(
                    context,
                    Icons.person,
                    "Độc giả",
                    () => widget.onTabSelected(3),
                  ),
                  _menuItem(
                    context,
                    Icons.bar_chart,
                    "Báo cáo",
                    () => widget.onTabSelected(2),
                  ),
                  _menuItem(context, Icons.add, "Chỉnh sửa", () {}),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Gần đây
            const Text(
              "Gần đây",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(color: Colors.grey.shade200, blurRadius: 4),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _recentItem(
                    context: context,
                    icon: Icons.menu_book,
                    label: "Sách",
                    onTap: () => widget.onTabSelected(1),
                  ),
                  _recentItem(
                    context: context,
                    icon: Icons.person,
                    label: "Độc giả",
                    onTap: () => widget.onTabSelected(3),
                  ),
                  _recentItem(
                    context: context,
                    icon: Icons.bar_chart,
                    label: "Báo cáo",
                    onTap: () => widget.onTabSelected(2),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _menuItem(
    BuildContext context,
    IconData icon,
    String label,
    VoidCallback onTap,
  ) {
    final colorScheme = context.theme.colorScheme;
    final textTheme = context.theme.textTheme;
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: colorScheme.onSecondary,
            child: Icon(icon, size: Gap.lX, color: colorScheme.onPrimary),
          ),
          const SizedBox(height: 6),
          Text(label, textAlign: TextAlign.center, style: textTheme.bodySmall),
        ],
      ),
    );
  }

  Widget _recentItem({
    required BuildContext context,
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    final colorScheme = context.theme.colorScheme;
    final textTheme = context.theme.textTheme;
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: Gap.lX, color: colorScheme.onPrimary),
          const SizedBox(height: 6),
          Text(label, style: textTheme.bodySmall),
        ],
      ),
    );
  }
}
