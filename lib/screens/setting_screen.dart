import 'package:flutter/material.dart';
import 'package:library_management_app/common/helpers/extentions.dart';
import 'package:library_management_app/configs/assets/app_images.dart';
import 'package:library_management_app/models/user_model.dart';
import 'package:library_management_app/screens/change_password_screen.dart';
import 'package:library_management_app/screens/librarian_info_screen.dart';
import 'package:library_management_app/screens/login_screen.dart';
import 'package:library_management_app/services/theme_provider.dart';
import 'package:library_management_app/services/user_services.dart';
import 'package:provider/provider.dart';

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
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cài đặt'),
        centerTitle: true,
        leading: SizedBox(),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onSecondary,
      ),
      body: _user == null
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              children: [
                Container(
                  margin: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: colorScheme.onSecondary,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      ListTile(
                        leading: CircleAvatar(
                          backgroundImage: _user!.photoUrl.isNotEmpty
                              ? NetworkImage(_user!.photoUrl)
                              : const AssetImage(AppImages.user)
                                    as ImageProvider,
                          radius: 28,
                        ),
                        title: Text(
                          _user!.name.isNotEmpty ? _user!.name : 'Người dùng',
                        ),
                        trailing: IconButton(
                          onPressed: _signOut,
                          icon: const Icon(Icons.logout),
                        ),
                      ),
                      const Divider(),
                      const Padding(
                        padding: EdgeInsets.only(left: 16, top: 10, bottom: 4),
                        child: Text(
                          'Thiết lập tài khoản',
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ListTile(
                        title: const Text('Chỉnh sửa thông tin'),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => LibrarianInfoScreen(user: _user!),
                            ),
                          );
                          _loadUser();
                        },
                      ),
                      ListTile(
                        title: const Text('Thay đổi mật khẩu'),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChangePasswordScreen(),
                            ),
                          );
                        },
                      ),
                      SwitchListTile(
                        title: const Text('Bật thông báo'),
                        value: _notification,
                        onChanged: (v) => setState(() => _notification = v),
                      ),
                      ListTile(
                        title: const Text('Giao diện (Theme)'),
                        trailing: Icon(
                          Provider.of<ThemeProvider>(context).themeMode ==
                                  ThemeMode.light
                              ? Icons.light_mode
                              : Icons.dark_mode,
                        ),
                        onTap: () {
                          Provider.of<ThemeProvider>(
                            context,
                            listen: false,
                          ).toggleTheme();
                        },
                      ),

                      const Divider(),
                      const Padding(
                        padding: EdgeInsets.only(left: 16, top: 10, bottom: 4),
                        child: Text(
                          'Thông tin thêm',
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ListTile(
                        title: const Text('Về chúng tôi'),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      ),
                      ListTile(
                        title: const Text('Chính sách bảo mật'),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
