import 'package:flutter/material.dart';
import 'package:trainee_login/screens/signup_screen.dart';
import 'login_screen.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          const Text(
            'Welcome to \n BRL Trainee',
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),


          const SizedBox(
            height: 30,
          ),

          
          const Align(
            alignment: Alignment.center,
            child: Text(
              'Develop     Deploy     Distribute ',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Color.fromARGB(255, 46, 139, 193)),
            ),
          ),


          const SizedBox(
            height: 90,
          ),


          Center(
            child: SizedBox(
              width: double.infinity,
              // height: MediaQuery.of(context).size.height * 0.75,
              // width: MediaQuery.of(context).size.width * 1,
              child: Image.asset('assets/images/img1.png'),
            ),
          ),


          const SizedBox(
            height: 40, // Add some spacing between the images
          ),


          Center(
            child: SizedBox(
              // width: double.infinity,
              width: MediaQuery.of(context).size.width * 0.25,
              //height: MediaQuery.of(context).size.height * 0.75,
              child: Image.asset(
                'assets/images/brl_logo.png',
                fit: BoxFit.scaleDown,
              ),
            ),
          ),


          const SizedBox(
            height: 60,
          ),


          Container(
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Row(
              children: [


                Expanded(
                  child: MyTextButton(
                    buttonName: 'Login',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(title: 'Login',),
                        ),
                      );
                    },
                    bgColor: Colors.black,
                    textColor: Colors.white,
                  ),
                ),


                const SizedBox(
                  width: 10,
                ),


                Expanded(
                  child: MyTextButton(
                    buttonName: 'Sign Up',
                    onTap: () {
                       Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUp(),));
                    },
                    bgColor: Colors.black,
                    textColor: Colors.white,
                  ),
                ),


              ],
            ),
          )
        ],
      ),
    )));
  }
}

// Extraced Class for TextButton

class MyTextButton extends StatelessWidget {
  const MyTextButton({
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
