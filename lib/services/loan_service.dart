import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:library_management_app/models/loan_model.dart';

class LoanService {
  final _loans = FirebaseFirestore.instance.collection('loans');

  Future<void> addLoan(LoanModel loan) async {
    await _loans.add(loan.toJson());
  }

  Future<void> updateLoan(LoanModel loan) async {
    await _loans.doc(loan.id).update(loan.toJson());
  }

  Future<void> deleteLoan(String id) async {
    await _loans.doc(id).delete();
  }

  Stream<List<LoanModel>> getLoans(String type) {
    return _loans
        .where('type', isEqualTo: type)
        .orderBy('date', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => LoanModel.fromJson(doc.data(), doc.id))
              .toList(),
        );
  }

  Future<List<LoanModel>> getLoansOnce(String type) async {
    final snapshot = await _loans.where('type', isEqualTo: type).get();
    return snapshot.docs
        .map((doc) => LoanModel.fromJson(doc.data(), doc.id))
        .toList();
  }

  Future<LoanModel?> getLoanById(String id) async {
    try {
      final doc = await _loans.doc(id).get();
      if (doc.exists) {
        return LoanModel.fromJson(doc.data() as Map<String, dynamic>, id);
      }
      return null;
    } catch (e) {
      print('Lỗi khi lấy loan theo ID: $e');
      return null;
    }
  }

  Future<void> updateLoanType(String id, String newType) async {
    try {
      await _loans.doc(id).update({'type': newType});
    } catch (e) {
      print('Lỗi khi cập nhật type: $e');
    }
  }

  Future<int> getBorrowCount() async {
    QuerySnapshot snapshot = await _loans
        .where('type', isEqualTo: 'borrow')
        .get();
    return snapshot.size;
  }

  Future<int> getReturnCount() async {
    QuerySnapshot snapshot = await _loans
        .where('type', isEqualTo: 'return')
        .get();
    return snapshot.size;
  }
}
