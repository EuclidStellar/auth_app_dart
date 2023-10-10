import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trainee_login/screens/forgot_password_screen.dart';
import 'package:trainee_login/services/firebase_auth.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required String title});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String? emailError;
  String? passwordError;


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



  @override
  void dispose(){
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }


void loginUser() async {
  FirebaseAuthMethods(FirebaseAuth.instance).emailLogin(
    email: emailController.text,
    password: passwordController.text,
    context: context,
  );
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
                  padding: EdgeInsets.only(left: 40.0),
                  child: Text(
                    'Welcome Back',
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
              child: Image.asset('assets/images/img4.png'),
            ),


            const SizedBox(
              height: 20,
            ),


            const SizedBox(
              height: 10,
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
              height: 10,
            ),

            Padding(

              padding: const EdgeInsets.symmetric(horizontal: 20),

              child: TextFormField(
                controller: passwordController,
                obscureText: true,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(

                  suffixIcon: IconButton(
                    onPressed: () { 
                    },

                    icon: const Icon(
                      Icons.remove_red_eye_rounded,
                      color: Colors.grey,
                    ),

                  ),


                  contentPadding: const EdgeInsets.all(20),
                  hintText: 'Enter your Password',
                  hintStyle: const TextStyle(color: Colors.grey),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),


                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),


                  labelText: 'Password',
                  labelStyle: const TextStyle(color: Colors.black54),


                ),
              ),
            ),


            const SizedBox(
              height: 5,
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
              child: const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 30),
                  child: Text(
                    'Forgot Password ?',
                    style: TextStyle(
                      color: Color.fromARGB(255, 95, 95, 95),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),


            const SizedBox(
              height: 30,
            ),


            GestureDetector(
              onTap: () {

                 Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => ForgotPassword(title: 'Homepage',)));
              },

              child: Padding(
                padding: const EdgeInsets.only(left: 25, right: 25, bottom: 12),
                child: Container(

                  height: 60,
                  width: double.infinity,

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,

                  ),
                  child: TextButton(

                    style: const ButtonStyle(

                        elevation: MaterialStatePropertyAll(8),
                        backgroundColor: MaterialStatePropertyAll(
                            Color.fromARGB(255, 214, 213, 213)),
                        shadowColor: MaterialStatePropertyAll(
                            Color.fromARGB(255, 14, 14, 14)),
                        shape: MaterialStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(16),


                            ),
                          ),
                        )),

                    onPressed: () {
                      FirebaseAuthMethods(FirebaseAuth.instance)
                          .signInWithGoogle(context);
                    },
                    
                    child: const Text(
                      'Sign in With Google',
                      style: TextStyle(
                        color: Color.fromARGB(255, 81, 80, 80),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
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
                        buttonName: 'Login',
                        onTap: () {
                          loginUser();
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
      )),
    );
  }
}

// MytextField Widget

class MyTextField extends StatelessWidget {
  const MyTextField({
    super.key,
    required this.hintText,
    required this.inputType,
    required this.labelText2,
    required this.secure1,
    required this.capital, required this.nameController1,
  });

  final String hintText;
  final TextInputType inputType;
  final String labelText2;
  final bool secure1;
  final TextCapitalization capital;
  final TextEditingController nameController1 ;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        controller: nameController1,
        keyboardType: inputType,
        obscureText: secure1,
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
      ),
    );
  }
}

// Login Widget

class Login extends StatelessWidget {
  const Login({
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
