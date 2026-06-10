import 'package:flutter/material.dart';
import 'package:library_management_app/configs/themes/common.dart';
import 'package:library_management_app/configs/themes/gap.dart';
import 'package:library_management_app/screens/home_screen.dart';
import 'package:library_management_app/services/auth_services.dart';
import 'package:library_management_app/services/dialog_service.dart';
import 'package:library_management_app/widgets/text_field_app.dart';

// màn hình đăng nhập
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController    = TextEditingController();
  final _passwordController = TextEditingController();
  final _authServices       = AuthServices();
  final _dialogService      = DialogService();
  final _formKey            = GlobalKey<FormState>();
  bool _isLoading           = false;
  bool _obscurePassword     = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);

    final user = await _authServices.signInWithEmail(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );

    setState(() => _isLoading = false);

    if (!mounted) return;

    if (user != null) {
      await _dialogService.showSuccessDialog(
        context,
        title: 'Đăng nhập thành công',
        message: 'Chào mừng bạn quay lại!',
      );
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomeScreen()),
        );
      }
    } else {
      await _dialogService.showErrorDialog(
        context,
        title: 'Đăng nhập thất bại',
        message: 'Email hoặc mật khẩu không đúng. Vui lòng thử lại.',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // ── Ảnh nền thư viện ──────────────────────────────────────────
          Image.asset(
            'assets/images/library_banner.png',
            fit: BoxFit.cover,
          ),
          // ── Overlay tối dịu ───────────────────────────────────────────
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xAA3E1A00), // nâu đậm nửa trong suốt
                  Color(0xF55C2A0D), // nâu đặc ở đáy
                ],
              ),
            ),
          ),
          // ── Nội dung ──────────────────────────────────────────────────
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 48),

                  // Logo icon
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: Colors.white30, width: 1.5),
                    ),
                    child: const Icon(
                      Icons.local_library_rounded,
                      color: Colors.white,
                      size: 34,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Title
                  const Text(
                    'Thư viện\nQuản lý Sách',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 34,
                      fontWeight: FontWeight.w800,
                      height: 1.15,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Đăng nhập để bắt đầu quản lý thư viện của bạn.',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),

                  const SizedBox(height: 36),

                  // ── Form card ─────────────────────────────────────────
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF8F0), // warm cream
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          blurRadius: 32,
                          offset: const Offset(0, 16),
                        ),
                      ],
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Tiêu đề form
                          const Text(
                            'Đăng nhập',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF3E2723),
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Nhập thông tin tài khoản thủ thư',
                            style: TextStyle(
                              fontSize: 13,
                              color: Color(0xFF6D4C41),
                            ),
                          ),
                          const SizedBox(height: 24),

                          // Email field
                          TextFieldApp(
                            label: const Text('Email'),
                            hintText: 'example@mail.com',
                            controller: _emailController,
                            textInputType: TextInputType.emailAddress,
                            prefixIcon: const Icon(Icons.email_outlined,
                                color: Color(0xFF8B4513)),
                            fillColor: const Color(0xFFF5E6D3),
                            validator: (v) {
                              if (v == null || v.isEmpty) return 'Vui lòng nhập email';
                              if (!v.contains('@')) return 'Email không hợp lệ';
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),

                          // Password field
                          TextFieldApp(
                            label: const Text('Mật khẩu'),
                            hintText: 'Nhập mật khẩu',
                            controller: _passwordController,
                            obscureText: _obscurePassword,
                            prefixIcon: const Icon(Icons.lock_outline,
                                color: Color(0xFF8B4513)),
                            fillColor: const Color(0xFFF5E6D3),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                color: const Color(0xFF8B4513),
                                size: 20,
                              ),
                              onPressed: () =>
                                  setState(() => _obscurePassword = !_obscurePassword),
                            ),
                            validator: (v) {
                              if (v == null || v.isEmpty) return 'Vui lòng nhập mật khẩu';
                              if (v.length < 6) return 'Mật khẩu phải có ít nhất 6 ký tự';
                              return null;
                            },
                          ),

                          // Quên mật khẩu
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                foregroundColor: const Color(0xFF8B4513),
                              ),
                              child: const Text('Quên mật khẩu?',
                                  style: TextStyle(fontSize: 13)),
                            ),
                          ),
                          const SizedBox(height: 8),

                          // Nút đăng nhập (chỉ 1 nút)
                          if (_isLoading)
                            const Center(
                              child: CircularProgressIndicator(
                                  color: Color(0xFF8B4513)),
                            )
                          else
                            SizedBox(
                              height: 52,
                              child: ElevatedButton.icon(
                                onPressed: _handleLogin,
                                icon: const Icon(Icons.login_rounded,
                                    color: Colors.white),
                                label: const Text(
                                  'Đăng nhập',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF8B4513),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: radius16),
                                  elevation: 2,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Footer
                  Center(
                    child: Text(
                      '© Hệ thống Quản lý Thư viện – Đại học Phenikaa',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.55),
                        fontSize: 11,
                      ),
                      textAlign: TextAlign.center,
                    ),
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
