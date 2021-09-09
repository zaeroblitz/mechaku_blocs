part of 'models.dart';

// ignore: must_be_immutable
class UserModel extends Equatable {
  final String id;
  final String email;
  final String name;
  final String username;
  final String profilePicture;
  final String role;
  int balance;
  final List<String> wishlists;
  List<CheckoutModel> checkout;

  UserModel({
    required this.id,
    required this.email,
    required this.name,
    this.username = '',
    this.profilePicture = '',
    this.role = 'USER',
    this.balance = 0,
    this.wishlists = const [],
    this.checkout = const [],
  });

  factory UserModel.fromJson(String id, Map<String, dynamic> json) {
    List<String> wishlists = List.from(json['wishlists']);

    List<CheckoutModel> checkout = List<CheckoutModel>.from(
        json["checkout"].map((x) => CheckoutModel.fromJson(x)));

    return UserModel(
      id: id,
      email: json['email'],
      name: json['name'],
      username: json['username'],
      profilePicture: json['profilePicture'],
      role: json['role'],
      balance: json['balance'],
      wishlists: wishlists,
      checkout: checkout,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'name': name,
      'username': username,
      'profilePicture': profilePicture,
      'role': role,
      'balance': balance,
      'wishlists': List.from(wishlists),
      'checkout': List<dynamic>.from(checkout.map((e) => e.toJson())),
    };
  }

  @override
  List<Object?> get props => [
        id,
        email,
        name,
        username,
        profilePicture,
        role,
        balance,
        wishlists,
        checkout,
      ];
}
