part of 'services.dart';

class UserService {
  CollectionReference _userReference =
      FirebaseFirestore.instance.collection('users');

  Future<void> setUser(UserModel user) async {
    try {
      await _userReference.doc(user.id).set({
        'name': user.name,
        'role': user.role,
        'email': user.email,
        'balance': user.balance,
        'username': user.username,
        'wishlists': user.wishlists,
        'profilePicture': user.profilePicture,
      });
    } catch (e) {
      throw e;
    }
  }

  Future<UserModel> getUserById(String id) async {
    try {
      DocumentSnapshot snapshot = await _userReference.doc(id).get();
      return UserModel.fromJson(id, snapshot.data() as Map<String, dynamic>);
    } catch (e) {
      throw e;
    }
  }

  Future<void> update(UserModel user, int balance) async {
    try {
      _userReference.doc(user.id).update({
        'balance': balance,
      });
    } catch (e) {
      throw e;
    }
  }
}
