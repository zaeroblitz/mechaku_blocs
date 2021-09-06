part of 'services.dart';

class TransactionService {
  CollectionReference _transactionRef =
      FirebaseFirestore.instance.collection('transactions');

  Future<void> setTransaction(TransactionModel transactionModel) async {
    try {
      _transactionRef.add(transactionModel.toJson('id')).then((value) =>
          _transactionRef.doc(value.id).set(transactionModel.toJson(value.id)));
    } catch (e) {
      throw e;
    }
  }

  Future<List<TransactionModel>> getTransaction(String userID) async {
    try {
      QuerySnapshot snapshot =
          await _transactionRef.where('userID', isEqualTo: userID).get();

      List<TransactionModel> transactions = snapshot.docs.map((doc) {
        return TransactionModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();

      return transactions;
    } catch (e) {
      throw e;
    }
  }
}
