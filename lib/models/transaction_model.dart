part of 'models.dart';

class TransactionModel extends Equatable {
  final int amount;
  final String picture;
  final String date;
  final DateTime time;
  final String title;
  final String userID;
  final String transactionID;

  TransactionModel({
    this.amount = 0,
    this.picture = '',
    required this.date,
    required this.time,
    required this.title,
    required this.userID,
    this.transactionID = '',
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      amount: json['amount'],
      picture: json['picture'],
      date: json['data'],
      time: DateTime.fromMillisecondsSinceEpoch(json['time']),
      title: json['title'],
      userID: json['userID'],
      transactionID: json['transactionID'],
    );
  }

  Map<String, dynamic> toJson(String id) {
    return {
      'amount': amount,
      'picture': picture,
      'date': date,
      'time': time.millisecondsSinceEpoch,
      'title': title,
      'userID': userID,
      'transactionID': id,
    };
  }

  @override
  List<Object?> get props => [
        amount,
        picture,
        date,
        time,
        title,
        userID,
        transactionID,
      ];
}
