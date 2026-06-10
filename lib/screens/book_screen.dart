import 'package:flutter/material.dart';
import 'package:library_management_app/configs/themes/common.dart';
import 'package:library_management_app/models/book_model.dart';
import 'package:library_management_app/services/book_service.dart';
import 'package:library_management_app/screens/add_book_screen.dart';
import 'package:library_management_app/screens/edit_book_screen.dart';
import 'package:library_management_app/widgets/book_card.dart';

class BookScreen extends StatefulWidget {
  const BookScreen({super.key});

  @override
  State<BookScreen> createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen>
    with SingleTickerProviderStateMixin {
  final BookService _bookService = BookService();
  late TabController _tabController;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            expandedHeight: 130,
            floating: false,
            pinned: true,
            automaticallyImplyLeading: false,
            backgroundColor: colorScheme.primary,
            forceElevated: innerBoxIsScrolled,
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
                    padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Danh sách sách',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 10),
                        // Search bar
                        Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextField(
                            onChanged: (v) => setState(() => _searchQuery = v.toLowerCase()),
                            style: const TextStyle(color: Colors.white, fontSize: 14),
                            decoration: const InputDecoration(
                              hintText: 'Tìm tên sách, tác giả...',
                              hintStyle: TextStyle(color: Colors.white60, fontSize: 14),
                              prefixIcon: Icon(Icons.search_rounded, color: Colors.white70, size: 20),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(vertical: 10),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(44),
              child: Container(
                color: colorScheme.primary,
                child: TabBar(
                  controller: _tabController,
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.white60,
                  indicatorColor: Colors.white,
                  indicatorWeight: 3,
                  indicatorSize: TabBarIndicatorSize.label,
                  tabs: const [
                    Tab(text: 'Tất cả'),
                    Tab(text: 'Thể loại'),
                  ],
                ),
              ),
            ),
          ),
        ],
        body: TabBarView(
          controller: _tabController,
          children: [
            _buildAllTab(context, isDark),
            _buildCategoryTab(context, isDark),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await Navigator.push(context, MaterialPageRoute(builder: (_) => const AddBookScreen()));
        },
        icon: const Icon(Icons.add_rounded),
        label: const Text('Thêm sách', style: TextStyle(fontWeight: FontWeight.w600)),
        shape: RoundedRectangleBorder(borderRadius: radius100),
      ),
    );
  }

  Widget _buildAllTab(BuildContext context, bool isDark) {
    return StreamBuilder<List<BookModel>>(
      stream: _bookService.getBooks(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        final books = (snapshot.data ?? []).where((b) {
          if (_searchQuery.isEmpty) return true;
          return b.title.toLowerCase().contains(_searchQuery) ||
              b.author.toLowerCase().contains(_searchQuery);
        }).toList();

        if (books.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.menu_book_outlined, size: 64,
                    color: isDark ? const Color(0xFF2C3248) : const Color(0xFFCED4DA)),
                const SizedBox(height: 12),
                Text('Chưa có sách nào',
                    style: TextStyle(color: isDark ? const Color(0xFF6C757D) : const Color(0xFFADB5BD))),
              ],
            ),
          );
        }

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
              child: Row(
                children: [
                  Text(
                    '${books.length} cuốn sách',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: isDark ? const Color(0xFF6C757D) : const Color(0xFF9FA8B5),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 100),
                itemCount: books.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final book = books[index];
                  return BookCard(
                    book: book,
                    isDark: isDark,
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => EditBookScreen(book: book)),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildCategoryTab(BuildContext context, bool isDark) {
    final categories = [
      _CategoryItem(icon: Icons.science_rounded, label: 'Khoa học', color: const Color(0xFF3B5BDB)),
      _CategoryItem(icon: Icons.history_edu_rounded, label: 'Lịch sử', color: const Color(0xFFF59F00)),
      _CategoryItem(icon: Icons.psychology_rounded, label: 'Tâm lý', color: const Color(0xFF0CA678)),
      _CategoryItem(icon: Icons.code_rounded, label: 'Công nghệ', color: const Color(0xFFE03131)),
      _CategoryItem(icon: Icons.auto_stories_rounded, label: 'Văn học', color: const Color(0xFF7048E8)),
      _CategoryItem(icon: Icons.business_center_rounded, label: 'Kinh tế', color: const Color(0xFF1C7ED6)),
    ];

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.6,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: categories.length,
      itemBuilder: (context, i) {
        final cat = categories[i];
        return Container(
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1E2130) : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: isDark ? const Color(0xFF2C3248) : const Color(0xFFE9ECEF)),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: cat.color.withOpacity(isDark ? 0.2 : 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(cat.icon, color: cat.color, size: 22),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        cat.label,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                          color: isDark ? Colors.white : const Color(0xFF212529),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _CategoryItem {
  final IconData icon;
  final String label;
  final Color color;
  _CategoryItem({required this.icon, required this.label, required this.color});
}

