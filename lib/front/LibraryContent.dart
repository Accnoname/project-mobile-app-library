import 'package:flutter/material.dart';
import 'dart:math';

// Helper function to get random image URL
String getRandomImageUrl({int width = 300, int height = 200}) {
  final random = Random().nextInt(1000);
  return 'https://picsum.photos/$width/$height?random=$random';
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Landing Page',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const LibraryContent(),
    );
  }
}

class LibraryContent extends StatelessWidget {
  const LibraryContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const LandingPage();
  }
}

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      endDrawer: _buildMobileMenu(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _NavBar(isMobile: isMobile, scaffoldKey: _scaffoldKey),
            _HeroSection(),
            _FeaturedImageRow(),
            _ListSection(),
            _ImageGridSection(isMobile: isMobile),
            _FooterSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileMenu() {
    return Drawer(
      backgroundColor: Colors.white,
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Text(
              'Menu',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A1A1A),
              ),
            ),
            const SizedBox(height: 20),
            ListTile(
              title: const Text(
                'Trang chủ',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1A1A1A),
                ),
              ),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              title: const Text(
                'Giới thiệu',
                style: TextStyle(color: Color(0xFF555555)),
              ),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              title: const Text(
                'Danh mục',
                style: TextStyle(color: Color(0xFF555555)),
              ),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              title: const Text(
                'Quy định',
                style: TextStyle(color: Color(0xFF555555)),
              ),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              title: const Text(
                'Liên hệ',
                style: TextStyle(color: Color(0xFF555555)),
              ),
              onTap: () => Navigator.pop(context),
            ),
            const Divider(height: 40),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF5F5F5),
                foregroundColor: const Color(0xFF333333),
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: const Text(
                'Đăng nhập',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1A1A1A),
                foregroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: const Text(
                'Đăng ký',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── NAV BAR ─────────────────────────────────────────────────────────────────

class _NavBar extends StatelessWidget {
  final bool isMobile;
  final GlobalKey<ScaffoldState> scaffoldKey;
  const _NavBar({this.isMobile = false, required this.scaffoldKey});

  Widget _buildLibManageLogo() {
    return Row(
      children: const [
        Icon(Icons.local_library, size: 28, color: Color(0xFF1A1A1A)),
        SizedBox(width: 8),
        Text(
          'LibManage',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A1A1A),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 12 : 20,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      child: isMobile
          ? Row(
              children: [
                _buildLibManageLogo(),
                const Spacer(),
                IconButton(
                  icon: const Icon(
                    Icons.menu,
                    color: Color(0xFF1A1A1A),
                    size: 24,
                  ),
                  onPressed: () => scaffoldKey.currentState?.openEndDrawer(),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            )
          : Row(
              children: [
                const Spacer(),
                for (final label in [
                  'Trang chủ',
                  'Giới thiệu',
                  'Danh mục',
                  'Quy định',
                  'Liên hệ',
                ])
                  _navLink(label),
                const SizedBox(width: 12),
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFF333333)),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: const Text(
                    'Đăng nhập',
                    style: TextStyle(
                      fontSize: 13,
                      color: Color(0xFF333333),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1A1A1A),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: const Text(
                    'Đăng ký',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                _buildLibManageLogo(),
              ],
            ),
    );
  }

  Widget _navLink(String text, {bool isActive = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFFF0F0F0) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isActive ? const Color(0xFF1A1A1A) : const Color(0xFF555555),
            fontSize: 13,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

// ─── HERO SECTION ─────────────────────────────────────────────────────────────

class _HeroSection extends StatelessWidget {
  const _HeroSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 24),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Quản Lý Thư Viện Thông Minh',
            style: TextStyle(
              fontSize: 42,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
              letterSpacing: -1.5,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Giải pháp quản lý sách, độc giả và mượn sách hiệu quả',
            style: TextStyle(fontSize: 16, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}

// ─── FEATURED IMAGE ROW ───────────────────────────────────────────────────────

class _FeaturedImageRow extends StatelessWidget {
  const _FeaturedImageRow();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        children: [
          Expanded(child: _PlaceholderCard(height: 160)),
          const SizedBox(width: 12),
          Expanded(child: _PlaceholderCard(height: 160)),
        ],
      ),
    );
  }
}

class _PlaceholderCard extends StatelessWidget {
  final double height;
  const _PlaceholderCard({required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
        image: DecorationImage(
          image: NetworkImage(
            getRandomImageUrl(width: 400, height: height.toInt()),
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

// ─── LIST SECTION (cards with image + text + button) ─────────────────────────

class _ListSection extends StatelessWidget {
  const _ListSection();

  static const _items = [
    _ListItem(
      title: 'Quản lý Sách',
      body:
          'Lưu trữ thông tin chi tiết về các cuốn sách, tác giả, ISBN và tình trạng còn lại. Dễ dàng tìm kiếm và cập nhật kho sách.',
    ),
    _ListItem(
      title: 'Quản lý Độc Giả',
      body:
          'Hồ sơ đầy đủ của các độc giả, lịch sử mượn sách, và các thông báo tới hạn trả sách. Giúp theo dõi thành viên hiệu quả.',
    ),
    _ListItem(
      title: 'Hệ Thống Mượn/Trả',
      body:
          'Quản lý các phiếu mượn, hạn trả sách và phí quá hạn. Ghi nhận lịch sử mượn để phân tích nhu cầu đọc.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 32, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Các Tính Năng Chính',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 2),
          const Text(
            'Quản lý toàn bộ hoạt động của thư viện',
            style: TextStyle(fontSize: 13, color: Colors.black54),
          ),
          const SizedBox(height: 16),
          for (final item in _items) ...[
            _ListCard(item: item),
            const SizedBox(height: 12),
          ],
        ],
      ),
    );
  }
}

class _ListItem {
  final String title;
  final String body;
  const _ListItem({required this.title, required this.body});
}

class _ListCard extends StatelessWidget {
  final _ListItem item;
  const _ListCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Thumbnail
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(6),
              image: DecorationImage(
                image: NetworkImage(getRandomImageUrl(width: 100, height: 100)),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 14),
          // Text + button
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.body,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 10),
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.black38),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 6,
                    ),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: const Text(
                    'Button',
                    style: TextStyle(fontSize: 12, color: Colors.black87),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── IMAGE GRID SECTION (responsive columns) ────────────────────────────────

class _ImageGridSection extends StatelessWidget {
  final bool isMobile;
  const _ImageGridSection({this.isMobile = false});

  static const _gridItems = [
    _GridItem(
      title: 'Tìm Kiếm Sách',
      body:
          'Tìm kiếm nhanh chóng theo tiêu đề, tác giả, thể loại hoặc ISBN. Lọc kết quả theo tình trạng sẵn có.',
    ),
    _GridItem(
      title: 'Đặt Trước Sách',
      body:
          'Độc giả có thể đặt trước sách yêu thích. Nhận thông báo khi sách sẵn sàng để mượn.',
    ),
    _GridItem(
      title: 'Lịch Sử Mượn',
      body:
          'Xem toàn bộ lịch sử mượn sách, hạn trả và các cuốn sách yêu thích của bạn.',
    ),
    _GridItem(
      title: 'Thống Kê Báo Cáo',
      body:
          'Báo cáo chi tiết về lượng mượn, độc giả hoạt động và sách phổ biến nhất.',
    ),
    _GridItem(
      title: 'Quản Lý Phí',
      body:
          'Tính toán và quản lý phí trả trễ, phí mất sách tự động. Tạo hóa đơn dễ dàng.',
    ),
    _GridItem(
      title: 'Thông Báo Tự Động',
      body:
          'Gửi thông báo nhắc nhở hạn trả sách, cuốn sách yêu thích sẵn sàng và tin tức thư viện.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 36, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Các Tính Năng Bổ Sung',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 2),
          const Text(
            'Công cụ hỗ trợ quản lý thư viện hiệu quả',
            style: TextStyle(fontSize: 13, color: Colors.black54),
          ),
          const SizedBox(height: 16),
          GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isMobile ? 1 : 3,
              mainAxisSpacing: 16,
              crossAxisSpacing: 12,
              childAspectRatio: isMobile ? 1.2 : 0.75,
            ),
            itemCount: _gridItems.length,
            itemBuilder: (context, index) => _GridCard(item: _gridItems[index]),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

class _GridItem {
  final String title;
  final String body;
  const _GridItem({required this.title, required this.body});
}

class _GridCard extends StatelessWidget {
  final _GridItem item;
  const _GridCard({required this.item});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Image placeholder
        Container(
          width: double.infinity,
          height: isMobile ? 120 : 90,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(6),
            image: DecorationImage(
              image: NetworkImage(getRandomImageUrl(width: 300, height: 120)),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          item.title,
          style: TextStyle(
            fontSize: isMobile ? 14 : 13,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),
        Text(
          item.body,
          style: TextStyle(
            fontSize: isMobile ? 12 : 11,
            color: Colors.black54,
            height: 1.5,
          ),
          maxLines: isMobile ? 3 : 4,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

// ─── FOOTER ───────────────────────────────────────────────────────────────────

class _FooterSection extends StatelessWidget {
  const _FooterSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(color: Colors.grey.shade200),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Logo + socials
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black87, width: 1.5),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.local_library,
                        size: 12,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: const [
                      Icon(Icons.close, size: 14, color: Colors.black54),
                      SizedBox(width: 6),
                      Icon(
                        Icons.camera_alt_outlined,
                        size: 14,
                        color: Colors.black54,
                      ),
                      SizedBox(width: 6),
                      Icon(
                        Icons.play_circle_outline,
                        size: 14,
                        color: Colors.black54,
                      ),
                      SizedBox(width: 6),
                      Icon(
                        Icons.business_center_outlined,
                        size: 14,
                        color: Colors.black54,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(width: 32),
              // Footer link columns
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Expanded(
                      child: _FooterColumn(
                        title: 'Use cases',
                        items: [
                          'UI design',
                          'UX design',
                          'Wireframing',
                          'Diagramming',
                          'Brainstorming',
                          'Online whiteboard',
                          'Team collaboration',
                        ],
                      ),
                    ),
                    Expanded(
                      child: _FooterColumn(
                        title: 'Explore',
                        items: [
                          'Design',
                          'Prototyping',
                          'Development features',
                          'Design systems',
                          'Collaboration features',
                          'Design process',
                          'FigJam',
                        ],
                      ),
                    ),
                    Expanded(
                      child: _FooterColumn(
                        title: 'Resources',
                        items: [
                          'Blog',
                          'Best practices',
                          'Colors',
                          'Color wheel',
                          'Support',
                          'Developers',
                          'Resource library',
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Divider(color: Colors.grey.shade200),
          const SizedBox(height: 10),
          const Text(
            '© 2024 Company, Inc.',
            style: TextStyle(fontSize: 11, color: Colors.black38),
          ),
        ],
      ),
    );
  }
}

class _FooterColumn extends StatelessWidget {
  final String title;
  final List<String> items;
  const _FooterColumn({required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        for (final item in items)
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text(
              item,
              style: const TextStyle(fontSize: 11, color: Colors.black54),
            ),
          ),
      ],
    );
  }
}
