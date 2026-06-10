import 'package:flutter/material.dart';
import 'package:library_management_app/common/helpers/extentions.dart';
import 'package:library_management_app/configs/assets/app_images.dart';
import 'package:library_management_app/models/user_model.dart';
import 'package:library_management_app/screens/change_password_screen.dart';
import 'package:library_management_app/screens/design_system_screen.dart';
import 'package:library_management_app/screens/librarian_info_screen.dart';
import 'package:library_management_app/screens/login_screen.dart';
import 'package:library_management_app/services/theme_provider.dart';
import 'package:library_management_app/services/user_services.dart';
import 'package:provider/provider.dart';

// cai dat thong tin nguoi dung
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final UserService _userService = UserService();
  AppUser? _user;
  bool _notification = true;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final data = await _userService.getCurrentUser();
    setState(() => _user = data);
  }

  void _signOut() async {
    await _userService.signOut();
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isLight = themeProvider.themeMode == ThemeMode.light;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
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
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Cài Đặt',
                          style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 20),
                        if (_user != null)
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.white.withOpacity(0.2),
                                backgroundImage: _user!.photoUrl.isNotEmpty
                                    ? NetworkImage(_user!.photoUrl)
                                    : const AssetImage(AppImages.user) as ImageProvider,
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _user!.name.isNotEmpty ? _user!.name : 'Thủ thư',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      _user!.email,
                                      style: const TextStyle(color: Colors.white70, fontSize: 13),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                onPressed: _signOut,
                                icon: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Icon(Icons.logout_rounded, color: Colors.white, size: 18),
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: _user == null
                ? const Center(child: Padding(padding: EdgeInsets.all(40), child: CircularProgressIndicator()))
                : Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        // ── Account section ─────────────────────────────
                        _SectionLabel(title: 'Tài khoản', isDark: isDark),
                        const SizedBox(height: 8),
                        _SettingsCard(
                          isDark: isDark,
                          children: [
                            _SettingsTile(
                              icon: Icons.person_outline_rounded,
                              iconColor: colorScheme.primary,
                              title: 'Chỉnh sửa thông tin',
                              isDark: isDark,
                              onTap: () async {
                                await Navigator.push(context,
                                    MaterialPageRoute(builder: (_) => LibrarianInfoScreen(user: _user!)));
                                _loadUser();
                              },
                            ),
                            _Divider(isDark: isDark),
                            _SettingsTile(
                              icon: Icons.lock_outline_rounded,
                              iconColor: const Color(0xFFF59F00),
                              title: 'Thay đổi mật khẩu',
                              isDark: isDark,
                              onTap: () => Navigator.push(context,
                                  MaterialPageRoute(builder: (_) => ChangePasswordScreen())),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // ── Preferences section ──────────────────────────
                        _SectionLabel(title: 'Tuỳ chỉnh', isDark: isDark),
                        const SizedBox(height: 8),
                        _SettingsCard(
                          isDark: isDark,
                          children: [
                            _SettingsSwitchTile(
                              icon: Icons.notifications_outlined,
                              iconColor: const Color(0xFF0CA678),
                              title: 'Thông báo',
                              value: _notification,
                              isDark: isDark,
                              onChanged: (v) => setState(() => _notification = v),
                            ),
                            _Divider(isDark: isDark),
                            _SettingsTile(
                              icon: isLight ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                              iconColor: isLight ? const Color(0xFFF59F00) : const Color(0xFF748FFC),
                              title: isLight ? 'Chế độ sáng (Light)' : 'Chế độ tối (Dark)',
                              trailing: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: colorScheme.primary.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  isLight ? 'BẬT' : 'TẮT',
                                  style: TextStyle(
                                    color: colorScheme.primary,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 11,
                                  ),
                                ),
                              ),
                              isDark: isDark,
                              onTap: () => themeProvider.toggleTheme(),
                            ),
                            _Divider(isDark: isDark),
                            _SettingsTile(
                              icon: Icons.palette_outlined,
                              iconColor: const Color(0xFF7048E8),
                              title: 'Design System (Figma-like)',
                              isDark: isDark,
                              onTap: () => Navigator.push(context,
                                  MaterialPageRoute(builder: (_) => const DesignSystemScreen())),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // ── About section ────────────────────────────────
                        _SectionLabel(title: 'Thông tin thêm', isDark: isDark),
                        const SizedBox(height: 8),
                        _SettingsCard(
                          isDark: isDark,
                          children: [
                            _SettingsTile(
                              icon: Icons.info_outline_rounded,
                              iconColor: const Color(0xFF748FFC),
                              title: 'Về chúng tôi',
                              isDark: isDark,
                              onTap: () {},
                            ),
                            _Divider(isDark: isDark),
                            _SettingsTile(
                              icon: Icons.privacy_tip_outlined,
                              iconColor: const Color(0xFF9FA8B5),
                              title: 'Chính sách bảo mật',
                              isDark: isDark,
                              onTap: () {},
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),

                        // ── Sign out button ──────────────────────────────
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton.icon(
                            onPressed: _signOut,
                            icon: const Icon(Icons.logout_rounded, size: 18),
                            label: const Text('Đăng xuất'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: const Color(0xFFE03131),
                              side: const BorderSide(color: Color(0xFFE03131), width: 1.5),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}


// ── Sub-widgets ───────────────────────────────────────────────────────────────

class _SectionLabel extends StatelessWidget {
  final String title;
  final bool isDark;
  const _SectionLabel({required this.title, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.8,
          color: isDark ? const Color(0xFF6C757D) : const Color(0xFF9FA8B5),
        ),
      ),
    );
  }
}

class _SettingsCard extends StatelessWidget {
  final bool isDark;
  final List<Widget> children;
  const _SettingsCard({required this.isDark, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E2130) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isDark ? const Color(0xFF2C3248) : const Color(0xFFE9ECEF)),
      ),
      child: Column(children: children),
    );
  }
}

class _Divider extends StatelessWidget {
  final bool isDark;
  const _Divider({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      indent: 56,
      color: isDark ? const Color(0xFF2C3248) : const Color(0xFFE9ECEF),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final bool isDark;
  final VoidCallback? onTap;
  final Widget? trailing;

  const _SettingsTile({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.isDark,
    this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      leading: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: iconColor.withOpacity(isDark ? 0.2 : 0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: iconColor, size: 18),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 14,
          color: isDark ? Colors.white : const Color(0xFF212529),
        ),
      ),
      trailing: trailing ??
          Icon(Icons.arrow_forward_ios_rounded,
              size: 14,
              color: isDark ? const Color(0xFF495057) : const Color(0xFFCED4DA)),
    );
  }
}

class _SettingsSwitchTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final bool value;
  final bool isDark;
  final ValueChanged<bool> onChanged;

  const _SettingsSwitchTile({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.value,
    required this.isDark,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      leading: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: iconColor.withOpacity(isDark ? 0.2 : 0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: iconColor, size: 18),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 14,
          color: isDark ? Colors.white : const Color(0xFF212529),
        ),
      ),
      trailing: Switch(value: value, onChanged: onChanged),
    );
  }
}
