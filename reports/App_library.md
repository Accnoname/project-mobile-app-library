# **ĐẠI HỌC PHENIKAA TRƯỜNG CÔNG NGHỆ THÔNG TIN**

**ĐỒ ÁN MÔN HỌC**

**LẬP TRÌNH CHO THIẾT BỊ DI ĐỘNG**

# THIẾT KẾ ỨNG DỤNG QUẢN LÝ

# THƯ VIỆN

**Giảng viên hướng dẫn: THS. NGUYỄN VĂN CƯỜNG Sinh viên thực hiện: Nguyễn Trung Hiếu (23011098), Trương Bùi Huy Hiếu (23010885), Nguyễn Văn Trọng (23010748)**

**Khoá: K16 – 2022 \- 2026**

**Ngành/ chuyên ngành:	Công nghệ thông tin**

Hà Nội, ngày 10 tháng 06 năm 2026

# **LỜI CẢM ƠN** {#lời-cảm-ơn}

Chúng em xin gửi lời cảm ơn chân thành và sâu sắc nhất đến Thạc sĩ Nguyễn Văn Cường, giảng viên hướng dẫn môn *Lập trình cho thiết bị di động*, người đã tận tình chỉ bảo, hướng dẫn và giúp đỡ chúng em trong suốt quá trình học tập và thực hiện đồ án.

Nhờ sự chỉ dẫn và góp ý quý báu của thầy, chúng em đã nắm vững hơn các kiến thức về Flutter và Firebase, cũng như hiểu rõ hơn quy trình phát triển một ứng dụng di động hoàn chỉnh.

Chúng em cũng xin gửi lời cảm ơn đến toàn thể thầy cô trong Khoa Công nghệ Thông tin – Trường Đại học Phenikaa đã truyền đạt cho chúng em những kiến thức, kinh nghiệm quý báu, giúp chúng em có nền tảng để hoàn thành đồ án này.

Mặc dù đã nỗ lực hoàn thiện sản phẩm, song do thời gian và năng lực còn hạn chế, bài làm không tránh khỏi những thiếu sót. Kính mong thầy cô thông cảm và góp ý để chúng em hoàn thiện hơn.

Xin chân thành cảm ơn\!

# **LỜI CAM ĐOAN** {#lời-cam-đoan}

Chúng tôi cam đoan Đồ án môn học là sản phẩm trí tuệ của tập thể chúng tôi. Mọi thông tin, dữ liệu, hình ảnh, etc. được sử dụng từ các nguồn khác đều được trích dẫn đầy đủ và có thể tìm thấy các tài liệu liên quan thông qua mục tài liệu tham khảo.

Chúng tôi xin chịu trách nhiệm hoàn toàn về nội dung của Đồ án môn học mà chúng tôi đã nộp.

Hà nội, ngày 01 tháng 11 năm 2025

Nguyễn Trung Hiếu, Trương Bùi Huy Hiếu, Nguyễn Văn Trọng

# **PHÂN CÔNG NHIỆM VỤ ĐỒ ÁN** {#phân-công-nhiệm-vụ-đồ-án}

| Danh sách các công việc/nhiệm vụ | Mô tả tóm tắt công việc |
| :---- | :---- |
| Xây dựng ý tưởng | Lên ý tưởng ứng dụng. |
| Xây dựng Front-end | Lên ý tưởng giao diện, các model, các chức năng chính, tối ưu giao diện. Viết code. |
| Xây dựng Back-end | Tìm hiểu công cụ, xây dựng data và kết nối với Front-end. |
| Viết báo cáo | Tìm hiểu lý thuyết, trình bày ý tưởng. |
| Làm slide | Thiết kế để trình bày ý tưởng. |
| Làm video demo | Quay video các chức năng của app. |

| Tên sinh viên / Mã sinh viên | Các công việc đảm nhiệm | Tỉ lệ hoàn thành |
| :---- | :---- | :---- |
| **Nguyễn Trung Hiếu** (23011098) | - Phân tích yêu cầu hệ thống & User Stories<br>- Thiết kế Sơ đồ UML (Class Diagram & Sequence Diagrams)<br>- Thiết kế giao diện trang chủ & màn hình đăng nhập<br>- Biên soạn tài liệu báo cáo đồ án chi tiết | 100% |
| **Trương Bùi Huy Hiếu** (23010885) | - Setup dự án Flutter & Git repository<br>- Thiết kế & Code giao diện UI Dashboard biểu đồ thống kê<br>- Xây dựng màn hình Quản lý Sách (thêm, sửa, xóa, tìm kiếm) | 100% |
| **Nguyễn Văn Trọng** (23010748) | - Setup Cơ sở dữ liệu Firebase Firestore và Authentication<br>- Tích hợp dịch vụ Service mapping dữ liệu lên Firestore<br>- Xây dựng chức năng Phiếu Mượn & Phiếu Trả | 100% |

ĐẠI HỌC PHENIKAA TRƯỜNG CÔNG NGHỆ THÔNG TIN

**KỲ THI KẾT THÚC HỌC PHẦN HỌC KỲ …..… NĂM HỌC …….. \- ….…**

**PHIẾU CHẤM THI TIỂU LUẬN/ĐỒ ÁN**

Môn học:..........................................................................Lớp	học	phần:

Sinh viên thực hiện:.........................................................

1. Điểm:

2. Điểm:

3. Điểm:

4. Điểm:

5. Điểm:

Ngày thi: ..........................................................................Phòng	thi:

Giảng viên chấm thi 1 (Ký và ghi rõ họ tên)

Giảng viên chấm thi 2 (Ký và ghi rõ họ tên)

# **MỤC LỤC** {#mục-lục}

