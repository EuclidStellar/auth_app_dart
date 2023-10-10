import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trainee_login/screens/login_screen.dart';
import 'package:trainee_login/utils/showsnackbar.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({Key? key, required String title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();

    void resetPassword() async {
      final String email = emailController.text.trim();

      if (email.isEmpty) {
        // Handle empty email input
        showSnackBar(context, 'Please enter your email.');
        return;
      }

      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
        // Display a confirmation message
        showSnackBar(context, 'Password reset email sent. Please check your inbox.');
      } catch (e) {
        // Handle errors (e.g., invalid email, user not found)
        showSnackBar(context, 'Password reset failed. Please try again.');
      }
    }

    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        reverse: true,
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Padding(
                    padding: EdgeInsets.only(left: 12.0),
                    child: Image(
                      image: AssetImage(
                        'assets/images/back_arrow.png',
                      ),
                      width: 30,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 30.0),
                  child: Text(
                    'Forgot Password ?',
                    style: TextStyle(
                      color: Color.fromARGB(255, 95, 95, 95),
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              child: Image.asset('assets/images/img5.png'),
            ),
            const SizedBox(
              height: 30,
            ),
             MyTextField(
              hintText: 'Enter your Email',
              inputType: TextInputType.emailAddress,
              labelText2: 'Email',
              secure1: false,
              capital: TextCapitalization.none,
              nameController1 : emailController,
            ),
            const SizedBox(
              height: 30,
            

            ),

            Padding(
              padding: const EdgeInsets.only(left: 25, right: 25, bottom: 10),
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Login(
                        buttonName: 'Reset Password',
                        onTap: () {
                          resetPassword();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(
                                title: 'Logincreen',
                              ),
                            ),
                          );
                        },
                        bgColor: Colors.black,
                        textColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        ),
        ),
      );
  }
}




//Scaffold(
    //   appBar: AppBar(
    //     title: const Text('Forgot Password'),
    //   ),
    //   body: Padding(
    //     padding: const EdgeInsets.all(16.0),
    //     child: Column(
    //       children: [
    //         TextField(
    //           controller: emailController,
    //           keyboardType: TextInputType.emailAddress,
    //           decoration: const InputDecoration(labelText: 'Email'),
    //         ),
    //         ElevatedButton(
    //           onPressed: resetPassword,
    //           child: const Text('Reset Password'),
    //         ),
    //       ],
    //     ),
    //   ),
    // );