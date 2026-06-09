import 'package:flutter/material.dart';
import 'package:library_management_app/common/helpers/extentions.dart';
import 'package:library_management_app/configs/assets/app_images.dart';
import 'package:library_management_app/configs/themes/common.dart';
import 'package:library_management_app/configs/themes/gap.dart';
import 'package:library_management_app/screens/home_screen.dart';
import 'package:library_management_app/screens/register_screen.dart';
import 'package:library_management_app/services/auth_services.dart';
import 'package:library_management_app/services/dialog_service.dart';
import 'package:library_management_app/widgets/text_field_app.dart';

//dang nhap
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final AuthServices _authServices = AuthServices();
  final DialogService _dialogService = DialogService();

  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    final user = await _authServices.signInWithEmail(
      email: email,
      password: password,
    );

    setState(() => _isLoading = false);

    if (user != null) {
      if (context.mounted) {
        await _dialogService.showSuccessDialog(
          context,
          title: 'Đăng nhập thành công',
          message: 'Chào mừng bạn quay lại!',
        );
      }
      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      }
    } else {
      if (context.mounted) {
        await _dialogService.showErrorDialog(
          context,
          title: 'Đăng nhập thất bại',
          message: 'Email hoặc mật khẩu không đúng. Vui lòng thử lại.',
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.theme.colorScheme;
    final textTheme = context.theme.textTheme;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [colorScheme.primary, colorScheme.secondary],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: -80,
              left: -80,
              child: Container(
                width: 220,
                height: 220,
                decoration: BoxDecoration(
                  color: colorScheme.onPrimary.withOpacity(0.14),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              bottom: -90,
              right: -70,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: colorScheme.onSecondary.withOpacity(0.12),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: Gap.lg,
                  vertical: Gap.xxxl,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: Gap.xxxl),
                    Text(
                      'Xin chào!',
                      style: textTheme.displaySmall?.copyWith(
                        color: colorScheme.onPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Gap.smHeight,
                    Text(
                      'Đăng nhập để tiếp tục quản lý thư viện của bạn với giao diện trực quan và đơn giản.',
                      style: textTheme.bodyLarge?.copyWith(
                        color: colorScheme.onPrimary.withOpacity(0.88),
                      ),
                    ),
                    Gap.xxxlHeight,
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(Gap.xl),
                      decoration: BoxDecoration(
                        color: colorScheme.surface,
                        borderRadius: radius30,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 24,
                            offset: const Offset(0, 12),
                          ),
                        ],
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              height: 96,
                              width: 96,
                              decoration: BoxDecoration(
                                color: colorScheme.primary.withOpacity(0.12),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Image.asset(
                                  AppImages.user,
                                  width: 52,
                                  height: 52,
                                ),
                              ),
                            ),
                            Gap.xlHeight,
                            Text(
                              'Đăng nhập tài khoản',
                              style: textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Gap.smHeight,
                            Text(
                              'Nhập thông tin để bắt đầu quản lý mượn trả sách.',
                              style: textTheme.bodyMedium?.copyWith(
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                            Gap.xlHeight,
                            TextFieldApp(
                              label: const Text('Email'),
                              hintText: 'example@mail.com',
                              controller: _emailController,
                              textInputType: TextInputType.emailAddress,
                              prefixIcon: const Icon(Icons.email_outlined),
                              fillColor: colorScheme.surfaceVariant,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Vui lòng nhập email';
                                }
                                if (!value.contains('@')) {
                                  return 'Email không hợp lệ';
                                }
                                return null;
                              },
                            ),
                            Gap.lgHeight,
                            TextFieldApp(
                              label: const Text('Mật khẩu'),
                              hintText: '••••••••',
                              controller: _passwordController,
                              obscureText: true,
                              prefixIcon: const Icon(Icons.lock_outline),
                              fillColor: colorScheme.surfaceVariant,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Vui lòng nhập mật khẩu';
                                }
                                if (value.length < 6) {
                                  return 'Mật khẩu phải có ít nhất 6 ký tự';
                                }
                                return null;
                              },
                            ),
                            Gap.mdHeight,
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {},
                                child: const Text('Quên mật khẩu?'),
                              ),
                            ),
                            Gap.xlHeight,
                            if (_isLoading)
                              Center(
                                child: CircularProgressIndicator(
                                  color: colorScheme.primary,
                                ),
                              )
                            else
                              Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () => _handleLogin(context),
                                      style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: Gap.lg,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: radius16,
                                        ),
                                      ),
                                      child: const Text('Đăng nhập'),
                                    ),
                                  ),
                                  SizedBox(width: Gap.sm),
                                  Expanded(
                                    child: OutlinedButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const RegisterScreen(),
                                          ),
                                        );
                                      },
                                      style: OutlinedButton.styleFrom(
                                        side: BorderSide(
                                          color: colorScheme.primary,
                                          width: 1.5,
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          vertical: Gap.lg,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: radius16,
                                        ),
                                      ),
                                      child: Text(
                                        'Đăng ký',
                                        style: TextStyle(
                                          color: colorScheme.primary,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
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
}
