import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:trainee_login/screens/home_screen.dart';
import 'package:trainee_login/utils/showsnackbar.dart';

class FirebaseAuthMethods {
  final FirebaseAuth _auth ;
  FirebaseAuthMethods(this._auth);

// Email Sign up

Future<void> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await sendEmailverifcation(context);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showSnackBar(context, 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        showSnackBar(context, 'The account already exists for that email.');
      }


      /*

      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      showSnackBar(
          context, e.message!);

          
      */

      
    }
  }


// Email Login 

Future<void> emailLogin({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
     try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      /*
     
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login successful'),
         
        ),
      );

      */


      if (_auth.currentUser!.emailVerified) {

         ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login successful'),
         
        ),
      );

      /*


         Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreenPage(
            title: 'homescreen',
          ),
        ),
      );


      */

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => HomeScreenPage(title: 'Homepage',)));
        
      } else {
        
       showSnackBar(context, 'Please verify your email');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                'A link is sent to your email. Please verify your email address to continue'),
            duration: Duration(seconds: 5), 
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showSnackBar(context, 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        showSnackBar(context, 'Wrong password provided for that user.');
      } else if (e.code == 'invalid-email') {
       showSnackBar(context, 'Email is Invalid ');
      } else if (e.code == 'user-disabled') {
        showSnackBar(context, 'Account deleted');
      } else if (e.code == 'too-many-requests') {
       showSnackBar(context, 'Too many requests. Try again later.');
      } else if (e.code == 'operation-not-allowed') {
       showSnackBar(context, 'Signing in with Email and Password is not enabled.');
      } else if (e.code == 'network-request-failed') {
        showSnackBar(context, 'Please check your internet connection');
      } else if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
       showSnackBar(context, 'Invalid login credentials');
      } else {
       showSnackBar(context, e.code);
      }
    } catch (e) {
     showSnackBar(context, e.toString()); 
     
    }
  
  }


 
// Email Verification

 Future<void> sendEmailverifcation(BuildContext context) async {
    try {
      await _auth.currentUser!.sendEmailVerification();
      showSnackBar(context, 'Verification Email has been sent');
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  } 


// Googele Sign in

Future<void> signInWithGoogle(BuildContext context) async {
  try {
    final GoogleSignInAccount? googleSignInAccount =
        await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleSignInAuthentication =
        await googleSignInAccount?.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication?.accessToken,
      idToken: googleSignInAuthentication?.idToken,
    );

    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    if (userCredential.user != null) {
      if (userCredential.additionalUserInfo!.isNewUser) {
        await sendEmailverifcation(context);
        showSnackBar(context, 'Please verify your email');
      } else {

         Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => HomeScreenPage(title: 'Homepage',)));
      }
    } else {
      // Handle the case where userCredential.user is null
      showSnackBar(context, 'Authentication failed. Please try again.');
    }
  } on FirebaseAuthException catch (e) {
    // Handle FirebaseAuthException errors
    showSnackBar(context, e.message!);
  } catch (e) {
    // Handle other errors
    showSnackBar(context, 'Authentication failed. Please try again.');
  }
}

// Forgot Password

Future<void> sendPasswordResetEmail(BuildContext context, String email) async {
  try {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    showSnackBar(context, 'Password reset email sent. Check your inbox.');
  } on FirebaseAuthException catch (e) {
    showSnackBar(context, e.message!);
  } catch (e) {
    showSnackBar(context, 'Password reset failed. Please try again.');
  }
}

// Checking is user is logged in or not if logged in then only login for once 

// Future<void> checkUserloginonce() async {
//   FirebaseAuth.instance
//   .authStateChanges();
// }


}




// Google Sign In raw code 



  // Google Sign In
// Future<void> signInWithGoogle(BuildContext context) async {
//     try {

//       final GoogleSignInAccount? googleSignInAccount =
//           await GoogleSignIn().signIn();

//       final GoogleSignInAuthentication? googleSignInAuthentication = 
//           await googleSignInAccount?.authentication;

//       final AuthCredential credential = GoogleAuthProvider.credential(
//         accessToken: googleSignInAuthentication?.accessToken,
//         idToken: googleSignInAuthentication?.idToken,
//       );

//       //if ( googleSignInAuthentication?.accessToken != null && googleSignInAuthentication?.idToken != null) {
//         // final credential = GoogleAuthProvider.credential(
//         //   accessToken: googleSignInAuthentication?.accessToken,
//         //   idToken: googleSignInAuthentication?.idToken,
//         // );
//         // credential = GoogleAuthProvider.credential(
//         //   accessToken: googleSignInAuthentication?.accessToken,
//         //   idToken: googleSignInAuthentication?.idToken,
//         // );
        
//         UserCredential userCredential =
//         await _auth.signInWithCredential(credential);

//         if (userCredential.user != null) {
//           if (userCredential.additionalUserInfo!.isNewUser) {
//             await sendEmailverifcation(context);
//             showSnackBar(context, 'Please verify your email');
//             return;
//           }
//         }

//         // if (!_auth.currentUser!.emailVerified) {
//         //   await sendEmailverifcation(context);
//         //   showSnackBar(context, 'Please verify your email');
//         //   return;
//         // }
//     //  }
    
//     }on FirebaseAuthException catch (e) {
//       showSnackBar(context, e.message!);
//     }
//   } 