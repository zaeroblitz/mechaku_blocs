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
        'profilePicture': user.profilePicture == ''
            ? 'https://ui-avatars.com/api/?name=${user.name}'
            : user.profilePicture,
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

  Future<UserModel> update(UserModel user) async {
    try {
      print('product added');
      await _userReference.doc(user.id).update(user.toJson());
      return user;
    } catch (e) {
      throw e;
    }
  }

  Future<void> removeFromWishlists(UserModel user, ProductModel product) async {
    try {
      print('product with ${product.name} deleted');
      await _userReference.doc(user.id).update({
        'wishlists': FieldValue.arrayRemove([product.id])
      });
    } catch (e) {
      throw e;
    }
  }
}