[**LỜI CẢM ƠN**	**2**](#lời-cảm-ơn)

[**LỜI CAM ĐOAN**	**3**](#lời-cam-đoan)

[**PHÂN CÔNG NHIỆM VỤ ĐỒ ÁN	4**](#phân-công-nhiệm-vụ-đồ-án)

[**MỤC LỤC	6**](#mục-lục)

[**DANH MỤC BẢNG	8**](#danh-mục-bảng)

[**DANH MỤC HÌNH ẢNH	9**](#danh-mục-hình-ảnh)

[**CHƯƠNG 1\. CƠ SỞ LÝ THUYẾT VỀ FLUTTER	10**](#chương-1.-cơ-sở-lý-thuyết-về-flutter)

1. [**Lời mở đầu	10**](#lời-mở-đầu)

   2. [**Giới thiệu	10**](#giới-thiệu)

      1. [**Flutter là gì?	10**](#flutter-là-gì?)

      2. [**Ưu điểm của Flutter	10**](#ưu-điểm-của-flutter)

      3. [**Hệ thống Widget trong Fluter	11**](#hệ-thống-widget-trong-fluter)

   3. [**Giới thiệu về Firebase	11**](#giới-thiệu-về-firebase)

      1. [**Firebase Authentication	11**](#firebase-authentication)

      2. [**Cloud Firestore (Firestore Database)	11**](#cloud-firestore-\(firestore-database\))

      3. [**Firebase Storage	12**](#firebase-storage)

[**CHƯƠNG 2\. THIẾT KẾ ỨNG DỤNG QUẢN LÝ THƯ VIỆN	12**](#chương-2.-thiết-kế-ứng-dụng-quản-lý-thư-viện)

1. [**Mục tiêu của hệ thống	12**](#mục-tiêu-của-hệ-thống)

   2. [**Đối tượng sử dụng:	14**](#đối-tượng-sử-dụng:)

   3. [**Chức năng chính của hệ thống	14**](#chức-năng-chính-của-hệ-thống)

      1. [**Chức năng Đăng nhập**	**14**](#chức-năng-đăng-nhập)

      2. [**Chức năng Quản lý sách**	**15**](#chức-năng-quản-lý-sách)

      3. [**Chức năng Quản lý phiếu mượn**	**15**](#chức-năng-quản-lý-phiếu-mượn)

      4. [**Chức năng Quản lý phiếu trả**	**15**](#chức-năng-quản-lý-phiếu-trả)

      5. [**Chức năng Thống kê**	**15**](#chức-năng-thống-kê)

      6. [**Chức năng Cài đặt (Setting)**	**15**](#chức-năng-cài-đặt-\(setting\))

   4. [**Sơ đồ Use-Case tổng quát	15**](#sơ-đồ-use-case-tổng-quát)

      1. [**Use-Case Admin	16**](#use-case-admin)

      2. [**Use-Case User	17**](#use-case-user)

   5. [**Đặc tả Use-Case	17**](#đặc-tả-use-case)

      1. [**UC-1: Đăng nhập Hệ thống	17**](#uc-1:-đăng-nhập-hệ-thống)

      2. [**UC-2: Quản lý Sách (Thêm, Sửa, Xóa)	18**](#uc-2:-quản-lý-sách-\(thêm,-sửa,-xóa\))

      3. [**UC-3: Quản lý Phiếu Mượn (Thêm, Sửa, Xóa)	19**](#uc-3:-quản-lý-phiếu-mượn-\(thêm,-sửa,-xóa\))

      4. [**UC-4: Quản lý Phiếu Trả**	**20**](#uc-4:-quản-lý-phiếu-trả)

      5. [**UC-5: Quản lý Tài khoản Cá nhân	20**](#uc-5:-quản-lý-tài-khoản-cá-nhân)

      6. [**UC-6: Thống kê	21**](#uc-6:-thống-kê)

   6. [**Mô hình dữ liệu	22**](#mô-hình-dữ-liệu)

      1. [**Tổng quan**	**22**](#tổng-quan)

      2. [**Phân tích Chi tiết các Collection**	**22**](#phân-tích-chi-tiết-các-collection)

      3. [**Phân tích Luồng Dữ liệu và Mối quan hệ**	**24**](#phân-tích-luồng-dữ-liệu-và-mối-quan-hệ)

      4. [**Kết luận**	**25**](#kết-luận)

   7. [**Thiết kế kiến trúc hệ thống	25**](#thiết-kế-kiến-trúc-hệ-thống)

      1. [**Tổng quan**	**25**](#tổng-quan-1)

      2. [**Sơ đồ Kiến trúc Tổng thể**	**26**](#sơ-đồ-kiến-trúc-tổng-thể)

      3. [**Phân tích Chi tiết các Thành phần**	**26**](#phân-tích-chi-tiết-các-thành-phần)

[**CHƯƠNG 3\. TRIỂN KHAI VÀ ĐÁNH GIÁ**	**29**](#chương-3.-triển-khai-và-đánh-giá)

1. [**Môi trường và phát triển	29**](#môi-trường-và-phát-triển)

   1. [**Công cụ Lập trình và Nền tảng Ứng dụng	29**](#công-cụ-lập-trình-và-nền-tảng-ứng-dụng)

      2. [**Công nghệ Backend và Cơ sở Dữ liệu	29**](#công-nghệ-backend-và-cơ-sở-dữ-liệu)

      3. [**Công cụ Hỗ trợ và Quản lý Dự án	30**](#công-cụ-hỗ-trợ-và-quản-lý-dự-án)

   2. [**Cấu trúc thư mục mã nguồn	30**](#cấu-trúc-thư-mục-mã-nguồn)

   3. [**Mã nguồn chính và giao diện Demo	30**](#mã-nguồn-chính-và-giao-diện-demo)

      1. [**Xử lý Đăng ký/Đăng nhập**	**31**](#xử-lý-đăng-ký/đăng-nhập)

      2. [**Quản lý sách	33**](#quản-lý-sách)

      3. [**Quản lý phiếu mượn/trả**	**35**](#quản-lý-phiếu-mượn/trả)

      4. [**Thống kê	39**](#thống-kê)

      5. [**Setting	40**](#setting)

      6. [**Cấu trúc tệp pubspec.yaml	42**](#cấu-trúc-tệp-pubspec.yaml-name:-library_management_app-description:-"a-new-flutter-project."-publish_to:-'none')

[**CHƯƠNG 4\. KẾT LUẬN VÀ HƯỚNG PHÁT TRIỂN	43**](#chương-4.-kết-luận-và-hướng-phát-triển)

1. [**Kết luận Dự án	43**](#kết-luận-dự-án)

   2. [**Hướng phát triển trong tương lai**	**44**](#hướng-phát-triển-trong-tương-lai)

      1. [**Phân quyền người dùng (Admin/User)	44**](#phân-quyền-người-dùng-\(admin/user\))

      2. [**Thông báo đẩy (Push Notification)	44**](#thông-báo-đẩy-\(push-notification\))

      3. [**Quản lý danh mục sách nâng cao	44**](#quản-lý-danh-mục-sách-nâng-cao)

      4. [**Tích hợp quét mã QR	44**](#tích-hợp-quét-mã-qr)

      5. [**Triển khai đa nền tảng (Web và iOS)	44**](#triển-khai-đa-nền-tảng-\(web-và-ios\))

      6. [**Cải thiện giao diện và trải nghiệm người dùng (UI/UX)	44**](#cải-thiện-giao-diện-và-trải-nghiệm-người-dùng-\(ui/ux\))

      7. [**Đồng bộ dữ liệu ngoại tuyến (Offline Support)	44**](#đồng-bộ-dữ-liệu-ngoại-tuyến-\(offline-support\))

[**TÀI LIỆU THAM KHẢO	45**](#tài-liệu-tham-khảo)

# **DANH MỤC BẢNG** {#danh-mục-bảng}

Bảng 1: Chức năng dịch vụ cơ bản của Firebase. Bảng 2: Bảng đặc tả chức năng Đăng ký/Đăng nhập. Bảng 3: Bảng đặc tả chức năng Quản lý sách

Bảng 4: Bảng đặc tả chức năng Quản lý phiếu mượn.

Bảng 5: Bảng đặc tả chức năng Quản lý phiếu trả.

Bảng 6: Bảng đặc tả chức năng Quản lý tài khoản cá nhân. Bảng 7: Bảng đặc tả chức năng Thống kê.

Bảng 8: Công cụ Lập trình và Nền tảng ứng dụng. Bảng 9: Công nghệ Backend và Cơ sở dữ liệu.

Bảng 10: Công cụ và Thư viện hỗ trợ.

# **DANH MỤC HÌNH ẢNH** {#danh-mục-hình-ảnh}

Hình 1: Sơ đồ Use-Case cho Admin.

Hình 2: Sơ đồ Use-Case cho User. Hình 3: Sơ đồ kiến trúc tổng thể. Hình 4: Cấu trúc tệp screens.  
Hình 5: Cấu trúc tệp Widgets. Hình 6: Cấu trúc tệp Themes.  
Hình 7: Cấu trúc thư mục mã nguồn Hình 8: Giao diện đăng ký.

Hình 9: Giao diện Đăng nhập.

Hình 10: Giao diện Quản lý sách.

Hình 11: Giao diện Quản lý phiếu mượn.

Hình 12: Giao diện Quản lý phiếu trả.

Hình 13: Giao diện Thống kê phiếu Mượn/Trả.

Hình 14: Giao diện Setting.

# **CHƯƠNG 1\. CƠ SỞ LÝ THUYẾT VỀ FLUTTER** {#chương-1.-cơ-sở-lý-thuyết-về-flutter}

1. ## **Lời mở đầu** {#lời-mở-đầu}

Ngày nay, sự phát triển nhanh chóng của công nghệ di động đã mở ra kỷ nguyên mới cho việc xây dựng các ứng dụng chạy trên nhiều nền tảng. Thay vì phải phát triển riêng biệt cho Android và iOS, các framework cross-platform như Flutter**,** React Native**,** hay Xamarin cho phép lập trình viên chỉ cần viết một lần và chạy ở mọi nơi.

Trong số đó, Flutter – do Google phát triển – nổi bật với hiệu năng cao, khả năng tùy biến giao diện mạnh mẽ và cộng đồng hỗ trợ lớn.

Đồ án “Xây dựng ứng dụng Quản lý Thư viện” được xây dựng bằng Flutter (frontend) kết hợp với Firebase (backend) nhằm tạo ra một hệ thống quản lý sách, phiếu mượn, phiếu trả, thống kê, và cài đặt người dùng.

2. ## **Giới thiệu** {#giới-thiệu}

   1. ## **Flutter là gì?** {#flutter-là-gì?}

Flutter là framework phát triển giao diện người dùng mã nguồn mở, do Google phát hành.

Flutter sử dụng ngôn ngữ Dart, cho phép biên dịch trực tiếp sang mã gốc (native code), giúp ứng dụng có hiệu năng cao và mượt mà.

Cấu trúc của Flutter bao gồm 3 tầng chính:

* **Framework Layer**: Cung cấp các thành phần UI như Material, Cupertino,

  Widgets.

  * **Engine Layer**: Xử lý render đồ họa bằng thư viện Skia.

    * **Embedder Layer**: Tích hợp trực tiếp với hệ điều hành Android/iOS.

    2. ## **Ưu điểm của Flutter** {#ưu-điểm-của-flutter}

       * **Hiệu năng cao**: Flutter không cần qua lớp trung gian (bridge) như React

  Native.

       * **Hot Reload**: Giúp lập trình viên thấy ngay thay đổi trong vài mili-giây.

       * **Widget phong phú**: Giao diện đẹp, dễ tùy biến.

       * **Đa nền tảng**: Chạy trên Android, iOS, Web, Windows, macOS.

    3. ## **Hệ thống Widget trong Fluter** {#hệ-thống-widget-trong-fluter}

Flutter  xây  dựng  UI  hoàn  toàn  dựa  trên  Widget  Tree. Mỗi phần tử giao diện – từ nút bấm, văn bản, hình ảnh đến layout – đều là một widget.  
Có hai loại chính:

* **StatelessWidget**: Không thay đổi trong quá trình chạy.

  * **StatefulWidget**: Có thể thay đổi trạng thái (ví dụ: danh sách sách, biểu đồ

  thống kê).

  3. ## **Giới thiệu về Firebase** {#giới-thiệu-về-firebase}

**Firebase** là nền tảng Backend-as-a-Service (BaaS) của Google, hỗ trợ nhiều module giúp phát triển ứng dụng di động nhanh chóng.

| Dịch vụ | Chức năng |
| :---- | ----- |
| **Authentication** | Xác thực người dùng (Email, Google, Facebook...) |
| **Cloud Firestore (Firestore Database)** |  Cơ sở dữ liệu NoSQL, lưu trữ dữ liệu dạng document |
| **Storage** | Lưu trữ ảnh, file, tài liệu |
| **Analytics** | Thống kê hành vi người dùng |
| **Cloud Messaging** | Gửi thông báo đẩy (push notification) |

*Bảng 1: Chức năng dịch vụ cơ bản của Firebase.*

1. ## **Firebase Authentication** {#firebase-authentication}

Giúp quản lý tài khoản người dùng, hỗ trợ đăng ký, đăng nhập, thay đổi mật khẩu và xác thực qua email.

2. ## **Cloud Firestore (Firestore Database)** {#cloud-firestore-(firestore-database)}

Là cơ sở dữ liệu được lưu dưới dạng document (NoSQL) theo cấu trúc:

Collection

├── Document

│	├── Field: Value

│	├── Field: Value

│	├── Field: Value

Trong đó:

│	└── Field: Value

……

└── Document

├── Field: Value

├── Field: Value

├── Field: Value

└── Field: Value

- **Collection:** là một bảng như trong cơ sở dữ liệu nhưng nó chứa các document chứ không chứa dữ liệu trực tiếp. Mỗi collection có thể chứa nhiều Document và mỗi Document là khác nhau.

- ## **Document:**

  * Là một đối tượng dữ liệu cụ thể, chứa các cặp Field–Value.

  * Mỗi document có một ID duy nhất, do bạn tự đặt hoặc để

  Firestore tự tạo ngẫu nhiên.

  * Một document có thể chứa sub-collection (bộ sưu tập con) bên trong, tạo thành cấu trúc cây.

    - ## **Field:**

      * Là tên của thuộc tính trong Document.

      * Mỗi Field chứa một giá trị (Value) cụ thể.

      * Field trong Firestore tương tự như tên cột trong bảng SQL.

    - ## **Value:**

      * Là dữ liệu thực tế được lưu trong mỗi Field.

      * Firestore hỗ trợ nhiều kiểu dữ liệu (String, Number, Boolean, Timestamp, Array,…).

    3. ## **Firebase Storage** {#firebase-storage}

Lưu trữ hình ảnh và file do người dùng tải lên.

# **CHƯƠNG 2\. THIẾT KẾ ỨNG DỤNG QUẢN LÝ THƯ VIỆN** {#chương-2.-thiết-kế-ứng-dụng-quản-lý-thư-viện}

1. ## **Mục tiêu của hệ thống** {#mục-tiêu-của-hệ-thống}

Ứng dụng “Quản lý Thư viện” được xây dựng với mục tiêu chính là hỗ trợ quá trình quản lý, mượn – trả sách trong thư viện một cách nhanh chóng, chính xác và

tiện lợi, đồng thời nâng cao hiệu quả hoạt động của cán bộ thư viện cũng như trải nghiệm của người dùng (độc giả).

Cụ thể, hệ thống hướng đến các mục tiêu sau:

* **Quản lý dữ liệu thư viện một cách khoa học:** Hệ thống cho phép quản lý đầy đủ các danh mục như danh sách sách, độc giả, phiếu mượn, phiếu trả, thể loại, tác giả,... Mỗi đối tượng được lưu trữ và xử lý có hệ thống, giúp người quản trị dễ dàng theo dõi, cập nhật và tra cứu thông tin.  
* **Hỗ trợ người dùng trong việc tìm kiếm và mượn sách:** Người dùng có thể tìm kiếm sách theo nhiều tiêu chí khác nhau như tên sách, tác giả, thể loại, hoặc tình trạng mượn. Khi tìm thấy cuốn sách phù hợp, người dùng có thể đăng ký mượn sách trực tuyến, giảm bớt thời gian chờ đợi và thao tác thủ công như trong hình thức truyền thống.  
* **Quản lý và theo dõi quá trình mượn – trả sách:** Hệ thống cung cấp chức năng tạo và lưu trữ phiếu mượn, phiếu trả tự động, giúp cán bộ thư viện dễ dàng thống kê và kiểm soát tình trạng sách. Khi người dùng trả sách, thông tin sẽ được cập nhật tức thời vào cơ sở dữ liệu, đảm bảo tính chính xác và minh bạch trong quản lý.

* **Thống kê và báo cáo hoạt động thư viện:** Ứng dụng có khả năng thống kê số lượng sách được mượn, trả, còn tồn kho hoặc đang giữ theo từng khoảng thời gian (ngày, tháng, năm). Các báo cáo thống kê giúp người quản lý nắm bắt nhanh tình hình sử dụng tài nguyên thư viện, từ đó có kế hoạch bổ sung hoặc bảo trì sách hợp lý.  
* **Cung cấp hệ thống tài khoản cá nhân:** Mỗi người dùng có thể đăng ký và đăng nhập bằng tài khoản riêng, giúp lưu lại thông tin cá nhân, lịch sử mượn sách và các hoạt động gần đây. Đồng thời, người dùng có thể chỉnh sửa thông tin cá nhân, thay đổi mật khẩu, hoặc cập nhật email để đảm bảo bảo mật và thuận tiện trong quá trình sử dụng.  
* **Tăng cường tính hiện đại và thuận tiện trong quản lý:** Việc ứng dụng công nghệ thông tin trong quản lý thư viện giúp tự động hóa nhiều quy trình thủ công, giảm thiểu sai sót do con người và tiết kiệm thời gian. Bên cạnh đó, giao diện thân thiện và dễ sử dụng giúp người dùng thao tác nhanh, mang lại trải nghiệm tốt hơn khi tra cứu và mượn sách.

Mục tiêu của hệ thống “Quản lý Thư viện” là xây dựng một nền tảng hiện đại, hiệu quả, hỗ trợ tối đa cho cả người quản trị và người dùng trong việc quản lý, tìm kiếm, mượn – trả sách; đồng thời giúp nâng cao năng suất làm việc, tiết kiệm thời gian và tối ưu hóa hoạt động thư viện.

2. ## **Đối tượng sử dụng:** {#đối-tượng-sử-dụng:}

Website được xây dựng phục vụ hai đối tượng chính là Admin( nhà quản trị) và Khách hàng với các chức năng sau:

* ### ***Admin***

  * Đăng nhập App

  * Xem, cập nhật, xoá thông tin sách, phiếu mượn sách và phiếu trả sách.

  * Quản lí sách, phiếu mượn sách và phiếu trả sách.

  * Kiểm soát và xác thực tương tác của user.

  * Thống kê số lượng sách, tỉ lệ phiếu mượn/trả theo khoảng thời gian.

* **User:**

  * Đã có tài khoản

  * Có quyền đăng nhập, đăng xuất, thay đổi thông tin cá nhân và đổi mật khẩu.

  * Được quyền mượn sách và trả sách.

  3. ## **Chức năng chính của hệ thống** {#chức-năng-chính-của-hệ-thống}

     1. ## **Chức năng Đăng ký/Đăng nhập** {#chức-năng-đăng-nhập}

- Chức năng này cho phép người dùng tạo tài khoản mới (Thủ thư) hoặc đăng nhập bằng tài khoản đã có để truy cập hệ thống.

- Ứng dụng sử dụng Firebase Authentication để xác thực thông tin đăng nhập qua Email và Mật khẩu, đảm bảo an toàn và bảo mật. Giao diện đăng nhập sử dụng ảnh nền thư viện ấm áp với form đăng nhập nổi bật, có chức năng hiện/ẩn mật khẩu. Sau khi đăng nhập thành công, người dùng được chuyển hướng đến màn hình Trang chủ.

  2. ## **Chức năng Quản lý sách** {#chức-năng-quản-lý-sách}

- Cho phép người quản trị thực hiện các thao tác thêm, sửa, xóa và tìm kiếm thông tin sách trong thư viện. Mỗi cuốn sách được quản lý bằng các thông tin như mã sách, tên sách, tác giả, thể loại, số lượng tồn và tình trạng hiện tại.  
- Chức năng này giúp hệ thống luôn duy trì được cơ sở dữ liệu chính xác, đầy đủ và cập nhật nhất.

  3. ## **Chức năng Quản lý phiếu mượn** {#chức-năng-quản-lý-phiếu-mượn}

- Người dùng có thể chọn sách muốn mượn, nhập số lượng, và lưu thông tin phiếu mượn vào cơ sở dữ liệu. Mỗi phiếu mượn ghi nhận các thông tin gồm mã độc giả, danh sách sách được mượn, ngày mượn và hạn trả.  
- Tính năng này giúp việc theo dõi và quản lý lịch sử mượn sách trở nên rõ ràng, thuận tiện.

  4. ## **Chức năng Quản lý phiếu trả** {#chức-năng-quản-lý-phiếu-trả}

- Hệ thống hiển thị danh sách các phiếu mượn chưa trả, cho phép người dùng hoặc cán bộ thư viện cập nhật trạng thái khi sách được hoàn trả.

- Sau khi cập nhật, hệ thống sẽ tự động thay đổi tình trạng sách trong kho, đảm bảo dữ liệu được đồng bộ giữa các bảng và phản ánh đúng thực tế.

  5. ## **Chức năng Thống kê** {#chức-năng-thống-kê}

Cung cấp các biểu đồ trực quan (cột và tròn) để thống kê số lượng phiếu mượn và phiếu trả theo từng khoảng thời gian (ngày, tháng, năm). Chức năng này giúp người quản lý nắm bắt xu hướng sử dụng sách, số lượng người mượn, và hiệu suất hoạt động của thư viện một cách trực quan, dễ hiểu.

6. ## **Chức năng Cài đặt (Setting)** {#chức-năng-cài-đặt-(setting)}

Cho phép người dùng chỉnh sửa thông tin cá nhân, đổi mật khẩu, và tùy chỉnh giao diện ứng dụng (chế độ tối/sáng) theo sở thích cá nhân. Chức năng này giúp nâng cao trải nghiệm người dùng, đồng thời đảm bảo tính cá nhân hóa và bảo mật cho từng tài khoản.

4. ## **Sơ đồ Use-Case tổng quát** {#sơ-đồ-use-case-tổng-quát}

   1. ## **Use-Case Admin** {#use-case-admin}

      *Hình 1: Sơ đồ Use-Case cho Admin.*

Đối với Quản trị viên, hệ thống cung cấp các quyền cao hơn để quản lý toàn bộ thư viện:

* ## **Quản lý Sách:**

  * Thêm sách mới vào hệ thống.

  * Sửa thông tin sách.

  * Xóa sách khỏi hệ thống.

* ## **Quản lý Tài khoản:**

  * Quản lý (ví dụ: xóa) các tài khoản của User.

* ## **Quản lý Phiếu mượn:**

  * Toàn quyền xem, thêm, sửa, xóa các phiếu mượn của tất cả bạn đọc.

* ## **Quản lý Phiếu trả:**

  * Quản lý (thêm, sửa, xóa) các phiếu ghi nhận việc trả sách.

* ## **Thống kê:**

  * Xem các báo cáo, thống kê về tình hình mượn/trả sách và các hoạt động khác của thư viện.

    2. ## **Use-Case User** {#use-case-user}

![][image1]

*Hình 2: Sơ đồ Use-Case cho User.*

Đối với User, hệ thống cung cấp các nhóm chức năng cốt lõi sau:

* ## **Quản lý tài khoản cá nhân:**

  * Đăng nhập / Đăng xuất.

  * Sửa thông tin cá nhân.

  * Đổi mật khẩu.

  * (Tùy chọn) Đổi theme (giao diện).

* ## **Xem sách:**

  * Tìm kiếm và xem thông tin chi tiết về các đầu sách có trong thư viện.

* ## **Mượn sách:**

  * Thực hiện thao tác mượn sách, bao gồm việc tạo, sửa, hoặc xóa phiếu mượn của chính mình.

* ## **Trả sách:**

  * Thực hiện thao tác trả sách.

  5. ## **Đặc tả Use-Case** {#đặc-tả-use-case}

     1. ## **UC-1: Đăng ký/Đăng nhập Hệ thống** {#uc-1:-đăng-ký/đăng-nhập-hệ-thống}

| Tiêu chí | Mô tả |
| ----: | ----- |
| **Tác nhân** | User, Quản trị viên. |

| Mô tả | Cho phép người dùng xác thực danh tính để truy cập vào các tính năng hệ thống. |
| :---- | :---- |
| **Sự kiện kích hoạt** | Người dùng mở ứng dụng và chọn "Đăng nhập" hoặc "Đăng ký". |
|  **Luồng sự kiện chính** | Hệ thống hiển thị màn hình Đăng nhập (login\_screen.dart). Người dùng nhập Email và Mật khẩu. Người dùng nhấn nút "Đăng nhập". Hệ thống gọi auth\_services.dart để xác thực với Firebase Authentication. Hệ thống xác thực thành công (UID hợp lệ). Hệ thống chuyển hướng người dùng đến màn hình Home. |
|  **Luồng sự kiện phụ** | A1. Đăng nhập thất bại: Hệ thống báo lỗi "Tên đăng nhập hoặc mật khẩu không đúng" (Sự kiện 5). A2. Đăng ký thành công (Đối với luồng Đăng ký): Người dùng nhập đủ thông tin và nhấn "Đăng ký". Hệ thống tạo tài khoản Firebase Auth và tạo Document người dùng trong Collection users. Hệ thống đăng nhập và chuyển hướng đến màn hình Home. A3. Quên mật khẩu: Người dùng nhấn "Quên mật khẩu" và làm theo hướng dẫn của Firebase để nhận email khôi phục. |
| **Hậu điều kiện** | Người dùng được xác thực và truy cập vào giao diện chức năng tương ứng với vai trò của họ. |
| **Yêu cầu đặc biệt** | Mật khẩu phải được mã hóa (handled by Firebase). Dữ liệu nhập phải được kiểm tra (validate) trước khi gửi đi. |

*Bảng 2: Bảng đặc tả chức năng Đăng ký/Đăng nhập.*

2. ## **UC-2: Quản lý Sách (Thêm, Sửa, Xóa)** {#uc-2:-quản-lý-sách-(thêm,-sửa,-xóa)}

| Tiêu chí | Mô tả |
| :---- | ----- |
| **Tác nhân** | Quản trị viên |
| **Mô tả** | Cho phép quản trị viên thêm sách mới, cập nhật thông tin và xóa sách khỏi kho. |
| **Sự kiện kích hoạt** | Quản trị viên truy cập màn hình Sách và nhấn nút "Thêm sách" hoặc chọn một sách để "Sửa/Xóa". |

|  Luồng sự kiện chính | Hệ thống hiển thị Form Thêm sách (add\_book\_screen.dart). Admin nhập các thông tin bắt buộc: Tên, Tác giả, Nhà xuất bản, Số lượng có sẵn (availableCount). Admin tải lên ảnh bìa sách (nếu có). Admin nhấn "Lưu". 5\. Hệ thống gọi book\_service.dart để tạo Document mới trong Collection books. 6\. Hệ thống hiển thị sách mới trong danh sách (book\_screen.dart). |
| :---- | :---- |
|  **Luồng sự kiện phụ** | A1. Sửa sách: 1\. Admin chọn sách và thay đổi thông tin trên Form. 2\. Hệ thống gọi book\_service.dart để cập nhật Document hiện có. A2. Xóa sách: 1\. Admin chọn sách và xác nhận Xóa. 2\. Hệ thống gọi book\_service.dart để xóa Document khỏi Collection books. A3. Thiếu thông tin bắt buộc: Hệ thống hiển thị thông báo lỗi và không cho phép lưu (trước Sự kiện 4). |
| **Hậu điều kiện** | Dữ liệu sách trong Collection books được cập nhật chính xác. |
| **Yêu cầu đặc biệt** | Ảnh bìa sách phải được lưu trữ trên dịch vụ bên ngoài (Cloudinary). |

*Bảng 3: Bảng đặc tả chức năng Quản lý sách*

3. ## **UC-3: Quản lý Phiếu Mượn (Thêm, Sửa, Xóa)** {#uc-3:-quản-lý-phiếu-mượn-(thêm,-sửa,-xóa)}

| Tiêu chí | Mô tả |
| :---- | ----- |
| **Tác nhân** | Quản trị viên |
| **Mô tả** | Ghi nhận việc User mượn sách, bao gồm việc tạo mới, sửa hoặc hủy phiếu mượn. |
| **Sự kiện kích hoạt** | Admin nhấn "Thêm phiếu mượn" hoặc tương tác với một phiếu mượn trong danh sách. |
|  **Luồng sự kiện chính** | Hệ thống hiển thị Form Thêm Phiếu Mượn. Admin chọn (các) Sách và nhập Số lượng mượn (quantity). Admin nhấn "Tạo phiếu mượn". Hệ thống gọi loan\_service.dart để tạo Document loan mới (kind: 'borrow'). Logic Atomic Update: Hệ thống đồng thời giảm số lượng availableCount của sách tương ứng trong Collection books. |

|  Luồng sự kiện phụ | A1. Sách không đủ số lượng: Hệ thống hiển thị cảnh báo và không cho phép tạo phiếu (trước Sự kiện 4). A2. Xóa phiếu mượn: Hệ thống xóa Document loan và hoàn trả số lượng availableCount cho sách. |
| :---- | :---- |
| **Hậu điều kiện** | Phiếu mượn được tạo trong Collection loans và số lượng sách trong Collection books được cập nhật chính xác. |
| **Yêu cầu đặc biệt** | Phải đảm bảo tính toàn vẹn dữ liệu (transaction) giữa việc tạo phiếu mượn và cập nhật số lượng sách. |

*Bảng 4: Bảng đặc tả chức năng Quản lý phiếu mượn.*

4. ## **UC-4: Quản lý Phiếu Trả** {#uc-4:-quản-lý-phiếu-trả}

| Tiêu chí | Mô tả |
| :---- | ----- |
| **Tác nhân** | Quản trị viên |
| **Mô tả** | Ghi nhận việc User trả sách và cập nhật lại số lượng sách trong kho. |
| **Sự kiện kích hoạt** | Admin nhấn "Thêm phiếu trả sách" (loan\_return\_screen.dart). |
|  **Luồng sự kiện chính** | Hệ thống hiển thị Form Thêm Phiếu Trả. Admin chọn phiếu trả. Hệ thống gọi loan\_service.dart để tạo Document loan mới (kind: 'return'). Logic Atomic Update: Hệ thống đồng thời tăng số lượng availableCount của sách tương ứng trong Collection books. |
| **Luồng sự kiện phụ** | A1. Lỗi nhập liệu: Hệ thống báo lỗi nếu số lượng sách trả không hợp lệ (ví dụ: lớn hơn số lượng đã mượn). |
| **Hậu điều kiện** | Phiếu trả được ghi nhận trong Collection loans và số lượng sách trong Collection books được tăng lên. |
| **Yêu cầu đặc biệt** | Phải đảm bảo tính toàn vẹn dữ liệu giữa việc tạo phiếu trả và cập nhật số lượng sách. |

*Bảng 5: Bảng đặc tả chức năng Quản lý phiếu trả.*

5. ## **UC-5: Quản lý Tài khoản Cá nhân** {#uc-5:-quản-lý-tài-khoản-cá-nhân}

| Tiêu chí | Mô tả |
| :---- | ----- |
| **Tác nhân** | User, Admin. |
| **Mô tả** | Cho phép User cập nhật thông tin cá nhân và quản lý thiết lập ứng dụng. |
| **Sự kiện kích hoạt** | Người dùng truy cập màn hình Cài đặt và chọn "Chỉnh sửa thông tin" hoặc "Thay đổi mật khẩu". |

|  Luồng sự kiện chính | Hệ thống hiển thị màn hình Cài đặt. Người dùng chọn "Chỉnh sửa thông tin". Người dùng cập nhật Tên, Ngày sinh, Giới tính, v.v. Người dùng nhấn "Lưu". Hệ thống gọi user\_services.dart để cập nhật Document User tương ứng trong Collection users. |
| :---- | :---- |
|  **Luồng sự kiện phụ** | A1. Thay đổi mật khẩu: Người dùng chọn "Thay đổi mật khẩu". Hệ thống yêu cầu mật khẩu cũ, mật khẩu mới và gọi Firebase Auth để cập nhật. A2. Bật/Tắt Thông báo: Người dùng chuyển đổi nút "Bật thông báo". Hệ thống lưu trạng thái tùy chọn này vào Document User. |
| **Hậu điều kiện** | Thông tin người dùng hoặc thiết lập cá nhân được cập nhật thành công. |
| **Yêu cầu đặc biệt** | Việc thay đổi mật khẩu phải được xác thực lại theo quy định của Firebase. |

*Bảng 6: Bảng đặc tả chức năng Quản lý tài khoản cá nhân.*

6. ## **UC-6: Thống kê** {#uc-6:-thống-kê}

**Tiêu chí	Mô tả**

**Tác nhân**	Quản trị viên

**Mô tả**	Cung cấp cái nhìn tổng quan về hoạt động của thư viện qua các chỉ số và biểu đồ báo cáo.

**Sự kiện kích hoạt**

**Luồng sự kiện chính**

**Luồng sự kiện phụ**

Admin truy cập màn hình Báo cáo (loan\_stats\_screen.dart hoặc tab Thống kê).

1. Hệ thống hiển thị màn hình Thống kê.

2. Hệ thống gọi loan\_service.dart để truy vấn dữ liệu từ Collection

loans.

3. Logic nghiệp vụ**:** loan\_service.dart xử lý dữ liệu để tính toán các chỉ số: \- Tổng số sách đang được mượn. – Tỉ lệ số phiếu mượn/trả trong kỳ.

4. Hệ thống hiển thị dữ liệu dưới dạng các widget số liệu và biểu đồ trực quan (ví dụ: biểu đồ cột, biểu đồ tròn).

A1. Lọc theo thời gian: Admin chọn khoảng thời gian (ngày, tháng, năm). Hệ thống thêm điều kiện lọc vào truy vấn Firestore để tính toán lại số liệu.

A2. Xuất báo cáo (Tùy chọn): Admin nhấn nút "Xuất báo cáo". Hệ thống tạo file (ví dụ: CSV/Excel) từ dữ liệu đã tính toán.

**Hậu điều kiện**

**Yêu cầu đặc biệt**

Admin nhận được thông tin tổng quan và chi tiết về hiệu suất hoạt động của thư viện trong một khoảng thời gian xác định.

Việc tính toán số liệu phải được tối ưu để tránh chi phí đọc Firestore cao (ví dụ: sử dụng chức năng tổng hợp dữ liệu nếu có).

*Bảng 7: Bảng đặc tả chức năng Thống kê.*

6. ## **Mô hình dữ liệu** {#mô-hình-dữ-liệu}

   1. ## **Tổng quan** {#tổng-quan}

Hệ thống sử dụng Firebase Firestore, một cơ sở dữ liệu NoSQL, linh hoạt và có khả năng mở rộng, để lưu trữ toàn bộ dữ liệu của ứng dụng. Cấu trúc dữ liệu được tổ chức theo dạng "Collection" (Bộ sưu tập) và "Document" (Tài liệu).

Dựa trên các hình ảnh cung cấp, mô hình dữ liệu của ứng dụng được xây dựng xoay quanh ba bộ sưu tập (collection) gốc chính:

1. **users**: Lưu trữ thông tin của user.

2. **books**: Lưu trữ danh mục các đầu sách có trong thư viện.

3. **loans**: Lưu trữ lịch sử các giao dịch mượn và trả sách.

   2. ## **Phân tích Chi tiết các Collection** {#phân-tích-chi-tiết-các-collection}

      1. **Collection users**

         * **Mục đích**: Quản lý thông tin tài khoản của các bạn đọc đăng ký sử dụng hệ thống.  
           * **ID Tài liệu (Document ID)**: Sử dụng uid (User ID) duy nhất do hệ thống Firebase Authentication cung cấp. Điều này giúp liên kết chặt chẽ giữa thông tin đăng nhập và dữ liệu người dùng.

           * ## **Cấu trúc Dữ liệu (Fields) của một Document:**

             * uid (String): Mã định danh duy nhất của người dùng (đồng bộ với uid của Authentication).

             * name (String): Họ và tên của người dùng (Ví dụ: "Ngo Van Quan").

             * e-mail (String): Địa  chỉ email dùng  để  đăng nhập (Ví  dụ:

      "[quan@gmail.com](mailto:quan@gmail.com)").

             * gender (String): Giới tính của người dùng (Ví dụ: "Nam").

             * birthday (String): Ngày sinh của người dùng (Ví dụ: "22/11/2004").

             * photoUrl (String): Đường dẫn URL đến ảnh đại diện của người dùng (có thể là chuỗi rỗng).

         2. ## **Collection books**

            * **Mục đích**: Xây dựng danh mục sách (catalog) của thư viện. Mỗi document đại diện cho một đầu sách.  
            * **ID Tài liệu (Document ID)**: Sử dụng ID ngẫu nhiên do Firestore tự động tạo.

            * ## **Cấu trúc Dữ liệu (Fields) của một Document:**

              * title (String): Tên/Tiêu đề của sách.

              * author (String): Tác giả của sách.

              * publisher (String): Nhà xuất bản.

              * year (String): Năm xuất bản.

              * availableCount (Number): Tổng số lượng sách của đầu sách này mà thư viện có.

              * imageUrl (String): Đường dẫn URL đến ảnh bìa của sách (sử dụng dịch vụ hosting ảnh như Cloudinary).

         3. ## **Collection loans**

            * **Mục đích**: Đây là collection quan trọng nhất, đóng vai trò như một "sổ cái" (ledger) ghi lại toàn bộ lịch sử giao dịch mượn và trả sách của thư viện.  
            * **ID Tài liệu (Document ID)**: Sử dụng ID ngẫu nhiên do Firestore tự động tạo. Mỗi document đại diện cho **một lần giao dịch** (mượn hoặc trả).

            * ## **Cấu trúc Dữ liệu (Fields) của một Document:**

              * userId (String): Mã uid của người dùng thực hiện giao dịch. Đây là khóa ngoại liên kết đến collection users.

              * date(Timestamp/String): Thời điểm giao dịch diễn ra.

              * kind (String): Loại giao dịch. Đây là trường quan trọng để phân biệt:

                * "borrow": Giao dịch mượn sách.

                * "return": Giao dịch trả sách.

              * \[items\] (Array of Maps): Một mảng (list) chứa các đối tượng (map), mỗi đối tượng là một cuốn sách trong lần giao dịch đó.

                * ## **Cấu trúc của một đối tượng sách trong mảng:**

                  * bookId (String): ID của sách được mượn/trả. Đây là khóa ngoại liên kết đến collection books. (Lưu ý:

            Trong ảnh chụp có lúc là id, có lúc là bookId, cần thống nhất).

                  * quantity (Number): Số lượng mượn/trả của đầu sách đó.  
                  * title (String): Tên sách (dữ liệu được *denormalize* \- sao chép từ collection books).

                  * imageUrl (String): URL ảnh bìa (dữ liệu cũng được

            *denormalize*).

      3. ## **Phân tích Luồng Dữ liệu và Mối quan hệ** {#phân-tích-luồng-dữ-liệu-và-mối-quan-hệ}

Mô hình này sử dụng các kỹ thuật NoSQL phổ biến để đảm bảo hiệu suất và tính toàn vẹn:

1. ## **Mối quan hệ (Relationships):**

   * **Users (1) \- (N) Loans:** Một người dùng (users) có thể có nhiều giao dịch (loans). Mối quan hệ này được thể hiện qua trường userId trong collection loans.

   * **Books (1) \- (N) Loans:** Một đầu sách (books) có thể xuất hiện trong nhiều giao dịch (loans). Mối quan hệ này được thể hiện qua trường bookId (hoặc id) bên trong mảng items của loans.

2. ## **Phi chuẩn hóa (Denormalization):**

   * Thay vì chỉ lưu bookId trong collection loans, hệ thống lưu trữ thêm cả title và imageUrl.

   * **Lợi ích**: Khi cần hiển thị "Lịch sử mượn sách" cho người dùng, ứng dụng chỉ cần truy vấn collection loans là có đủ thông tin (tên sách, ảnh bìa) để hiển thị, mà **không cần** thực hiện thêm các truy vấn tốn kém đến collection books để lấy về thông tin này.

3. ## **Logic tính toán số lượng sách (Application Logic):**

   * Mô hình này không lưu trữ *số lượng sách còn lại* trong collection books.

   * Thay vào đó, số lượng sách còn lại của một đầu sách (ví dụ: "Kỹ năng sống") phải được tính toán tại phía ứng dụng (client-side hoặc server-side) bằng cách:

4. ## **Thiết kế Giao diện Người dùng (UI/UX)** {#thiết-kế-giao-diện}

Đây là phần đóng góp chính của **Nguyễn Trung Hiếu (23011098)** – toàn bộ hệ thống giao diện được thiết kế và xây dựng với bảng màu ấm áp lấy cảm hứng từ không gian thư viện truyền thống (nâu gỗ, amber, cream), kết hợp ảnh minh họa thư viện thực tế.

### **3.1. Bảng màu chủ đề (Color Scheme)**

Toàn bộ ứng dụng sử dụng bảng màu ấm thống nhất, được định nghĩa trong `lib/configs/themes/color_scheme.dart`:

| Vai trò | Màu (Light Mode) | Màu (Dark Mode) |
| :---- | :---- | :---- |
| **Primary** (màu chính) | `#8B4513` – SaddleBrown (nâu gỗ) | `#FFB74D` – Amber-300 |
| **Secondary** (màu phụ) | `#D2691E` – Chocolate | `#FFCC80` – Amber-200 |
| **Surface** (nền card) | `#FFF8F0` – Warm Cream | `#1A0F00` – Deep Mahogany |
| **Tertiary** (màu thành công) | `#2E7D32` – Forest Green | `#81C784` – Green-300 |

Mục tiêu thiết kế: tạo cảm giác **ấm áp, thân thiện, học thuật** – đúng như không khí một thư viện truyền thống.

---

### **3.2. Màn hình Đăng nhập (login_screen.dart)**

**Đặc điểm thiết kế:**
- Sử dụng **ảnh minh hoạ thư viện** (`assets/images/library_banner.png`) làm nền toàn màn hình
- Phủ **gradient overlay nâu ấm** (`0xCC5C2A0D → 0xF55C2A0D`) để nổi bật form
- Form card màu **cream** (`#FFF8F0`) nổi bật trên nền tối
- Nút **Đăng nhập** (nền nâu `#8B4513`) + **Đăng ký** (viền nâu, nền trong suốt)
- Tích hợp nút 👁 **hiện/ẩn mật khẩu** (`_obscurePassword` state)

**Code mẫu – toggle ẩn/hiện mật khẩu:**
```dart
bool _obscurePassword = true;

// Trong widget TextFieldApp:
suffixIcon: IconButton(
  icon: Icon(
    _obscurePassword
        ? Icons.visibility_off_outlined
        : Icons.visibility_outlined,
    color: const Color(0xFF8B4513),
  ),
  onPressed: () =>
      setState(() => _obscurePassword = !_obscurePassword),
),
```

---

### **3.3. Màn hình Trang chủ (home_screen.dart)**

Trang chủ là màn hình trung tâm, tích hợp đầy đủ thông tin tổng quan:

**a. Header động với ảnh thư viện:**

```dart
SliverAppBar(
  expandedHeight: 210,
  flexibleSpace: FlexibleSpaceBar(
    background: Stack(
      children: [
        // Ảnh nền thư viện
        Image.asset('assets/images/library_banner.png', fit: BoxFit.cover),
        // Overlay gradient nâu ấm
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xCC5C2A0D), Color(0xDD8B4513)],
            ),
          ),
        ),
        // Hiển thị tên thủ thư từ Firebase Auth
        Text('Xin chào, $_displayName! 👋'),
      ],
    ),
  ),
)
```

**b. Tên thủ thư động** – lấy từ Firebase Authentication:
```dart
String get _displayName {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) return 'Thủ thư';
  final name = user.displayName ?? '';
  if (name.isNotEmpty) return name;
  return user.email?.split('@').first ?? 'Thủ thư';
}
```

**c. 3 thẻ thống kê thời gian thực** – lấy từ Firestore:

| Thẻ | Màu | Dữ liệu |
| :---- | :---- | :---- |
| Tổng sách | `#8B4513` | `BookService().getBooksOnce().length` |
| Phiếu mượn | `#D2691E` | `LoanService().getBorrowCount()` |
| Phiếu trả | `#2E7D32` | `LoanService().getReturnCount()` |

**d. Thanh tìm kiếm nhanh** – điều hướng sang tab Sách khi nhấn:
```dart
GestureDetector(
  onTap: () => widget.onTabSelected(1), // chuyển sang BookScreen
  child: Container(
    color: const Color(0xFFFFF3E0), // warm amber-50
    child: Row(children: [
      const Icon(Icons.search_rounded, color: Color(0xFF8B4513)),
      const Text('Tìm kiếm tên sách, tác giả...',
          style: TextStyle(color: Color(0xFF8B4513))),
    ]),
  ),
)
```

**e. Pull-to-Refresh** – vuốt xuống làm mới số liệu:
```dart
RefreshIndicator(
  onRefresh: _fetchCounts,
  child: CustomScrollView(...),
)
```

---

### **3.4. Màn hình Cài đặt (setting_screen.dart)**

**Cải tiến thiết kế:**
- Header sử dụng **ảnh thư viện làm nền** (giống trang chủ, đồng bộ giao diện)
- Thêm **nút ← Quay lại** (`Icons.arrow_back_ios_new_rounded`) sử dụng `Navigator.canPop()` để chỉ hiển thị khi có màn hình trước
- Màu sắc đồng bộ với bảng màu ấm (`#8B4513`)

```dart
leading: Navigator.canPop(context)
    ? IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded,
            color: Colors.white),
        onPressed: () => Navigator.pop(context),
      )
    : null,
```

---

### **3.5. Navigation Bar (Bottom Navigation)**

Bottom navigation bar 5 tab với hiệu ứng animation mượt mà:

| Tab | Icon | Màn hình |
| :---- | :---- | :---- |
| Trang chủ | `home_rounded` | `HomeTab` |
| Sách | `menu_book_rounded` | `BookScreen` |
| Dashboard | `dashboard_rounded` | `DashboardScreen` |
| Mượn | `receipt_long_rounded` | `LoanListScreen` |
| Trả | `assignment_return_rounded` | `LoanReturnScreen` |

Hiệu ứng khi chọn tab: nền tròn mờ màu primary + text đậm + icon đổi màu (animated).

---

### **3.6. Wireframe / Prototype – Thiết kế màn hình** {#wireframe-prototype}

Phần này trình bày bản **thiết kế giao diện (Wireframe/Mockup)** cho từng màn hình chính của ứng dụng trước khi tiến hành lập trình. Các bản vẽ thể hiện bố cục (layout), luồng điều hướng và vị trí các thành phần UI.

#### **Màn hình 1 – Đăng nhập / Đăng ký (Login Screen)**

Mô tả layout:
- Toàn màn hình: ảnh nền thư viện + overlay gradient nâu tối
- Form card màu cream nổi bật ở giữa
- Các trường nhập liệu: Email, Mật khẩu (có nút 👁 ẩn/hiện)
- Hai nút song song: **Đăng nhập** (filled) · **Đăng ký** (outlined)

![Wireframe màn hình Đăng nhập](assets/images/wireframe_login.png)

---

#### **Màn hình 2 – Trang chủ (Home Screen)**

Mô tả layout:
- **Header** (expandable): ảnh thư viện, tên thủ thư động, icon cài đặt
- **Thanh tìm kiếm nhanh**: nền cream, icon kính lúp màu nâu
- **Tổng quan**: 3 thẻ stat (Tổng sách · Mượn · Trả) — dữ liệu thời gian thực
- **Truy cập nhanh**: grid 4 icon chức năng
- **Chức năng**: danh sách 5 mục với badge số liệu và mũi tên điều hướng
- **Bottom Navigation**: 5 tab (Trang chủ · Sách · Dashboard · Mượn · Trả)

![Wireframe màn hình Trang chủ](assets/images/wireframe_home.png)

---

#### **Màn hình 3 – Quản lý Sách (Book Screen)**

Mô tả layout:
- AppBar với nút **Tìm kiếm** và nút **Thêm sách (+)**
- Ô tìm kiếm theo tên/tác giả
- Bộ lọc thể loại (filter chips ngang)
- Danh sách sách dạng card: ảnh bìa · tiêu đề · tác giả · số lượng · nút Sửa/Xoá

![Wireframe màn hình Quản lý Sách](assets/images/wireframe_books.png)

---

#### **Màn hình 4 – Quản lý Phiếu Mượn (Loan Screen)**

Mô tả layout:
- Header với tổng số phiếu mượn
- Danh sách phiếu mượn dạng card:
  - Tên độc giả · Danh sách sách mượn · Ngày mượn · Hạn trả
  - Badge trạng thái: **Đang mượn** (cam) / **Quá hạn** (đỏ)
  - Nút "Chi tiết" → màn hình `loan_detail_screen.dart`
- Nút **Thêm phiếu mượn (+)** góc trên phải

![Wireframe màn hình Phiếu Mượn](assets/images/wireframe_loan.png)

---

#### **Màn hình 5 – Cài đặt (Settings Screen)**

Mô tả layout:
- Header mở rộng: ảnh thư viện + avatar thủ thư + tên + email + nút đăng xuất
- **Nút ← Quay lại** góc trên trái (chỉ hiện khi navigate từ màn hình khác)
- Nhóm **Tài khoản**: Thông tin cá nhân · Đổi mật khẩu
- Nhóm **Ứng dụng**: Toggle Dark/Light Mode · Toggle Thông báo
- Nhóm **Hệ thống**: Phiên bản · Đăng xuất

![Wireframe màn hình Cài đặt](assets/images/wireframe_settings.png)

---

#### **Luồng điều hướng tổng thể (Navigation Flow)**

```
[Màn hình Đăng nhập]
        │ Đăng nhập thành công
        ▼
[Trang chủ] ──── Bottom Nav ────► [Quản lý Sách]
    │                                    │
    │                              [Thêm/Sửa Sách]
    │
    ├──── Bottom Nav ────► [Dashboard / Thống kê]
    │
    ├──── Bottom Nav ────► [Phiếu Mượn]
    │                           │
    │                     [Chi tiết Phiếu Mượn]
    │
    ├──── Bottom Nav ────► [Phiếu Trả]
    │
    └──── Settings icon ─► [Cài đặt]
                                │
                          [Thông tin cá nhân]
                          [Đổi mật khẩu]
```

---

4. ## **Mã nguồn chính và giao diện Demo** {#mã-nguồn-chính-và-giao-diện-demo}

1. Lấy availableCount (tổng số lượng) từ document của sách đó (ví dụ: 30).

2. Truy vấn **tất cả** document trong loans có bookId của sách đó.

3. Tính Tổng số sách đã mượn \= SUM(quantity) của các loans có kind: "borrow".  
4. Tính Tổng số sách đã trả \= SUM(quantity) của các loans có kind: "return".  
5. **Số lượng còn lại \= (Tổng số lượng) \- (Tổng mượn) \+ (Tổng trả)**.

Mô hình dữ liệu được thiết kế rõ ràng, chia tách rành mạch giữa ba đối tượng chính: Người dùng, Sách, và Giao dịch. Việc sử dụng collection loans làm sổ cái giao dịch và áp dụng kỹ thuật phi chuẩn hóa (denormalization) là một lựa chọn thiết kế tốt, giúp tối ưu hóa hiệu suất đọc dữ liệu cho các tính năng nghiệp vụ cốt lõi như xem lịch sử mượn/trả.

7. ## **Thiết kế kiến trúc hệ thống** {#thiết-kế-kiến-trúc-hệ-thống}

   1. ## **Tổng quan** {#tổng-quan-1}

Ứng dụng Quản lý Thư viện được xây dựng trên nền tảng **Flutter**, một framework UI đa nền tảng của Google, cho phép phát triển ứng dụng cho di động (Android, iOS), web và desktop từ một cơ sở mã nguồn duy nhất.

Kiến trúc hệ thống được thiết kế theo Mô hình Phân lớp (Layered Architecture) rõ ràng, nhằm mục đích tách biệt các mối quan tâm (Separation of Concerns). Điều này giúp mã nguồn trở nên dễ bảo trì, dễ mở rộng và dễ kiểm thử hơn.  
Các tầng chính của kiến trúc bao gồm:

1. **Tầng Trình diễn (Presentation Layer):** Giao diện người dùng (UI) và logic UI.  
2. **Tầng Nghiệp vụ (Business Logic Layer):** Xử lý logic nghiệp vụ và quản lý trạng thái.

3. **Tầng Dịch vụ (Service Layer):** Giao tiếp với các dịch vụ bên ngoài (Backend).  
4. **Tầng Dữ liệu (Data Layer):** Định nghĩa mô hình dữ liệu và nguồn dữ liệu.

   2. ## **Sơ đồ Kiến trúc Tổng thể** {#sơ-đồ-kiến-trúc-tổng-thể}

Kiến trúc của ứng dụng có thể được mô tả trực quan như sau:

*Hình 3: Sơ đồ kiến trúc tổng thể.*

3. ## **Phân tích Chi tiết các Thành phần** {#phân-tích-chi-tiết-các-thành-phần}

Nhằm đảm bảo tính logic, gọn gàng, dễ nâng cấp hệ thống, các thành phần được tổ chức như sau:

1. ## **Tầng Trình diễn (Presentation Layer)**

Đây là tầng chịu trách nhiệm hiển thị giao diện và tương tác trực tiếp với người dùng.

* **lib/screens**: Chứa các "trang" hoàn chỉnh của ứng dụng. Mỗi tệp .dart đại diện cho một màn hình. Các màn hình này gọi đến các services để lấy hoặc gửi dữ liệu.

*Hình 4: Cấu trúc tệp screens.*

* **lib/widgets**: Chứa các thành phần UI (widget) có thể tái sử dụng trên nhiều màn hình khác nhau (ví dụ: nút bấm tùy chỉnh, thẻ hiển thị thông tin sách, ô nhập liệu...).

  ![A black background with white text  AI-generated content may be incorrect.][image2]

  *Hình 5: Cấu trúc tệp Widgets.*

  * **lib/configs/themes**: Định nghĩa giao diện, màu sắc, phông chữ và các hằng số liên quan đến thiết kế.

    ![A screenshot of a computer  AI-generated content may be incorrect.][image3]

    *Hình 6: Cấu trúc tệp Themes.*

    2. ## **Quản lý Trạng thái (State Management)**

       * **lib/services/theme\_provider.dart**: Tệp này cho thấy ứng dụng đang sử dụng một giải pháp quản lý trạng thái (như **Provider** hoặc **Riverpod**) để quản lý trạng thái toàn cục của ứng dụng, cụ thể ở đây là việc thay đổi giao

  diện (theme). Logic tương tự có thể được áp dụng để quản lý trạng thái đăng nhập của người dùng.

       3. ## **Tầng Nghiệp vụ & Dịch vụ (Business Logic & Service Layer)**

Đây là "bộ não" của ứng dụng, nằm giữa UI và Backend. Tầng này được đóng gói hoàn toàn trong thư mục **lib/services**.

* **Mục đích**: Tách biệt logic xử lý dữ liệu ra khỏi UI. UI chỉ cần "gọi" một hàm (ví dụ: borrowBook()) mà không cần biết chi tiết hàm đó kết nối đến Firebase như thế nào.

  * **auth\_services.dart**: Chịu trách nhiệm cho tất cả các nghiệp vụ liên quan đến xác thực người dùng (Đăng nhập, Đăng ký, Đăng xuất) bằng **Firebase Authentication**.  
    * **user\_services.dart**: Quản lý thông tin người dùng trong **Firestore** (Tạo, Đọc, Cập nhật thông tin hồ sơ người dùng trong collection users).  
      * **book\_service.dart**: Quản lý các nghiệp vụ liên quan đến sách (Lấy danh sách sách, thêm, sửa, xóa sách) từ collection books trên Firestore.

        * **loan\_service.dart**: Quản lý các nghiệp vụ mượn/trả sách. Đây là nơi xử lý logic chính của ứng dụng, tạo ra các document trong collection loans.  
        * **cloudinary\_service.dart**: Một dịch vụ chuyên biệt để xử lý việc tải ảnh (ví dụ: ảnh bìa sách, ảnh đại diện) lên dịch vụ lưu trữ **Cloudinary**.  
        * **dialog\_service.dart**: Một dịch vụ tiện ích để hiển thị các hộp thoại thông báo, xác nhận một cách nhất quán trong toàn ứng dụng.

      4. ## **Tầng Dữ liệu (Data Layer)**

Tầng này định nghĩa cấu trúc dữ liệu và nguồn dữ liệu.

* **lib/models**: Chứa các lớp mô hình (Data Models) như book\_model.dart, user\_model.dart, loan\_model.dart. Các lớp này định nghĩa cấu trúc dữ liệu của đối tượng (ví dụ: sách có title, author...) và cung cấp các phương thức để chuyển đổi dữ liệu từ/sang JSON (hoặc Map) để làm việc với Firestore.

  * ## **Backend Services (Dịch vụ Backend)**:

    * **Firebase Firestore**: Cơ sở dữ liệu NoSQL, là nơi lưu trữ chính cho các collection users, books, và loans.

      * **Firebase Authentication**: Dịch vụ quản lý định danh người dùng.

        * **Cloudinary**: Dịch vụ lưu trữ và phân phối hình ảnh.

        * **firebase\_options.dart**: Tệp cấu hình do FlutterFire tạo ra để kết nối ứng dụng Flutter với dự án Firebase trên cloud.

      5. ## **Tiện ích chung (Common & Configs)**

         * **lib/common**: Chứa các mã nguồn dùng chung, tiện ích (helpers), hoặc các hàm mở rộng (extensions) giúp mã nguồn ngắn gọn và dễ đọc hơn (ví dụ: extentions.dart).

         * **lib/configs/assets**: Quản lý đường dẫn đến các tài nguyên tĩnh như hình ảnh, font chữ.

# **CHƯƠNG 3\. TRIỂN KHAI VÀ ĐÁNH GIÁ** {#chương-3.-triển-khai-và-đánh-giá}

1. ## **Môi trường và phát triển** {#môi-trường-và-phát-triển}

Để xây dựng ứng dụng Quản lý thư viện, chúng tôi đã lựa chọn những công nghệ hiện đại, đa nền tảng và có khả năng mở rộng cao.

1. ## **Công cụ Lập trình và Nền tảng Ứng dụng** {#công-cụ-lập-trình-và-nền-tảng-ứng-dụng}

| Thành phần | Công nghệ / Ngôn ngữ | Vai trò chính |
| :---- | :---- | ----- |
| Framework | Flutter | Xây dựng giao diện người dùng (Front-end) đa nền tảng. |
| Ngôn ngữ | Dart | Ngôn ngữ chính, được tối ưu cho Flutter, giúp phát triển nhanh chóng. |
| IDE | Visual Studio Code (VS Code) | Môi trường phát triển tích hợp chính, hỗ trợ tốt cho Dart và Flutter. |
| Hệ điều hành | Windows / macOS | Môi trường phát triển và Debug. |

*Bảng 8: Công cụ Lập trình và Nền tảng ứng dụng.*

2. ## **Công nghệ Backend và Cơ sở Dữ liệu** {#công-nghệ-backend-và-cơ-sở-dữ-liệu}

Ứng dụng sử dụng kiến trúc **Serverless** thông qua nền tảng **Google Firebase**, giúp giảm thiểu chi phí và thời gian quản lý máy chủ.

| Dịch vụ Firebase | Tên gọi chi tiết | Vai trò trong hệ thống |
| :---- | :---- | :---- |
| Xác thực | Firebase Authentication | Quản lý đăng nhập, đăng ký và xác thực người dùng (Bạn đọc & Admin). |
| Database | Cloud Firestore | Cơ sở dữ liệu NoSQL, lưu trữ dữ liệu chính. Hỗ trợ truy vấn thời gian thực (Real-time). |

| Lưu trữ ảnh | Cloudinary | Lưu trữ và phân phối hình ảnh hiệu quả (ảnh bìa sách, ảnh đại diện). |
| :---- | :---- | :---- |

*Bảng 9: Công nghệ Backend và Cơ sở dữ liệu.*

3. ## **Công cụ Hỗ trợ và Quản lý Dự án** {#công-cụ-hỗ-trợ-và-quản-lý-dự-án}

| Công cụ / Thư viện | Tác dụng |
| :---- | ----- |
| Quản lý Trạng thái | Provider / Riverpod (Dựa trên cấu trúc code) |
| Quản lý Package | pubspec.yaml (Dart Pub) |
| Quản lý Code | Git |
| Testing | Flutter Test (Widget & Unit Tests) |

*Bảng 10: Công cụ và Thư viện hỗ trợ.*

2. ## **Cấu trúc thư mục mã nguồn** {#cấu-trúc-thư-mục-mã-nguồn}

   *Hình 7: Cấu trúc thư mục mã nguồn*

Ứng dụng được tổ chức theo kiến trúc phân tầng (Layered Architecture), tuân thủ nguyên tắc trách nhiệm duy nhất (Single Responsibility Principle \- SRP). Điều này giúp mã nguồn dễ đọc, dễ bảo trì và dễ mở rộng.

3. ## **Mã nguồn chính và giao diện Demo** {#mã-nguồn-chính-và-giao-diện-demo}

   1. ## **Xử lý Đăng nhập** {#xử-lý-đăng-nhập}

      **Ứng dụng chỉ hỗ trợ Đăng nhập** (không có chức năng tự đăng ký). Tài khoản thủ thư do quản trị viên cấp phát qua Firebase Console.

// Đăng ký tài khoản mới và tạo document trong Firestore Future\<User?\> signUpWithEmail({  
required String email, required String password,  
}) async { try {  
// Đăng ký với Firebase Auth

UserCredential result \= await \_auth.createUserWithEmailAndPassword( email: email,  
password: password,

);

final user \= result.user; if (user \!= null) {  
// Tạo model user mặc định final newUser \= AppUser( uid: user.uid,  
name: '', email: email, birthday: '',  
gender: '',

photoUrl: '',

);

// Lưu vào collection 'users'

await \_firestore.collection('users').doc(user.uid).set(newUser.toMap());

}

return user;

} on FirebaseAuthException catch (e) { print('Lỗi đăng ký: ${e.message}'); return null;  
}

}

2. ## **Giao diện:**

   *Hình 8: Giao diện đăng ký.*

   2. ## **Đăng nhập:**

1. **Code chính**

*/// Đăng nhập với email và mật khẩu* Future\<User?\> signInWithEmail({ required String email,

required String password,

}) async { try {

UserCredential result \= await \_auth.signInWithEmailAndPassword( email: email,  
password: password,

);

return result.user;

} on FirebaseAuthException catch (e) { print('Lỗi đăng nhập: ${e.message}'); return null;  
}

}

**Code chính:**

```dart
/// Đăng nhập với email và mật khẩu
Future<User?> signInWithEmail({
  required String email,
  required String password,
}) async {
  try {
    UserCredential result = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return result.user;
  } on FirebaseAuthException catch (e) {
    print('Lỗi đăng nhập: ${e.message}');
    return null;
  }
}
```

**Giao diện Đăng nhập:**
- Nền: Ảnh minh hoạ thư viện (library_banner.png) với overlay gradient nâu ấm
- Form card màu cream (#FFF8F0) nổi bật trên nền ảnh
- Có chức năng hiện/ẩn mật khẩu (👁)
- Chỉ có 1 nút **Đăng nhập** (màu nâu gỗ #8B4513)
- Không có nút Đăng ký

*Hình 9: Giao diện Đăng nhập.*

2. ## **Quản lý sách** {#quản-lý-sách}

**// book\_model.dart**

factory BookModel.fromJson(Map\<String, dynamic\> json, String id) { return BookModel(  
id: id,

title: json\['title'\] ?? '',

author: json\['author'\] ?? '',

publisher: json\['publisher'\] ?? '',

year: json\['year'\] ?? '',

imageUrl: json\['imageUrl'\] ?? '', availableCount: json\['availableCount'\] ?? 0,  
);

}

Map\<String, dynamic\> toJson() { return {  
'title': title, 'author': author,  
'publisher': publisher, 'year': year,

'imageUrl': imageUrl, 'availableCount': availableCount,  
};

}

}

**// book\_service.dart**

class BookService {

final CollectionReference \_books \= FirebaseFirestore.*instance*.collection( 'books',  
);

Future\<List\<BookModel\>\> getBooksOnce() async { final snapshot \= await \_books.get();  
return snapshot.docs

.map( (doc) \=\>  
BookModel.fromJson(doc.data() as Map\<String, dynamic\>, doc.id),

)

.toList();

}

Future\<void\> addBook(BookModel book) async { await \_books.add(book.toJson());  
}

Future\<void\> updateBook(BookModel book) async { await \_books.doc(book.id).update(book.toJson());  
}

Future\<void\> deleteBook(String id) async { await \_books.doc(id).delete();

}

Stream\<List\<BookModel\>\> getBooks() { return \_books.snapshots().map((snapshot) { return snapshot.docs  
.map( (doc) \=\>  
BookModel.fromJson(doc.data() as Map\<String, dynamic\>, doc.id),

});

}

}

)

.toList();

## **b. Giao diện chính:**

*Hình 10: Giao diện Quản lý sách.*

3. ## **Quản lý phiếu mượn/trả** {#quản-lý-phiếu-mượn/trả}

1. **Code chính:**

**// loan\_model.dart**

Map\<String, dynamic\> toJson() { return {  
'userId': userId, 'type': type,

'date': Timestamp.fromDate(date), 'books': books,  
};

}

LoanModel copyWith({ String? id,  
String? userId, String? type, DateTime? date,  
List\<Map\<String, dynamic\>\>? books,

}) {

return LoanModel( id: id ?? this.id,

userId: userId ?? this.userId, type: type ?? this.type,  
date: date ?? this.date, books: books ?? this.books,  
);

}

factory LoanModel.fromJson(Map\<String, dynamic\> json, String id) { return LoanModel(  
id: id,

userId: json\['userId'\] ?? '',

type: json\['type'\] ?? 'borrow',

date: (json\['date'\] as Timestamp).toDate(),

books: List\<Map\<String, dynamic\>\>.from(json\['books'\] ?? \[\]),

);

}

}

extension LoanModelExtension on LoanModel {

*/// Tổng số sách đã gộp các cuốn trùng nhau*

int get totalBooks {

final Map\<String, int\> bookMap \= {};

for (var b in books) {

final title \= b\["title"\] as String; final quantity \= b\["quantity"\] as int;  
bookMap\[title\] \= (bookMap\[title\] ?? 0\) \+ quantity;

}

return bookMap.values.fold(0, (s, qty) \=\> s \+ qty);

}

}

**// loan\_service.dart**

class LoanService {

final \_loans \= FirebaseFirestore.*instance*.collection('loans');

Future\<void\> addLoan(LoanModel loan) async { await \_loans.add(loan.toJson());  
}

Future\<void\> updateLoan(LoanModel loan) async { await \_loans.doc(loan.id).update(loan.toJson());  
}

Future\<void\> deleteLoan(String id) async { await \_loans.doc(id).delete();  
}

Stream\<List\<LoanModel\>\> getLoans(String type) { return \_loans  
.where('type', isEqualTo: type)

.orderBy('date', descending: true)

.snapshots()

.map(

(snapshot) \=\> snapshot.docs

.map((doc) \=\> LoanModel.fromJson(doc.data(), doc.id))

.toList(),

);

}

Future\<List\<LoanModel\>\> getLoansOnce(String type) async { final snapshot \= await \_loans.where('type', isEqualTo: type).get(); return snapshot.docs  
.map((doc) \=\> LoanModel.fromJson(doc.data(), doc.id))

.toList();

}

Future\<LoanModel?\> getLoanById(String id) async { try {  
final doc \= await \_loans.doc(id).get(); if (doc.exists) {  
return LoanModel.fromJson(doc.data() as Map\<String, dynamic\>, id);

}

return null;

} catch (e) {

print('Lỗi khi lấy loan theo ID: $e'); return null;  
}

}

Future\<void\> updateLoanType(String id, String newType) async { try {  
await \_loans.doc(id).update({'type': newType});

} catch (e) {

print('Lỗi khi cập nhật type: $e');

}

}

Future\<int\> getBorrowCount() async { QuerySnapshot snapshot \= await \_loans  
.where('type', isEqualTo: 'borrow')

.get();

return snapshot.size;

}

Future\<int\> getReturnCount() async { QuerySnapshot snapshot \= await \_loans  
.where('type', isEqualTo: 'return')

.get();

return snapshot.size;

}

}

2. ## **Giao diện chính:**

*Hình 11: Giao diện Quản lý phiếu mượn.*

*Hình 12: Giao diện Quản lý phiếu trả.*

4. ## **Thống kê** {#thống-kê}

1. **Code chính**

// Biểu đồ tròn

Widget buildPieChart() {

final total \= borrowList.length \+ returnList.length; if (total \== 0\) {  
return const Padding( padding: EdgeInsets.all(20),  
child: Text('Không có dữ liệu thống kê.'),

);

}

final data \= \[

\_ChartData('Mượn', borrowList.length.toDouble(), Colors.*blue*),

\_ChartData('Trả', returnList.length.toDouble(), Colors.*green*),

\];

return SfCircularChart( title: ChartTitle(  
text: 'Tỷ lệ Phiếu Mượn/Trả',

textStyle: const TextStyle(fontWeight: FontWeight.*bold*, fontSize: 16),

),

legend: const Legend(isVisible: true, position: LegendPosition.bottom), series: \<CircularSeries\>\[

PieSeries\<\_ChartData, String\>( dataSource: data,  
xValueMapper: (\_ChartData d, \_) \=\> d.label, yValueMapper: (\_ChartData d, \_) \=\> d.value, pointColorMapper: (\_ChartData d, \_) \=\> d.color, dataLabelMapper: (\_ChartData d, \_) \=\>  
'${d.label}: ${(d.value / total \* 100).toStringAsFixed(1)}%', dataLabelSettings: const DataLabelSettings(isVisible: true), explode: true,  
explodeIndex: 0,

),

\],

);

}

2. ## **Giao diện chính:**

*Hình 13: Giao diện Thống kê phiếu Mượn/Trả.*

5. ## **Setting** {#setting}

1. **Code chính:**

class UserService {

final FirebaseAuth \_auth \= FirebaseAuth.*instance*;

final FirebaseFirestore \_firestore \= FirebaseFirestore.*instance*;

User? get currentUser \=\> \_auth.currentUser;

*/// Lấy thông tin người dùng hiện tại* Future\<AppUser?\> getCurrentUser() async { final user \= \_auth.currentUser;  
if (user \== null) return null;

final doc \= await \_firestore.collection('users').doc(user.uid).get(); if (doc.exists) {

return AppUser.fromMap(doc.data()\!);

} else {

// Tạo mới user trong Firestore nếu chưa có final newUser \= AppUser(  
uid: user.uid,

name: user.displayName ?? '', email: user.email ?? '', photoUrl: user.photoURL ?? '', birthday: '',  
gender: '',

);

await \_firestore.collection('users').doc(user.uid).set(newUser.toMap()); return newUser;  
}

}

Future\<String\> getUserName(String userId) async { try {  
final doc \= await \_firestore.collection('users').doc(userId).get(); if (doc.exists) {

final data \= doc.data();

return data?\['name'\] ?? 'Không rõ';

}

return 'Không rõ';

} catch (e) {

return 'Không rõ';

}

}

*/// Cập nhật thông tin user*

Future\<void\> updateUser(AppUser user) async {

await \_firestore.collection('users').doc(user.uid).update(user.toMap());

}

*/// Đăng xuất*

Future\<void\> signOut() async { await \_auth.signOut();  
}

}

2. ## **Giao diện chính:**

*Hình 14: Giao diện Setting.*

6. **Cấu trúc tệp pubspec.yaml** name: library\_management\_app description: "A new Flutter project." publish\_to: 'none'

version: 0.1.0

environment:

sdk: ^3.8.1

dependencies: flutter:  
sdk: flutter firebase\_core: ^4.2.0 firebase\_auth: ^6.1.1 cloud\_firestore: ^6.0.3 image\_picker: ^1.2.0

http: ^1.5.0 uuid: ^4.5.1 intl: ^0.20.2  
provider: ^6.1.5+1 syncfusion\_flutter\_charts: ^31.1.19

dev\_dependencies:

flutter\_test:

sdk: flutter flutter\_lints: ^5.0.0

flutter:

uses-material-design: true assets:

- assets/

- assets/images/

# **CHƯƠNG 4\. KẾT LUẬN VÀ HƯỚNG PHÁT TRIỂN** {#chương-4.-kết-luận-và-hướng-phát-triển}

1. ## **Kết luận Dự án** {#kết-luận-dự-án}

Sau thời gian nghiên cứu và thực hiện, nhóm đã hoàn thành đề tài “Ứng dụng Quản lý Thư viện” sử dụng Flutter làm công nghệ phát triển giao diện và Firebase làm nền tảng lưu trữ dữ liệu và xác thực người dùng.

Ứng dụng đã triển khai thành công đầy đủ các chức năng chính:

1. **Đăng ký / Đăng nhập** bằng Firebase Authentication.

2. **Quản lý Sách:** thêm, sửa, xóa, tìm kiếm dữ liệu.

3. **Phiếu Mượn:** cho phép người dùng tạo phiếu mượn mới.

4. **Phiếu Trả:** xử lý trạng thái trả và cập nhật dữ liệu.

5. **Thống kê:** hiển thị biểu đồ cột và tròn trực quan.

6. **Cài đặt (Settings):** quản lý thông tin tài khoản, đổi mật khẩu, chuyển chế độ sáng – tối.

Nhờ ứng dụng Flutter, quá trình phát triển diễn ra nhanh chóng, giao diện hiện đại và tương thích đa nền tảng. Firebase đã giúp nhóm loại bỏ nhu cầu xây dựng server riêng, đồng thời cung cấp hệ thống xác thực và cơ sở dữ liệu realtime mạnh mẽ.

Về tổng thể, ứng dụng đạt được các mục tiêu ban đầu:

* Hoạt động ổn định trên máy ảo Android Studio.

  * Dữ liệu người dùng, sách, phiếu mượn và trả được lưu trữ và đồng bộ trên đám mây.

  * Giao diện thân thiện, dễ thao tác.

Đồ án giúp nhóm hiểu sâu hơn về:

* Kiến trúc Flutter (StatefulWidget, StreamBuilder, Provider).

  * Cách tích hợp Firebase Authentication và Firestore.

  * Quy trình phát triển một ứng dụng hoàn chỉnh từ phân tích – thiết kế – lập trình – kiểm thử – triển khai.

  2. ## **Hướng phát triển trong tương lai** {#hướng-phát-triển-trong-tương-lai}

Nhóm dự kiến mở rộng ứng dụng “Quản lý Thư viện” với các tính năng nâng cao sau nhằm hoàn thiện tính thương mại và khả năng vận hành thực tế:

1. ## **Phân quyền người dùng (Admin/User)** {#phân-quyền-người-dùng-(admin/user)}

   * Triển khai logic phân quyền dựa trên trường role trong collection users và sử dụng Firebase Security Rules.

     * Người dùng chỉ được phép mượn, trả và xem thống kê cá nhân.

     2. ## **Thông báo đẩy (Push Notification)** {#thông-báo-đẩy-(push-notification)}

        * Tích hợp Firebase Cloud Messaging (FCM) để gửi thông báo khi đến hạn trả sách.

     3. ## **Quản lý danh mục sách nâng cao** {#quản-lý-danh-mục-sách-nâng-cao}

        * Phân loại sách theo chủ đề, thể loại chi tiết hơn.

        * Cung cấp bộ lọc nâng cao (lọc theo tác giả, NXB, năm phát hành).

     4. ## **Tích hợp quét mã QR** {#tích-hợp-quét-mã-qr}

        * Gán mã QR riêng cho mỗi quyển sách.

        * Người dùng và thủ thư có thể mượn/trả sách bằng cách quét mã qua camera, tăng tốc độ xử lý giao dịch.

     5. ## **Triển khai đa nền tảng (Web và iOS)** {#triển-khai-đa-nền-tảng-(web-và-ios)}

        * Tận dụng khả năng của Flutter để build app cho Web và iOS, mở rộng phạm vi tiếp cận của ứng dụng.

     6. ## **Cải thiện giao diện và trải nghiệm người dùng (UI/UX)** {#cải-thiện-giao-diện-và-trải-nghiệm-người-dùng-(ui/ux)}

        * Sử dụng các tiêu chuẩn Material 3 để làm UI chuyên nghiệp hơn.

        * Tăng khả năng tùy chỉnh theme, font, và icon.

     7. ## **Đồng bộ dữ liệu ngoại tuyến (Offline Support)** {#đồng-bộ-dữ-liệu-ngoại-tuyến-(offline-support)}

        * Triển khai khả năng lưu trữ cục bộ để cho phép người dùng sử dụng khi không có mạng, sau đó tự động đồng bộ khi có kết nối lại.

# **TÀI LIỆU THAM KHẢO** {#tài-liệu-tham-khảo}

1. Google Flutter Documentation – [https://docs.flutter.dev](https://docs.flutter.dev/)

2. Firebase Documentation – [https://firebase.google.com/docs](https://firebase.google.com/docs)

3. Stack Overflow – Flutter/Firebase Q\&A Community

4. Nguyễn Đức Dũng (2022). *Giáo trình Lập trình Flutter căn bản*. NXB Bách Khoa Hà Nội.

5. Medium Articles – *Flutter State Management and Provider*.

[image1]: <data:image/png;base64,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>

[image2]: <data:image/png;base64,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>

[image3]: <data:image/png;base64,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>