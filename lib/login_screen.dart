import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_email_app/common_widget/common_textfield.dart';
import 'package:firebase_email_app/welcome_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  String emailAddress = '';
  String password = '';

  @override
  void initState() {
    // TODO: implement initState
    signInWithEmailAndPassword();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CommonTextField(
                onChanged: (value) {
                  emailAddress = value;
                },
                textEditingController: emailController,
                hintText: 'Enter Your Email',
              ),
              const SizedBox(
                height: 20,
              ),
              CommonTextField(
                onChanged: (value) {
                  password = value;
                },
                textEditingController: passwordController,
                hintText: 'Enter Your Password',
              ),
              const SizedBox(
                height: 25,
              ),
              ElevatedButton(
                onPressed: () {
                  signInWithEmailAndPassword();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const WelcomeScreen(),
                      ));
                },
                child: const Text(
                  'Login',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // signIn with signInWithEmailAndPassword

  signInWithEmailAndPassword() async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailAddress, password: password);
      debugPrint("credential ------------->>>$credential");
    } on FirebaseAuthException catch (e) {
      if (e.code == '---------->user-not-found') {
        debugPrint('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        debugPrint('----------->Wrong password provided for that user.');
      }
    }
    setState(() {});
  }
}
