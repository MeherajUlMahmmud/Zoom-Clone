import 'package:flutter/material.dart';
import 'package:zoom_clone/resources/auth_methods.dart';
import 'package:zoom_clone/utils/constants.dart';
import 'package:zoom_clone/utils/utils.dart';
import 'package:zoom_clone/widgets/custom_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthMethods _authMethods = AuthMethods();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Start or join a meeting",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        Image.asset(ONBOARDING_IMG),
        const SizedBox(height: 20),
        CustomButton(
          text: "Login",
          onPressed: () async {
            setState(() {
              _isLoading = true;
            });
            // showSnackBar(context, "text", Colors.red, Colors.white, 1000);
            bool res = await _authMethods.signInWithGoogle(context);
            if (res) {
              Navigator.pushReplacementNamed(context, HOME_SCREEN);
            }
          },
        ),
      ],
    ));
  }
}
