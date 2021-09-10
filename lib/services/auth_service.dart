part of 'services.dart';

class AuthService {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<UserModel> signUp({
    required String name,
    required String email,
    required String username,
    required String password,
  }) async {
    try {
      UserCredential _userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      UserModel user = UserModel(
        id: _userCredential.user!.uid,
        email: email,
        name: name,
        username: username,
        balance: 2000000,
        profilePicture: 'https://ui-avatars.com/api/?name=$name',
        wishlists: [],
        cart: [],
      );

      await UserService().setUser(user);

      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        throw 'The account already exists for that email.';
      } else {
        throw e.code;
      }
    } catch (e) {
      throw e;
    }
  }

  Future<UserModel> signIn({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential _userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      UserModel user =
          await UserService().getUserById(_userCredential.user!.uid);
      return user;
    } on FirebaseException catch (e) {
      if (e.code == 'user-not-found') {
        throw 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        throw 'Wrong password provided for that user.';
      } else {
        throw e.code;
      }
    } catch (e) {
      throw e;
    }
  }

  Future<UserModel> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);

      List<CheckUserModel> checkUser = await UserService().getAllUserEmail();
      List<String> allUsersEmail = checkUser.map((e) {
        return e.email;
      }).toList();

      if (allUsersEmail.contains(userCredential.user!.email as String)) {
        UserModel user =
            await UserService().getUserById(userCredential.user!.uid);
        return user;
      } else {
        UserModel user = UserModel(
          balance: 2000000,
          id: userCredential.user!.uid,
          email: userCredential.user!.email as String,
          name: userCredential.user!.displayName as String,
          username: userCredential.user!.displayName as String,
          profilePicture: userCredential.user!.photoURL as String,
          wishlists: [],
          cart: [],
        );

        await UserService().setUser(user);

        return user;
      }
    } catch (e) {
      throw e;
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw e;
    }
  }
}
