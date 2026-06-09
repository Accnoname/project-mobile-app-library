import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:library_management_app/configs/themes/gap.dart';
import 'package:library_management_app/models/book_model.dart';
import 'package:library_management_app/services/book_service.dart';
import 'package:library_management_app/services/cloudinary_service.dart';

class EditBookScreen extends StatefulWidget {
  final BookModel book;
  const EditBookScreen({super.key, required this.book});

  @override
  State<EditBookScreen> createState() => _EditBookScreenState();
}

//
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
    _quantityController = TextEditingController(
      text: widget.book.availableCount.toString(),
    );
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() => _selectedImage = File(pickedFile.path));
    }
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
      title: _titleController.text.trim(),
      author: _authorController.text.trim(),
      publisher: _publisherController.text.trim(),
      year: _yearController.text.trim(),
      availableCount: int.tryParse(_quantityController.text) ?? 0,
      imageUrl: imageUrl,
      id: widget.book.id,
    );

    try {
      await _bookService.updateBook(updatedBook);
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Cập nhật thành công!')));
        Navigator.pop(context);
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Lỗi: $e')));
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _deleteBook() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Xóa sách"),
        content: const Text("Bạn có chắc muốn xóa cuốn sách này không?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Hủy"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text("Xóa"),
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
    return Scaffold(
      appBar: AppBar(title: const Text("Cập nhật sách")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: Center(
                  child: _selectedImage != null
                      ? Image.file(
                          _selectedImage!,
                          width: 120,
                          height: 120,
                          fit: BoxFit.cover,
                        )
                      : _imageUrl != null && _imageUrl!.isNotEmpty
                      ? Image.network(
                          _imageUrl!,
                          width: 120,
                          height: 120,
                          fit: BoxFit.cover,
                        )
                      : Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(Icons.camera_alt, size: 40),
                        ),
                ),
              ),
              const SizedBox(height: 16),
              _buildField(_titleController, 'Tên sách *'),
              _buildField(_authorController, 'Tác giả *'),
              _buildField(_publisherController, 'Nhà xuất bản *'),
              _buildField(_yearController, 'Năm xuất bản *'),
              _buildField(
                _quantityController,
                'Số lượng *',
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 24),
              Row(
                spacing: Gap.sM,
                children: [
                  Expanded(
                    flex: 1,
                    child: OutlinedButton.icon(
                      onPressed: _deleteBook,
                      label: const Text(
                        "Xóa sách",
                        style: TextStyle(color: Colors.red),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.red, width: 1.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),

                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),

                      onPressed: _isLoading ? null : _updateBook,
                      child: _isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text('Cập nhật'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField(
    TextEditingController c,
    String label, {
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: c,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        keyboardType: keyboardType,
        validator: (value) {
          if (value == null || value.isEmpty) return 'Vui lòng nhập $label';
          return null;
        },
      ),
    );
  }
}
