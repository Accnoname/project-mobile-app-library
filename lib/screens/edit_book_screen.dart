import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:library_management_app/models/book_model.dart';
import 'package:library_management_app/services/book_service.dart';
import 'package:library_management_app/services/cloudinary_service.dart';

class EditBookScreen extends StatefulWidget {
  final BookModel book;
  const EditBookScreen({super.key, required this.book});

  @override
  State<EditBookScreen> createState() => _EditBookScreenState();
}

class _EditBookScreenState extends State<EditBookScreen> {
  final _formKey = GlobalKey<FormState>();
  final _picker = ImagePicker();
  final _bookService = BookService();
  final _cloudinary = CloudinaryService();

  late TextEditingController _titleController;
  late TextEditingController _authorController;
  late TextEditingController _publisherController;
  late TextEditingController _yearController;
  late TextEditingController _quantityController;

  File? _selectedImage;
  String? _imageUrl;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _imageUrl = widget.book.imageUrl;
    _titleController = TextEditingController(text: widget.book.title);
    _authorController = TextEditingController(text: widget.book.author);
    _publisherController = TextEditingController(text: widget.book.publisher);
    _yearController = TextEditingController(text: widget.book.year);
    _quantityController = TextEditingController(text: widget.book.availableCount.toString());
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) setState(() => _selectedImage = File(pickedFile.path));
  }

  Future<void> _updateBook() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);

    String imageUrl = _imageUrl ?? '';
    if (_selectedImage != null) {
      final uploaded = await _cloudinary.uploadImage(_selectedImage!);
      if (uploaded != null) imageUrl = uploaded;
    }

    final updatedBook = BookModel(
      id: widget.book.id,
      title: _titleController.text.trim(),
      author: _authorController.text.trim(),
      publisher: _publisherController.text.trim(),
      year: _yearController.text.trim(),
      availableCount: int.tryParse(_quantityController.text) ?? 0,
      imageUrl: imageUrl,
    );

    try {
      await _bookService.updateBook(updatedBook);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Cập nhật thành công!')),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Lỗi: $e')));
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _deleteBook() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Xóa sách', style: TextStyle(fontWeight: FontWeight.w700)),
        content: const Text('Bạn có chắc muốn xóa cuốn sách này không?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Hủy')),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Xóa', style: TextStyle(color: Color(0xFFE03131), fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
    if (confirm == true) {
      await _bookService.deleteBook(widget.book.id);
      if (mounted) Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cập nhật sách'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline_rounded),
            onPressed: _deleteBook,
            color: Colors.white70,
          ),
          const SizedBox(width: 4),
        ],
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
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: _selectedImage != null
                            ? Image.file(_selectedImage!, fit: BoxFit.cover)
                            : (_imageUrl != null && _imageUrl!.isNotEmpty
                                ? Image.network(
                                    _imageUrl!,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) => _imagePlaceholder(isDark),
                                  )
                                : _imagePlaceholder(isDark)),
                      ),
                    ),
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

            // ── Buttons ──────────────────────────────────────────────────
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _deleteBook,
                    icon: const Icon(Icons.delete_outline_rounded, size: 18, color: Color(0xFFE03131)),
                    label: const Text('Xóa sách', style: TextStyle(color: Color(0xFFE03131))),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFFE03131), width: 1.5),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _updateBook,
                    style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14)),
                    child: _isLoading
                        ? const SizedBox(
                            height: 20, width: 20,
                            child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                          )
                        : const Text('Cập nhật', style: TextStyle(fontWeight: FontWeight.w700)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _imagePlaceholder(bool isDark) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.add_photo_alternate_outlined, size: 40,
            color: isDark ? const Color(0xFF495057) : const Color(0xFFCED4DA)),
        const SizedBox(height: 8),
        Text('Thêm ảnh bìa',
            style: TextStyle(fontSize: 12,
                color: isDark ? const Color(0xFF6C757D) : const Color(0xFFADB5BD))),
      ],
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
      style: TextStyle(fontSize: 14, color: isDark ? Colors.white : const Color(0xFF212529)),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, size: 18),
      ),
      validator: (v) => (v == null || v.isEmpty) ? 'Vui lòng nhập $label' : null,
    );
  }
}
