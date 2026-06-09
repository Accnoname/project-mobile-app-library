import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:library_management_app/models/book_model.dart';
import 'package:library_management_app/services/book_service.dart';
import 'package:library_management_app/services/cloudinary_service.dart';
import 'package:uuid/uuid.dart';

class AddBookScreen extends StatefulWidget {
  const AddBookScreen({super.key});

  @override
  State<AddBookScreen> createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
  final _formKey = GlobalKey<FormState>();
  final _picker = ImagePicker();
  final _bookService = BookService();
  final _cloudinary = CloudinaryService();

  final _titleController = TextEditingController();
  final _authorController = TextEditingController();
  final _publisherController = TextEditingController();
  final _yearController = TextEditingController();
  final _quantityController = TextEditingController();

  File? _selectedImage;
  bool _isLoading = false;

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) setState(() => _selectedImage = File(pickedFile.path));
  }

  Future<void> _uploadAndSaveBook() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);

    String? imageUrl;
    if (_selectedImage != null) {
      imageUrl = await _cloudinary.uploadImage(_selectedImage!);
    }

    final book = BookModel(
      id: const Uuid().v4(),
      title: _titleController.text.trim(),
      author: _authorController.text.trim(),
      publisher: _publisherController.text.trim(),
      year: _yearController.text.trim(),
      availableCount: int.tryParse(_quantityController.text) ?? 0,
      imageUrl: imageUrl ?? '',
    );

    try {
      await _bookService.addBook(book);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Thêm sách thành công!')),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Lỗi: $e')));
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Thêm sách mới'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
          children: [
            // ── Image picker ─────────────────────────────────────────────
            Center(
              child: GestureDetector(
                onTap: _pickImage,
                child: Stack(
                  children: [
                    Container(
                      width: 140,
                      height: 190,
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF1E2130) : const Color(0xFFF1F3F9),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isDark ? const Color(0xFF2C3248) : const Color(0xFFE9ECEF),
                          width: 2,
                        ),
                      ),
                      child: _selectedImage != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(14),
                              child: Image.file(_selectedImage!, fit: BoxFit.cover),
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.add_photo_alternate_outlined,
                                    size: 40,
                                    color: isDark ? const Color(0xFF495057) : const Color(0xFFCED4DA)),
                                const SizedBox(height: 8),
                                Text(
                                  'Thêm ảnh bìa',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: isDark ? const Color(0xFF6C757D) : const Color(0xFFADB5BD),
                                  ),
                                ),
                              ],
                            ),
                    ),
                    if (_selectedImage != null)
                      Positioned(
                        bottom: 8,
                        right: 8,
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: colorScheme.primary,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.edit_rounded, color: Colors.white, size: 14),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // ── Form fields ──────────────────────────────────────────────
            _FormField(controller: _titleController, label: 'Tên sách', icon: Icons.title_rounded),
            const SizedBox(height: 14),
            _FormField(controller: _authorController, label: 'Tác giả', icon: Icons.person_outline_rounded),
            const SizedBox(height: 14),
            _FormField(controller: _publisherController, label: 'Nhà xuất bản', icon: Icons.business_rounded),
            const SizedBox(height: 14),
            _FormField(
              controller: _yearController,
              label: 'Năm xuất bản',
              icon: Icons.calendar_today_rounded,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 14),
            _FormField(
              controller: _quantityController,
              label: 'Số lượng',
              icon: Icons.inventory_2_outlined,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 28),

            ElevatedButton(
              onPressed: _isLoading ? null : _uploadAndSaveBook,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: _isLoading
                  ? const SizedBox(
                      height: 20, width: 20,
                      child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                    )
                  : const Text('Thêm sách', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
            ),
          ],
        ),
      ),
    );
  }
}

class _FormField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final TextInputType keyboardType;

  const _FormField({
    required this.controller,
    required this.label,
    required this.icon,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      style: TextStyle(
        fontSize: 14,
        color: isDark ? Colors.white : const Color(0xFF212529),
      ),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, size: 18),
      ),
      validator: (v) => (v == null || v.isEmpty) ? 'Vui lòng nhập $label' : null,
    );
  }
}
