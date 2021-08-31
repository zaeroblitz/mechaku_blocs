part of 'models.dart';

class UserModel extends Equatable {
  final String id;
  final String email;
  final String name;
  final String username;
  final String profilePicture;
  final String role;
  final int balance;
  final List<String> wishlists;

  UserModel({
    required this.id,
    required this.email,
    required this.name,
    this.username = '',
    this.profilePicture = '',
    this.role = 'USER',
    this.balance = 0,
    this.wishlists = const [],
  });

  factory UserModel.fromJson(String id, Map<String, dynamic> json) {
    List<String> wishlists = List.from(json['wishlists']);

    return UserModel(
      id: id,
      email: json['email'],
      name: json['name'],
      username: json['username'],
      profilePicture: json['profilePicture'],
      role: json['role'],
      balance: json['balance'],
      wishlists: wishlists,
    );
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
      ];
}