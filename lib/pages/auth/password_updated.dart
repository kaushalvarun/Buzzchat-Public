// Contains only partial code
// For preview or code access email Varun at kaushalvarunkv@gmail.com
import 'package:buzz_chat/components/general_components/my_button.dart';
import 'package:buzz_chat/pages/auth/login_or_register_page.dart';
import 'package:flutter/material.dart';

class PasswordUpdatedScreen extends StatelessWidget {
  const PasswordUpdatedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'PASSWORD UPDATED',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            const Icon(
              Icons.check_circle,
              size: 100,
            ),
            const SizedBox(height: 20),
            const Text(
              'your password has been updated!',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 40),
            MyButton(
              onTap: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginOrRegister()),
                    (Route<dynamic> route) => false);
              },
              msg: 'Login',
            ),
          ],
        ),
      ),
    );
  }
}
