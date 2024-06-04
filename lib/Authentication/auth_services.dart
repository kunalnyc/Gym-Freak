import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  // Sign up to Fit Freak
  Future<String> signUpUser({
    required String email,
    required String password,
    required String userName,
  }) async {
    String res = "Error";
    try {
      if (email.isNotEmpty && password.isNotEmpty && userName.isNotEmpty) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        await cred.user!.sendEmailVerification();
        
        await _firestore.collection('Users').doc(cred.user!.uid).set({
          'username': userName,
          'email': email,
        });

        res = 'Success';
      } else {
        res = 'Please fill in all the fields.';
      }
    } on FirebaseAuthException catch (error) {
      res = error.message ?? "An error occurred";
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

      UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
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
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
