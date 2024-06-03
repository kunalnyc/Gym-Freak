import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  // ignore: unused_field
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final currentUser = FirebaseAuth.instance.currentUser!.uid;
  //Signup to fit-freak
  Future<String> signUpUser({
    required String email,
    required String password,
    required String userName,
  }) async {
    String res = "Error";
    try {
      if (password.isNotEmpty || userName.isNotEmpty || email.isNotEmpty) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        await cred.user!.sendEmailVerification();
        try {
          await _firestore.collection('Users').doc(cred.user!.uid).set({
            'username': userName,
            'email': email,
          });
        } on FirebaseException catch (error) {
          res = 'Error saving user data: ${error.message}';
        }

        res = 'Success';
      } else {
        res = 'Please fill in all the fields.';
      }
    } on FirebaseAuthException catch (error) {
      res = error.message!;
    } catch (error) {
      res = error.toString();
    }
    return res;
  }

// Login to Fit Freak
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      if (email.isEmpty || password.isEmpty) {
        return "All fields are required";
      }

      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user == null) {
        return "User not found";
      }

      return "Success";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'User not found';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password';
      }
      return e.message ?? 'Some error occurred';
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> sendEmailVerification() async {
    User? user = _auth.currentUser;
    if (user != null) {
      await user.sendEmailVerification();
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
