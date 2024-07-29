import 'package:buzz_chat/components/general_components/my_button.dart';
import 'package:buzz_chat/components/general_components/my_text_form_field.dart';
// import 'package:buzz_chat/pages/auth/auth_page.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:buzz_chat/theme/theme.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  bool isSending = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _resetPassword() async {
    try {
      setState(() {
        isSending = true;
      });
      // await FirebaseAuth.instance
      // .sendPasswordResetEmail(email: _emailController.text.trim());
      if (mounted) {
        // Navigator.push(
        // context,
        // MaterialPageRoute(
        // builder: (context) => const AuthPage(),
        // ),
        // );
      }
    }
    // on FirebaseAuthException catch (e) {
    // if (mounted) {
    // showDialog(
    // context: context,
    // builder: (context) {
    // return AlertDialog(content: Text(e.toString()));
    // });
    // Navigator.push(
    // context,
    // MaterialPageRoute(
    // builder: (context) => const ForgotPasswordPage(),
    // ),
    // );
    // }
    // }
    catch (e) {
      if (mounted) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(content: Text(e.toString()));
            });
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ForgotPasswordPage(),
          ),
        );
      }
    } finally {
      setState(() {
        isSending = false;
      });
    }
  }

  bool _hasError = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(height: 20),
            Icon(
              Icons.lock,
              color: AppTheme.isDarkMode(context)
                  ? Theme.of(context).primaryColorLight
                  : Theme.of(context).primaryColorDark,
              size: 80,
            ),
            const SizedBox(height: 30),
            const Center(
              child: Text(
                'FORGOT\nPASSWORD?',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Text(
                'Provide your account\'s email for which you want to reset your password!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 20),
            MyTextFormField(
              icon: const Icon(Icons.email),
              hintText: 'Email',
              controller: _emailController,
              obscureText: false,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  setState(() {
                    _hasError = true;
                  });
                  return 'Please enter your email';
                } else if (!RegExp(
                        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                    .hasMatch(value)) {
                  setState(() {
                    _hasError = true;
                  });

                  return 'Please enter email in correct format eg: something@likethis.com';
                } else {
                  return null;
                }
              },
              hasError: _hasError,
            ),
            const SizedBox(height: 20),
            MyButton(
                msg: 'NEXT',
                onTap: () {
                  final isValid = _formKey.currentState!.validate();
                  if (!isValid) {
                    return;
                  }
                  showModalBottomSheet(
                      context: context,
                      builder: (context) => Container(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Make Selection!',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 15),
                                const Text(
                                  'Select one of the options given below to reset your password',
                                  style: TextStyle(fontSize: 15),
                                ),
                                const SizedBox(height: 15),
                                (isSending)
                                    ? const SizedBox(
                                        height: 100,
                                        width: 100,
                                        child: CircularProgressIndicator(),
                                      )
                                    : Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: ListTile(
                                              onTap: _resetPassword,
                                              leading: const Icon(
                                                Icons.email,
                                                size: 50,
                                              ),
                                              title: const Text('Email'),
                                              subtitle: const Text(
                                                'Recieve password reset link on your Email',
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                              ],
                            ),
                          ));
                }),
          ],
        ),
      ),
    );
  }
}
