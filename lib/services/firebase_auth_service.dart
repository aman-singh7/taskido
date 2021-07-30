import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_dot_do/ui/constants/constants.dart';
import 'package:task_dot_do/locator.dart';

class FirebaseAuthService {
  final FirebaseAuth _firebaseAuth = locator<FirebaseAuth>();
  final FirebaseFirestore _firebaseFirestore = locator<FirebaseFirestore>();

  User get currentUser => _firebaseAuth.currentUser!;
  //final FirebaseFirestore _firebaseFirestore = locator<FirebaseFirestore>();

  // Sign In with email and password
  Future<UserCredential> signIn(String email, String password) async {
    try {
      return await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw signInErrorCodes[e.code] ?? 'Database Error Occured!';
    } catch (e) {
      throw '${e.toString()} Error Occured!';
    }
  }

  // Sign Up using email address
  Future<UserCredential> signUp(
      String name, String email, String password) async {
    try {
      var _user = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _firebaseFirestore
          .collection('Users')
          .doc(_user.user!.email)
          .set({'name': name, 'phone': 'Phone', 'enrollment': 'Enrollment'})
          .then((value) => print('User Created : ${_user.user!.email}'))
          .catchError((e) => print('Database Error!'));
      return _user;
    } on FirebaseAuthException catch (e) {
      throw signUpErrorCodes[e.code] ?? 'Firebase ${e.code} Error Occured!';
    } catch (e) {
      throw '${e.toString()} Error Occured!';
    }
  }

  // Sign Out
  Future<String> signOut() async {
    await _firebaseAuth.signOut();
    return 'Signed Out Successfully';
  }

  Future<String> sendResetPasswordEmail(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return 'Email Sent Succesfully';
    } on FirebaseException catch (e) {
      throw passwordResetErrorCodes[e.code] ??
          'Firebase ${e.code} Error Occured!';
    } catch (e) {
      throw '${e.toString()} Error Occured!';
    }
  }

  //set Token
  Future<bool> setToken(String token) async {
    try {
      await _firebaseFirestore
          .collection('Users')
          .doc(_firebaseAuth.currentUser!.email)
          .set(
        {
          'token': token,
        },
        SetOptions(merge: true),
      );
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}
