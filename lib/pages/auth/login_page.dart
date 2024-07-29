import 'package:buzz_chat/components/general_components/auth_button.dart';
import 'package:buzz_chat/components/general_components/my_text_form_field.dart';
import 'package:buzz_chat/pages/auth/forgot_password.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final Function() onTap;
  const LoginPage({
    super.key,
    required this.onTap,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // form key
  final _form = GlobalKey<FormState>();

  // text editing controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  late bool _passwordNotVisible;

  // sign user in method
  void signUserIn() async {
    // loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(child: CircularProgressIndicator());
      },
    );

    final isValid = _form.currentState!.validate();
    if (!isValid) {
      Navigator.pop(context);
      return;
    }

    _form.currentState!.save();
    Navigator.pop(context);

    try {
      // await FirebaseAuth.instance.signInWithEmailAndPassword(
      // email: _emailController.text.toLowerCase(),
      // password: _passwordController.text,
      // );
      setState(() {});
    }
    //  on FirebaseAuthException catch (e) {
    //   if (mounted) {
    //     ScaffoldMessenger.of(context).clearSnackBars();
    //     // WRONG email or password entered
    //     if (e.code == 'invalid-credential') {
    //       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
    //           content: Text('Incorrect email or password entered')));
    //     } else if (e.code == 'too-many-requests') {
    //       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
    //           content: Text(
    //               'Multiple sign in attempts detected, please try to sign in after sometime')));
    //     }
    //     // otherwise
    //     else {
    //       ScaffoldMessenger.of(context)
    //           .showSnackBar(SnackBar(content: Text(e.code)));
    //     }
    //   }
    // }
    catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Internal App Error: ${e.toString()}'),
          ),
        );
      }
    }
  }

  bool _hasError = false;
  bool _hasErrorP = false;

  @override
  void initState() {
    _passwordNotVisible = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = (Theme.of(context).brightness == Brightness.dark);

    return Scaffold(
        body: SafeArea(
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                key: _form,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 25,
                    ),
                    // logo
                    Image.asset(
                      'lib/images/buzzchatLogoNoText.png',
                      height: 300,
                      width: 300,
                    ),

                    Text(
                      'Buzz Chat',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),

                    // welcome back
                    const Text(
                      'Welcome back, you\'ve been missed!',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    const SizedBox(
                      height: 25,
                    ),

                    // username
                    MyTextFormField(
                      controller: _emailController,
                      hintText: 'Enter email',
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

                    // password
                    MyTextFormField(
                      hasError: _hasErrorP,
                      controller: _passwordController,
                      hintText: 'Enter password',
                      obscureText: _passwordNotVisible,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _passwordNotVisible
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Theme.of(context).primaryColorDark,
                        ),
                        onPressed: () {
                          setState(() {
                            _passwordNotVisible = !_passwordNotVisible;
                          });
                        },
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          setState(() {
                            _hasErrorP = true;
                          });
                          return 'Please enter your password';
                        } else {
                          return null;
                        }
                      },
                    ),

                    // forgot password
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const ForgotPasswordPage(),
                                ),
                              );
                            },
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(
                                color:
                                    isDarkMode ? Colors.grey : Colors.grey[700],
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 25),

                    // sign in button
                    AuthButton(
                      onTap: signUserIn,
                      msg: 'Sign In',
                    ),

                    const SizedBox(height: 25),

                    // not a member? register now
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Not a member?',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                        const SizedBox(width: 4),
                        GestureDetector(
                          onTap: widget.onTap,
                          child: Text(
                            'Register Now',
                            style: TextStyle(
                              color: isDarkMode
                                  ? Colors.blue[300]
                                  : Colors.blue[700],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
