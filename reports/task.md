# KẾ HOẠCH & TIẾN ĐỘ BÀI TẬP LỚN CUỐI KỲ - LỚP N03

> [!IMPORTANT]  
> **CÁC MỐC THỜI GIAN QUAN TRỌNG:**
> 1. **Nộp bản mềm (PDF) trên Canvas:** Hạn cuối trước **23:59 ngày 13/06/2026**.
> 2. **Nộp bản cứng tại phòng Giáo viên:** Hạn cuối trước **10:00 sáng ngày 18/06/2026** (Tầng 23, nhà A9, phòng 2310). *Lưu ý: Phải ký tên vào danh sách nộp bài trên bàn giáo viên.*

---

## 📋 DANH SÁCH YÊU CẦU ĐỀ THI & TIẾN ĐỘ

### PHẦN 1: BÁO CÁO & THIẾT KẾ THUYẾT TRÌNH (10 CÂU HỎI)

- [x] **Câu 1 [1 điểm] - User Stories (Câu chuyện người dùng):** 
  - *Mô tả:* Trình bày rõ các câu chuyện người dùng xoay quanh vai trò "Thủ thư" (Đăng nhập, Quản lý sách, Tạo phiếu mượn/trả, Xem thống kê dashboard).
  - *Trạng thái:* Đã hoàn thành (Có chi tiết trong `App_library.md` và `README.md`).
- [x] **Câu 2 [1 điểm] - Phân tích yêu cầu & Thiết kế đối tượng:**
  - *Mô tả:* Xác định các đối tượng chính (`AppUser`, `BookModel`, `LoanModel`), thuộc tính, phương thức và mối quan hệ (1-N, N-N thông qua denormalization).
  - *Trạng thái:* Đã hoàn thành (Có chi tiết trong `App_library.md` và `README.md`).
- [x] **Câu 3 [1 điểm] - Sơ đồ UML (Class Diagram & Sequence/Activity Diagrams):**
  - *Mô tả:* Ít nhất 01 sơ đồ Class Diagram và 05 sơ đồ thuật toán (Sequence hoặc Activity).
  - *Trạng thái:* Đã vẽ và đưa vào báo cáo `App_library.md`.
- [x] **Câu 4 [1 điểm] - Thiết kế màn hình (Screens Design / Mockup Figma / Flow of Work):**
  - *Mô tả:* Thiết kế giao diện và mô tả luồng hoạt động giữa các màn hình trong ứng dụng.
  - *Trạng thái:* Đã hoàn thành (Có chi tiết trong `App_library.md` và `README.md`).
- [x] **Câu 5 [1 điểm] - Thực hiện layout/màn hình mẫu (IMG_5518.PNG):**
  - *Mô tả:* Code giao diện màn hình mẫu theo yêu cầu đặc biệt của giảng viên.
  - *Trạng thái:* Đã triển khai giao diện và đối sánh trong báo cáo.
- [x] **Câu 6 [1 điểm] - Thực hiện (code) câu chuyện người dùng của Câu 1:**
  - *Mô tả:* Phát triển đầy đủ các tính năng đã đặc tả ở Câu 1 trên Flutter.
  - *Trạng thái:* Đã code hoàn thiện trong thư mục `lib/`.
- [x] **Câu 7 [1 điểm] - Kết nối cơ sở dữ liệu & ORM với Firebase Firestore:**
  - *Mô tả:* Áp dụng các phương thức `fromJson`/`toJson` để mapping document từ Firestore sang Object.
  - *Trạng thái:* Đã triển khai chuẩn chỉnh trong các model và service của Flutter.
- [x] **Câu 8 [1 điểm] - Kiểm thử và Kiểm định (Unit Test & Exception Handling):**
  - *Mô tả:* Xử lý bắt lỗi ngoại lệ trong app và viết các đơn vị kiểm thử (Unit test) cho các model.
  - *Trạng thái:* Đã viết 3 file test trong thư mục `test/` (`book_model_test.dart`, `loan_model_test.dart`, `user_model_test.dart`). Tất cả test đều passed.
- [x] **Câu 9 [1 điểm] - Báo cáo bản cứng & Liên kết dự án:**
  - *Mô tả:* Trình bày báo cáo theo mẫu ĐH Phenikaa, có link GitHub, link demo và bảng phân công đóng góp.
  - *Trạng thái:* Đã cập nhật đầy đủ trong `App_library.md`, `README.md` và slide thuyết trình.
- [x] **Câu 10 [1 điểm] - Lịch sử commit trên Git của các thành viên:**
  - *Mô tả:* Minh chứng lịch sử commit rõ ràng thể hiện sự đóng góp của từng sinh viên.
  - *Trạng thái:* Đã push code lên nhánh `giao-dien` với lịch sử commit rõ ràng.

---

## ⚠️ ĐIỀU KIỆN ĐỂ TRÁNH ĐIỂM 0 (BẮT BUỘC)

- [ ] **Nộp file PDF báo cáo trên Canvas đúng hạn** (Trước 23:59 ngày 13/06/2026).
- [ ] **Nộp bản cứng báo cáo tại phòng 2310 nhà A9** (Trước 10:00 ngày 18/06/2026).
- [ ] **Ký tên vào danh sách nộp bản cứng** để trên bàn Giáo viên.
- [ ] Báo cáo (bản cứng + PDF) phải chứa đầy đủ:
  - [ ] **Link Repository Github** (Nhánh `giao-dien` chứa code hoàn chỉnh).
  - [ ] **Link Demo ứng dụng** (Hoặc mã QR chạy thử).
  - [ ] **Bảng phân công và đóng góp cụ thể** của từng thành viên trong nhóm.
  - [ ] Bìa báo cáo có tên và mã sinh viên của từng người nộp (mỗi sinh viên nộp 1 bản riêng biệt có thông tin cá nhân ở bìa).

---

## 🛠️ CÔNG VIỆC CẦN LÀM NGAY (HÀNH ĐỘNG CỦA NHÓM)

1. **Kiểm tra thông tin thành viên:** Mở file báo cáo `reports/App_library.md` và file slide để điền chính xác tên các thành viên và mã sinh viên (MSSV) của nhóm bạn.
2. **Chụp ảnh màn hình ứng dụng:** Chạy ứng dụng và chụp lại hình ảnh thực tế của các màn hình (Đăng nhập, Home, Danh sách sách, Dashboard thống kê, Tạo phiếu mượn/trả) rồi chèn vào:
   - Các vị trí đánh dấu trong file báo cáo `App_library.md`.
   - Các slide tương ứng trong file PowerPoint (`Bao_Cao_Do_An_N03_Update.pptx`).
3. **Xuất báo cáo PDF:** Sau khi hoàn thiện nội dung và chèn ảnh trong Word/Markdown, xuất file sang định dạng `.pdf` để nộp lên Canvas.
4. **In báo cáo bản cứng:** Chuẩn bị in ấn báo cáo để nộp trực tiếp tại văn phòng khoa theo đúng quy định của Đại học Phenikaa.
