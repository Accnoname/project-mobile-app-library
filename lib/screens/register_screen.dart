import 'package:flutter/material.dart';
import 'package:library_management_app/common/helpers/extentions.dart';
import 'package:library_management_app/configs/themes/common.dart';
import 'package:library_management_app/configs/themes/gap.dart';
import 'package:library_management_app/services/auth_services.dart';
import 'package:library_management_app/services/dialog_service.dart';
import 'package:library_management_app/widgets/text_field_app.dart';

// dang ki
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();

  final AuthServices _authServices = AuthServices();
  final DialogService _dialogService = DialogService();

  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    final user = await _authServices.signUpWithEmail(
      email: email,
      password: password,
    );

    setState(() => _isLoading = false);

    if (user != null) {
      if (context.mounted) {
        await _dialogService.showSuccessDialog(
          context,
          title: 'Đăng ký thành công',
          message: 'Tài khoản đã được tạo, vui lòng đăng nhập!',
        );
        if (context.mounted) {
          Navigator.pop(context);
        }
      }
    } else {
      if (context.mounted) {
        await _dialogService.showErrorDialog(
          context,
          title: 'Đăng ký thất bại',
          message: 'Vui lòng kiểm tra lại thông tin hoặc thử lại sau.',
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
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [colorScheme.secondary, colorScheme.primary],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: -70,
              right: -70,
              child: Container(
                width: 190,
                height: 190,
                decoration: BoxDecoration(
                  color: colorScheme.onSecondary.withOpacity(0.16),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              bottom: -80,
              left: -80,
              child: Container(
                width: 220,
                height: 220,
                decoration: BoxDecoration(
                  color: colorScheme.onPrimary.withOpacity(0.12),
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
                    Text(
                      'Tạo tài khoản mới',
                      style: textTheme.displaySmall?.copyWith(
                        color: colorScheme.onPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Gap.smHeight,
                    Text(
                      'Bắt đầu hành trình quản lý thư viện nhanh chóng và an toàn.',
                      style: textTheme.bodyLarge?.copyWith(
                        color: colorScheme.onPrimary.withOpacity(0.9),
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
                              height: 90,
                              width: 90,
                              decoration: BoxDecoration(
                                color: colorScheme.primary.withOpacity(0.12),
                                shape: BoxShape.circle,
                              ),
                              child: const Center(
                                child: Icon(Icons.library_books, size: 34),
                              ),
                            ),
                            Gap.xlHeight,
                            Text(
                              'Đăng ký',
                              style: textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Gap.smHeight,
                            Text(
                              'Tạo tài khoản để quản lý danh sách sách và mượn trả dễ dàng.',
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
                              hintText: 'Nhập mật khẩu',
                              controller: _passwordController,
                              obscureText: false,
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
                            Gap.lgHeight,
                            TextFieldApp(
                              label: const Text('Nhập lại mật khẩu'),
                              hintText: 'Nhập lại mật khẩu',
                              controller: _confirmController,
                              obscureText: false,
                              prefixIcon: const Icon(Icons.lock_outline),
                              fillColor: colorScheme.surfaceVariant,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Vui lòng nhập lại mật khẩu';
                                }
                                if (value != _passwordController.text) {
                                  return 'Mật khẩu không trùng khớp';
                                }
                                return null;
                              },
                            ),
                            Gap.xxxlHeight,
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
                                    child: OutlinedButton(
                                      onPressed: () => Navigator.pop(context),
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
                                        'Đăng nhập',
                                        style: TextStyle(
                                          color: colorScheme.primary,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: Gap.sm),
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () => _handleRegister(context),
                                      style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: Gap.lg,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: radius16,
                                        ),
                                      ),
                                      child: const Text('Đăng ký'),
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
