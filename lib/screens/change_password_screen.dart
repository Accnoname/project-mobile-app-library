import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:library_management_app/common/helpers/extentions.dart';
import 'package:library_management_app/configs/themes/common.dart';
import 'package:library_management_app/configs/themes/gap.dart';
import 'package:library_management_app/widgets/text_field_app.dart';

// doi mat khau
class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscureOld = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;
  bool _isLoading = false;

  void _toggleOld() => setState(() => _obscureOld = !_obscureOld);
  void _toggleNew() => setState(() => _obscureNew = !_obscureNew);
  void _toggleConfirm() => setState(() => _obscureConfirm = !_obscureConfirm);

  Future<void> _changePassword() async {
    if (!_formKey.currentState!.validate()) return;

    final oldPass = _oldPasswordController.text.trim();
    final newPass = _newPasswordController.text.trim();
    final confirmPass = _confirmPasswordController.text.trim();

    if (newPass != confirmPass) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Mật khẩu mới và xác nhận không khớp!')),
      );
      return;
    }

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Chưa có người dùng đăng nhập!')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Re-authenticate user với mật khẩu cũ
      final cred = EmailAuthProvider.credential(
        email: user.email!,
        password: oldPass,
      );
      await user.reauthenticateWithCredential(cred);

      // Update mật khẩu mới
      await user.updatePassword(newPass);

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Đổi mật khẩu thành công!')));

      _oldPasswordController.clear();
      _newPasswordController.clear();
      _confirmPasswordController.clear();
    } on FirebaseAuthException catch (e) {
      String message = 'Đổi mật khẩu thất bại!';
      if (e.code == 'wrong-password') {
        message = 'Mật khẩu cũ không đúng!';
      } else if (e.code == 'weak-password') {
        message = 'Mật khẩu mới quá yếu!';
      }
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Đổi mật khẩu thất bại: $e')));
    }

    setState(() {
      _isLoading = false;
    });
  }

  Widget _buildPasswordField({
    required String label,
    required TextEditingController controller,
    required bool obscureText,
    required VoidCallback toggleVisibility,
  }) {
    return TextFieldApp(
      controller: controller,
      obscureText: obscureText,
      label: Text(label),
      suffixIcon: IconButton(
        icon: Icon(obscureText ? Icons.visibility : Icons.visibility_off),
        onPressed: toggleVisibility,
      ),

      validator: (value) =>
          value == null || value.isEmpty ? 'Vui lòng nhập $label' : null,
    );
  }

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Thay đổi mật khẩu'),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onSecondary,
      ),
      body: Padding(
        padding: paddingApp,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildPasswordField(
                label: 'Mật khẩu cũ',
                controller: _oldPasswordController,
                obscureText: _obscureOld,
                toggleVisibility: _toggleOld,
              ),
              Gap.mdHeight,
              _buildPasswordField(
                label: 'Mật khẩu mới',
                controller: _newPasswordController,
                obscureText: _obscureNew,
                toggleVisibility: _toggleNew,
              ),
              Gap.mdHeight,
              _buildPasswordField(
                label: 'Xác nhận mật khẩu mới',
                controller: _confirmPasswordController,
                obscureText: _obscureConfirm,
                toggleVisibility: _toggleConfirm,
              ),
              Gap.lgHeight,
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _changePassword,
                  child: _isLoading
                      ? CircularProgressIndicator(
                          color: colorScheme.onSecondary,
                        )
                      : const Text('Cập nhật mật khẩu'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
