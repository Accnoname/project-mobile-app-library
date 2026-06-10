import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:library_management_app/common/helpers/extentions.dart';
import 'package:library_management_app/configs/assets/app_images.dart';
import 'package:library_management_app/configs/themes/common.dart';
import 'package:library_management_app/configs/themes/gap.dart';
import 'package:library_management_app/models/user_model.dart';
import 'package:library_management_app/services/cloudinary_service.dart';
import 'package:library_management_app/services/user_services.dart';
import 'package:library_management_app/widgets/text_field_app.dart';

// cai dat thong tin thu thu
class LibrarianInfoScreen extends StatefulWidget {
  final AppUser user;
  const LibrarianInfoScreen({super.key, required this.user});

  @override
  State<LibrarianInfoScreen> createState() => _LibrarianInfoScreenState();
}

class _LibrarianInfoScreenState extends State<LibrarianInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  final UserService _userService = UserService();

  final CloudinaryService _cloudinaryService = CloudinaryService();
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;

  late TextEditingController _nameCtrl;
  late TextEditingController _birthdayCtrl;
  late TextEditingController _genderCtrl;
  late TextEditingController _emailCtrl;

  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController(text: widget.user.name);
    _birthdayCtrl = TextEditingController(text: widget.user.birthday);
    _genderCtrl = TextEditingController(text: widget.user.gender);
    _emailCtrl = TextEditingController(text: widget.user.email);
  }

  Future<void> _pickAndUploadAvatar() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile == null) return;

      setState(() {
        _selectedImage = File(pickedFile.path);
        _loading = true;
      });

      final url = await _cloudinaryService.uploadImage(_selectedImage!);
      if (url != null) {
        widget.user.photoUrl = url;
        await _userService.updateUser(widget.user);
        setState(() {});
      }
    } catch (e) {
      print('Lỗi chọn ảnh: $e');
    } finally {
      setState(() => _loading = false);
    }
  }

  Future<void> _saveInfo() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _loading = true);
    widget.user.name = _nameCtrl.text.trim();
    widget.user.birthday = _birthdayCtrl.text.trim();
    widget.user.gender = _genderCtrl.text.trim();
    widget.user.email = _emailCtrl.text.trim();

    await _userService.updateUser(widget.user);
    setState(() => _loading = false);
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_rounded, color: colorScheme.onSecondary),
        ),
        backgroundColor: colorScheme.primary,
        title: Text(
          'THÔNG TIN THỦ THƯ',
          style: TextStyle(color: colorScheme.onSecondary),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: colorScheme.primary,
        child: Container(
          margin: EdgeInsets.all(Gap.sM),
          padding: EdgeInsets.all(Gap.sM),
          decoration: BoxDecoration(
            borderRadius: radius25,
            color: colorScheme.onSecondary,
          ),
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Center(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: _loading ? null : _pickAndUploadAvatar,
                      child: CircleAvatar(
                        radius: 40,
                        backgroundImage: _selectedImage != null
                            ? FileImage(_selectedImage!)
                            : (widget.user.photoUrl.isNotEmpty
                                  ? NetworkImage(widget.user.photoUrl)
                                  : const AssetImage(AppImages.user)
                                        as ImageProvider),
                      ),
                    ),

                    const SizedBox(height: 8),
                    Text(
                      widget.user.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFieldApp(
                      controller: _nameCtrl,
                      label: Text('Họ và tên'),
                      validator: (v) =>
                          v!.isEmpty ? 'Vui lòng nhập họ tên' : null,
                    ),
                    Gap.mdHeight,
                    TextFieldApp(
                      controller: _birthdayCtrl,
                      label: Text('Ngày sinh'),
                    ),
                    Gap.mdHeight,
                    TextFieldApp(
                      controller: _genderCtrl,
                      label: Text('Giới tính'),
                    ),
                    Gap.mdHeight,
                    TextFieldApp(
                      controller: _emailCtrl,
                      label: Text('Email'),
                      readOnly: true,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _loading ? null : _saveInfo,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF5AA9E6),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 14,
                          horizontal: 40,
                        ),
                      ),
                      child: _loading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                              'Lưu',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
