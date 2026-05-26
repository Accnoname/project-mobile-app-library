import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:library_management_app/models/user_model.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Đăng ký tài khoản mới và tạo document trong Firestore
  Future<User?> signUpWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      // Đăng ký với Firebase Auth
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = result.user;
      if (user != null) {
        // Tạo model user mặc định
        final newUser = AppUser(
          uid: user.uid,
          name: '',
          email: email,
          birthday: '',
          gender: '',
          photoUrl: '',
        );

        // Lưu vào collection 'users'
        await _firestore.collection('users').doc(user.uid).set(newUser.toMap());
      }

      return user;
    } on FirebaseAuthException catch (e) {
      print('Lỗi đăng ký: ${e.message}');
      return null;
    }
  }

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

  /// Đăng xuất
  Future<void> signOut() async {
    await _auth.signOut();
  }

  /// Lấy người dùng hiện tại
  User? get currentUser => _auth.currentUser;

  /// Stream theo dõi trạng thái đăng nhập (login / logout)
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  /// Gửi email xác thực
  Future<void> sendEmailVerification() async {
    try {
      final user = _auth.currentUser;
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
      }
    } catch (e) {
      print('Lỗi gửi email xác thực: $e');
    }
  }

  /// Gửi email đặt lại mật khẩu
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print('Lỗi gửi email đặt lại mật khẩu: $e');
    }
  }
}
