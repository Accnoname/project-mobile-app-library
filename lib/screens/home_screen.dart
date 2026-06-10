import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:library_management_app/screens/loan_list_screen.dart';
import 'package:library_management_app/screens/loan_return_screen.dart';
import 'package:library_management_app/screens/dashboard_screen.dart';
import 'package:library_management_app/screens/setting_screen.dart';
import 'package:library_management_app/services/loan_service.dart';
import 'package:library_management_app/services/book_service.dart';
import 'book_screen.dart';

// ─── Main HomeScreen (Shell with BottomNav) ──────────────────────────────────
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
    if (index >= _screens.length) index = 2;
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
                _NavItem(icon: Icons.home_rounded,              label: 'Trang chủ', index: 0, selected: _selectedIndex, onTap: _onItemTapped),
                _NavItem(icon: Icons.menu_book_rounded,         label: 'Sách',      index: 1, selected: _selectedIndex, onTap: _onItemTapped),
                _NavItem(icon: Icons.dashboard_rounded,         label: 'Dashboard', index: 2, selected: _selectedIndex, onTap: _onItemTapped),
                _NavItem(icon: Icons.receipt_long_rounded,      label: 'Mượn',      index: 3, selected: _selectedIndex, onTap: _onItemTapped),
                _NavItem(icon: Icons.assignment_return_rounded, label: 'Trả',       index: 4, selected: _selectedIndex, onTap: _onItemTapped),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Bottom Nav Item ──────────────────────────────────────────────────────────
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
            Icon(icon, size: 22,
                color: isSelected ? color : (isDark ? const Color(0xFF6C757D) : const Color(0xFF9FA8B5))),
            const SizedBox(height: 2),
            Text(label,
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

// ─── HomeTab (Trang chủ) ─────────────────────────────────────────────────────
class HomeTab extends StatefulWidget {
  final void Function(int index) onTabSelected;
  const HomeTab({super.key, required this.onTabSelected});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int borrowCount = 0;
  int returnCount = 0;
  int bookCount   = 0;

  // Lấy tên thủ thư đang đăng nhập từ Firebase Auth
  String get _displayName {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return 'Thủ thư';
    final name = user.displayName ?? '';
    if (name.isNotEmpty) return name;
    // Dùng phần email trước @ nếu chưa có displayName
    final email = user.email ?? '';
    return email.isNotEmpty ? email.split('@').first : 'Thủ thư';
  }

  @override
  void initState() {
    super.initState();
    _fetchCounts();
  }

  Future<void> _fetchCounts() async {
    final borrows = await LoanService().getBorrowCount();
    final returns = await LoanService().getReturnCount();
    final books   = await BookService().getBooksOnce();
    if (!mounted) return;
    setState(() {
      borrowCount = borrows;
      returnCount = returns;
      bookCount   = books.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF0F1117) : const Color(0xFFF8F9FE);

    return Scaffold(
      backgroundColor: bgColor,
      body: RefreshIndicator(
        onRefresh: _fetchCounts,
        child: CustomScrollView(
          slivers: [
            // ── Header ────────────────────────────────────────────────────
            SliverAppBar(
              expandedHeight: 210,
              floating: false,
              pinned: true,
              backgroundColor: const Color(0xFF8B4513),
              automaticallyImplyLeading: false,
              actions: [
                IconButton(
                  tooltip: 'Cài đặt',
                  icon: const Icon(Icons.settings_rounded, color: Colors.white),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const SettingsScreen()),
                  ),
                ),
                const SizedBox(width: 4),
              ],
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    // Ảnh thư viện nền
                    Image.asset(
                      'assets/images/library_banner.png',
                      fit: BoxFit.cover,
                    ),
                    // Overlay gradient ấm áp
                    Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xCC5C2A0D),  // nâu đậm 80% opacity
                            Color(0xDD8B4513),  // amber brown 87%
                          ],
                        ),
                      ),
                    ),
                    // Nội dung text
                    SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 16, 72, 0),
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
                                  child: const Icon(Icons.local_library_rounded,
                                      color: Colors.white, size: 20),
                                ),
                                const SizedBox(width: 10),
                                const Text(
                                  'Quản lý Thư Viện',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                            const SizedBox(height: 14),
                            Text(
                              'Xin chào, $_displayName! 👋',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Hôm nay thư viện có gì mới?',
                              style: TextStyle(color: Colors.white70, fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // ── Thanh tìm kiếm nhanh (UC-2: Tìm kiếm sách) ──────
                    GestureDetector(
                      onTap: () => widget.onTabSelected(1),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 13),
                        decoration: BoxDecoration(
                          color: isDark
                              ? const Color(0xFF2D1A00)
                              : const Color(0xFFFFF3E0),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: isDark
                                ? const Color(0xFF6D4C41)
                                : const Color(0xFFD7CCC8),
                          ),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.search_rounded,
                                color: Color(0xFF8B4513),
                                size: 20),
                            const SizedBox(width: 10),
                            const Text(
                              'Tìm kiếm tên sách, tác giả...',
                              style: TextStyle(
                                fontSize: 13,
                                color: Color(0xFF8B4513),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // ── 3 Stat Cards (UC-2, UC-3, UC-4) ──────────────────
                    _SectionHeader(title: 'Tổng quan hôm nay'),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: _StatCard(
                            label: 'Tổng sách',
                            count: bookCount,
                            icon: Icons.menu_book_rounded,
                            color: const Color(0xFF8B4513),
                            bg: const Color(0xFF8B4513).withOpacity(0.12),
                            onTap: () => widget.onTabSelected(1),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _StatCard(
                            label: 'Phiếu mượn',
                            count: borrowCount,
                            icon: Icons.download_rounded,
                            color: const Color(0xFFD2691E),
                            bg: const Color(0xFFD2691E).withOpacity(0.12),
                            onTap: () => widget.onTabSelected(3),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _StatCard(
                            label: 'Phiếu trả',
                            count: returnCount,
                            icon: Icons.upload_rounded,
                            color: const Color(0xFF2E7D32),
                            bg: const Color(0xFF2E7D32).withOpacity(0.12),
                            onTap: () => widget.onTabSelected(4),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // ── Quick Access 4 chức năng chính ───────────────────
                    _SectionHeader(title: 'Truy cập nhanh'),
                    const SizedBox(height: 12),
                    GridView.count(
                      crossAxisCount: 4,
                      shrinkWrap: true,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      physics: const NeverScrollableScrollPhysics(),
                      childAspectRatio: 0.85,
                      children: [
                        _QuickItem(
                          icon: Icons.menu_book_rounded,
                          label: 'Quản lý\nSách',
                          color: const Color(0xFF8B4513),
                          onTap: () => widget.onTabSelected(1),
                        ),
                        _QuickItem(
                          icon: Icons.receipt_long_rounded,
                          label: 'Phiếu\nMượn',
                          color: const Color(0xFFD2691E),
                          onTap: () => widget.onTabSelected(3),
                        ),
                        _QuickItem(
                          icon: Icons.assignment_return_rounded,
                          label: 'Phiếu\nTrả',
                          color: const Color(0xFF2E7D32),
                          onTap: () => widget.onTabSelected(4),
                        ),
                        _QuickItem(
                          icon: Icons.bar_chart_rounded,
                          label: 'Thống\nkê',
                          color: const Color(0xFFB71C1C),
                          onTap: () => widget.onTabSelected(2),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // ── Hoạt động – tất cả UC đầy đủ ─────────────────────
                    _SectionHeader(title: 'Chức năng'),
                    const SizedBox(height: 12),

                    // UC-2: Quản lý Sách
                    _ActivityTile(
                      icon: Icons.menu_book_rounded,
                      iconColor: const Color(0xFF8B4513),
                      title: 'Quản lý Sách',
                      subtitle: 'Thêm, sửa, xóa thông tin sách trong thư viện',
                      badge: '$bookCount cuốn',
                      badgeColor: const Color(0xFF8B4513),
                      onTap: () => widget.onTabSelected(1),
                      isDark: isDark,
                    ),
                    const SizedBox(height: 8),

                    // UC-3: Quản lý Phiếu Mượn
                    _ActivityTile(
                      icon: Icons.receipt_long_rounded,
                      iconColor: const Color(0xFFD2691E),
                      title: 'Phiếu Mượn',
                      subtitle: 'Tạo và quản lý phiếu mượn sách cho độc giả',
                      badge: '$borrowCount phiếu',
                      badgeColor: const Color(0xFFD2691E),
                      onTap: () => widget.onTabSelected(3),
                      isDark: isDark,
                    ),
                    const SizedBox(height: 8),

                    // UC-4: Quản lý Phiếu Trả
                    _ActivityTile(
                      icon: Icons.assignment_return_rounded,
                      iconColor: const Color(0xFF2E7D32),
                      title: 'Phiếu Trả',
                      subtitle: 'Ghi nhận sách trả, cập nhật tồn kho tự động',
                      badge: '$returnCount phiếu',
                      badgeColor: const Color(0xFF2E7D32),
                      onTap: () => widget.onTabSelected(4),
                      isDark: isDark,
                    ),
                    const SizedBox(height: 8),

                    // UC-6: Thống kê
                    _ActivityTile(
                      icon: Icons.bar_chart_rounded,
                      iconColor: const Color(0xFFB71C1C),
                      title: 'Thống kê Báo cáo',
                      subtitle: 'Xem biểu đồ mượn/trả, lọc theo ngày và thể loại',
                      badge: 'Dashboard',
                      badgeColor: const Color(0xFFB71C1C),
                      onTap: () => widget.onTabSelected(2),
                      isDark: isDark,
                    ),
                    const SizedBox(height: 8),

                    // UC-5: Cài đặt tài khoản
                    _ActivityTile(
                      icon: Icons.manage_accounts_rounded,
                      iconColor: const Color(0xFFC17900),
                      title: 'Tài khoản & Cài đặt',
                      subtitle: 'Chỉnh sửa thông tin cá nhân, đổi mật khẩu, theme',
                      badge: 'Cài đặt',
                      badgeColor: const Color(0xFFC17900),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const SettingsScreen()),
                      ),
                      isDark: isDark,
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Reusable Widgets ─────────────────────────────────────────────────────────

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
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
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
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(10)),
              child: Icon(icon, color: color, size: 18),
            ),
            const SizedBox(height: 10),
            Text(
              count.toString(),
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: color),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                color: isDark ? const Color(0xFFADB5BD) : const Color(0xFF6C757D),
              ),
            ),
          ],
        ),
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
            width: 54,
            height: 54,
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
              height: 1.3,
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
  final String badge;
  final Color badgeColor;
  final VoidCallback onTap;
  final bool isDark;

  const _ActivityTile({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.badge,
    required this.badgeColor,
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
          border: Border.all(
            color: isDark ? const Color(0xFF2C3248) : const Color(0xFFE9ECEF),
          ),
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
                      color: isDark
                          ? const Color(0xFF6C757D)
                          : const Color(0xFF9FA8B5),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: badgeColor.withOpacity(0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                badge,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: badgeColor,
                ),
              ),
            ),
            const SizedBox(width: 4),
            Icon(Icons.arrow_forward_ios_rounded,
                size: 12,
                color: isDark
                    ? const Color(0xFF495057)
                    : const Color(0xFFCED4DA)),
          ],
        ),
      ),
    );
  }
}
