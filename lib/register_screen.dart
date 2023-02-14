import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_email_app/common_widget/common_textfield.dart';
import 'package:firebase_email_app/welcome_screen.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  late String emailAddress;
  late String password;

  @override
  void initState() {
    // TODO: implement initState
    createUserWithEmailAndPassword();
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
                  createUserWithEmailAndPassword();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const WelcomeScreen(),
                      ));
                },
                child: const Text(
                  'Register',
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

  // create User WithEmailAndPassword

  createUserWithEmailAndPassword() async {
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      debugPrint("credential ------------->>>$credential");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        debugPrint('----------The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        debugPrint('------------The account already exists for that email.');
      }
    } catch (e) {
      debugPrint('---------$e');
    }
    setState(() {});
  }
}
