import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trainee_login/screens/forgot_password_screen.dart';
import 'package:trainee_login/screens/login_screen.dart';
import 'package:trainee_login/services/firebase_auth.dart';
import 'package:trainee_login/utils/showsnackbar.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});


  @override
  State<SignUp> createState() => _SignUpState();
}


class _SignUpState extends State<SignUp> {


  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  bool isValidEmail(String email) {
    final RegExp emailPattern = RegExp(r'^[\w-]+@akgec\.ac\.in$');
    return emailPattern.hasMatch(email);
  }


  bool isValidPassword(String password) {
    final RegExp passwordPattern = RegExp(
      r'^(?=.*?[A-Z])(?=.*?[!@#\$&*~]).{8,}$',
    );

    return passwordPattern.hasMatch(password);

  }

  Future<bool> signUpUser() async {

    String email = emailController.text;
    String password = passwordController.text;


    if (!isValidEmail(email)) {
      showSnackBar(context, 'Invalid email format');
      return false;
    }


    if (!isValidPassword(password)) {
      showSnackBar(context, 'Invalid password format (must contain 1 uppercase, 1 special character and must be at least 8 characters long)');
      return false;
    }



    if (_formKey.currentState!.validate()) {

      try {

        await FirebaseAuthMethods(FirebaseAuth.instance)
            .signUpWithEmailAndPassword(
          email: email,
          password: password,
          context: context,
        );

        return true;
      } catch (e) {
        // ignore: use_build_context_synchronously
        showSnackBar(context, 'Sign-up failed. Please try again.');
      }
    }

    return false;

  }

  @override
  Widget build(BuildContext context) {
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

                  padding: EdgeInsets.only(left: 65.0),
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      color: Color.fromARGB(255, 95, 95, 95),
                      fontSize: 30,
                      fontWeight: FontWeight.bold,

                    ),
                  ),
                ),
              ],
            ),


            SizedBox(

              width: double.infinity,
              child: Image.asset(
                'assets/images/img7.png',

                fit: BoxFit.scaleDown,
                //width: 300,
              ),

            ),


            MySignUpTextField(
              hintText: 'Enter your Name',
              inputType: TextInputType.name,
              labelText2: 'Name',
              secure1: false,
              capital: TextCapitalization.words,
              nameController: nameController,
            ),


            const SizedBox(
              height: 8,
            ),


            MySignUpTextField(
              hintText: 'Enter your Email',
              inputType: TextInputType.emailAddress,
              labelText2: 'Email',
              secure1: false,
              capital: TextCapitalization.none,
              nameController: emailController,
              validator1: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your email';
                } else if (!value.contains('@')) {
                  return 'Please enter a valid email address';
                }
                return null;
              },
            ),


            const SizedBox(
              height: 8,
            ),


            MySignUpTextField(
              hintText: 'Enter your Password',
              inputType: TextInputType.visiblePassword,
              labelText2: 'Password',
              secure1: true,
              nameController: passwordController,
              capital: TextCapitalization.none,
              validator1: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your password';
                } else if (value.length < 6) {
                  return 'Password must be at least 6 characters!';
                }
                return null;
              },
            ),


            const SizedBox(
              height: 8,
            ),


            GestureDetector(
              onTap: () {

                /*

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ForgotPassword(),
                  ),
                );

                */

                 Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => ForgotPassword(title: 'Homepage',)));
              },

              child: const Padding(
                padding: EdgeInsets.only(right: 25.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Send OTP',
                    style: TextStyle(
                      color: Color.fromARGB(255, 95, 95, 95),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),


            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Form(
                  key: _formKey,
                  child: Row(
                    children: [
                      Expanded(
                        child: SignUpButtonXd(
                          buttonName: 'Sign Up',
                          onTap: () async {
                            bool signUpSuccessful = await signUpUser();
                            if (signUpSuccessful) {
                            
                              /*

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginScreen(title: 'Sign Up',),
                                ),
                              );

                              */
                               Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => LoginScreen(title: 'Sign Up',)));
                            }
                          },

                          bgColor: Colors.black,
                          textColor: Colors.white,

                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}

// MytextField Widget

class MySignUpTextField extends StatelessWidget {
  const MySignUpTextField({
    super.key,
    required this.hintText,
    required this.inputType,
    required this.labelText2,
    required this.secure1,
    required this.nameController,
    this.validator1, required this.capital,
  });

  final String hintText;
  final TextInputType inputType;
  final String labelText2;
  final bool secure1;
  final TextEditingController nameController;
  final String? Function(String?)? validator1;
  final TextCapitalization capital;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Form(
        child: TextFormField(
          controller: nameController,
          obscureText: secure1,
          keyboardType: inputType,
          textInputAction: TextInputAction.next,
          textCapitalization: capital,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(20),
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.grey),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 1),
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 1),
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            labelText: labelText2,
            labelStyle: const TextStyle(color: Colors.black54),
          ),
          validator: validator1,
        ),
      ),
    );
  }
}

// Login Widget

class SignUpButtonXd extends StatelessWidget {
  const SignUpButtonXd({
    Key? key,
    required this.buttonName,
    required this.onTap,
    required this.bgColor,
    required this.textColor,
  }) : super(key: key);

  final String buttonName;
  final VoidCallback onTap;
  final Color bgColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: bgColor,
      ),
      child: TextButton(
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(12),
          shadowColor: MaterialStateProperty.all(Colors.black),
          overlayColor: MaterialStateProperty.resolveWith(
            (states) => Colors.transparent,
          ),
        ),
        onPressed: onTap,
        child: Text(
          buttonName,
          style: TextStyle(fontSize: 20, color: textColor),
        ),
      ),
    );
  }
}
