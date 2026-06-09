import 'package:flutter_test/flutter_test.dart';
import 'package:library_management_app/models/user_model.dart';

void main() {
  group('AppUser Model Tests', () {
    test('Khởi tạo AppUser thành công', () {
      final user = AppUser(
        uid: 'u1',
        email: 'test@example.com',
        name: 'Hieu',
        photoUrl: 'url',
        birthday: '01/01/2000',
        gender: 'Nam',
      );

      expect(user.uid, 'u1');
      expect(user.email, 'test@example.com');
      expect(user.name, 'Hieu');
      expect(user.birthday, '01/01/2000');
    });

    test('Chuyển đổi AppUser sang Map (toMap)', () {
      final user = AppUser(
        uid: 'u2',
        email: 'user2@example.com',
        name: 'Nguyen',
        photoUrl: '',
        birthday: '',
        gender: 'Nữ',
      );

      final map = user.toMap();
      expect(map['email'], 'user2@example.com');
      expect(map['name'], 'Nguyen');
      expect(map['gender'], 'Nữ');
    });

    test('Tạo AppUser từ Map (fromMap)', () {
      final map = {
        'uid': 'doc3',
        'email': 'user3@test.com',
        'name': 'Hieu TB',
        'photoUrl': 'pic.jpg',
        'birthday': '12/12/1990',
        'gender': 'Nam',
      };

      final user = AppUser.fromMap(map);

      expect(user.uid, 'doc3');
      expect(user.email, 'user3@test.com');
      expect(user.photoUrl, 'pic.jpg');
      expect(user.birthday, '12/12/1990');
    });
  });
}
