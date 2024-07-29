// Contains only partial code
// For preview or code access email Varun at kaushalvarunkv@gmail.com
import 'dart:io';
import 'package:buzz_chat/components/general_components/auth_button.dart';
import 'package:buzz_chat/components/general_components/custom_alert_box.dart';
import 'package:buzz_chat/components/general_components/my_text_form_field.dart';
import 'package:buzz_chat/components/general_components/user_image_picker.dart';
// import 'package:buzz_chat/custom_classes/group.dart';
// import 'package:buzz_chat/custom_classes/user.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class RegisterPage extends StatefulWidget {
  final Function() onTap;
  const RegisterPage({
    super.key,
    required this.onTap,
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isAuthenticating = false;

  // user image
  File? _selectedImage;

  // form controls
  final _form = GlobalKey<FormState>();
  bool _hasErrorU = false;
  bool _hasErrorE = false;
  bool _hasErrorP = false;
  bool _hasErrorCP = false;

  // text editing controllers
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  late bool _passwordNotVisible;
  bool noImageSelectedFirstTime = true;
  String imageUrl = 'https://i.ibb.co/BTQPhdc/user-Default-Photo.png';

  // sign user up method
  void signUserUp() async {
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

    Navigator.pop(context);

    PermissionStatus status1 = await Permission.camera.request();
    if ((!status1.isGranted || status1.isDenied) && noImageSelectedFirstTime) {
      if (mounted) {
        customAlertDialog(
            context: context,
            msg: 'Please allow camera permission in settings to sign up',
            onPressed: () async {
              setState(() {
                noImageSelectedFirstTime = false;
              });
              _form.currentState!.save();
              openAppSettings();
            });
      }
      return;
    }
    // so form data is valid
    if ((status1.isGranted || status1.isLimited) &&
        _selectedImage == null &&
        noImageSelectedFirstTime) {
      if (mounted) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No image selected'),
          ),
        );
      }
      setState(() {
        noImageSelectedFirstTime = false;
      });
      return;
    }

    setState(() {
      noImageSelectedFirstTime = false;
    });

    _form.currentState!.save();

    // create user with email and password
    try {
      if (_passwordController.text == _confirmPasswordController.text) {
        setState(() {
          isAuthenticating = true;
        });
        // await FirebaseAuth.instance.createUserWithEmailAndPassword(
        // email: _emailController.text.toLowerCase(),
        // password: _passwordController.text,
        // );

        // grab newly created user info
        // final user = FirebaseAuth.instance.currentUser!;
        // final storageRef = FirebaseStorage.instance
        // .ref()
        // .child('user_images')
        // .child('${user.uid}.jpg');

        if (_selectedImage != null) {
          // await storageRef.putFile(_selectedImage!);
          // final String imgUrl = await storageRef.getDownloadURL();
          if (mounted) {
            // setState(() {
            // imageUrl = imgUrl;
            // });
          }
        }

        // Adding additional user data to firestore
        // await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        // 'username': _usernameController.text,
        // 'email': _emailController.text,
        // 'status': 'Unavailable',
        // 'groups': <Group>[],
        // 'recentChats': <BcUser>[],
        // 'image': imageUrl,
        // });
        if (mounted) {
          setState(() {
            isAuthenticating = false;
          });
        }
      } else {
        if (mounted) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Passwords don\'t match')));
        }
      }
    }
    // on FirebaseAuthException catch (e) {
    // if (mounted) {
    // ScaffoldMessenger.of(context).clearSnackBars();
    // ScaffoldMessenger.of(context)
    // .showSnackBar(SnackBar(content: Text(e.code)));

    // setState(() {
    // isAuthenticating = false;
    // });
    // }
    // }
    catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Internal App Error: ${e.toString()}'),
          ),
        );

        setState(() {
          isAuthenticating = false;
        });
      }
    }
  }

  @override
  void initState() {
    _passwordNotVisible = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = (Theme.of(context).brightness == Brightness.dark);
    return Scaffold(
        // backgroundColor: Colors.amber[50],
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
                      height: 175,
                      width: 175,
                    ),

                    // welcome
                    const Text(
                      'Welcome to our App!',
                      style: TextStyle(
                        // color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(
                      height: 15,
                    ),

                    UserImagePicker(onPickImage: (pickedImage) {
                      // _selectedImage = pickedImage;
                    }),

                    // email field
                    MyTextFormField(
                      hasError: _hasErrorE,
                      controller: _emailController,
                      hintText: 'Enter email',
                      obscureText: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          setState(() {
                            _hasErrorE = true;
                          });
                          return 'Please enter your email';
                        } else if (!RegExp(
                                r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                            .hasMatch(value)) {
                          setState(() {
                            _hasErrorE = true;
                          });
                          return 'Please enter email in correct format eg: something@likethis.com';
                        } else {
                          return null;
                        }
                      },
                    ),

                    // username field
                    MyTextFormField(
                      hasError: _hasErrorU,
                      controller: _usernameController,
                      hintText: 'Enter username',
                      obscureText: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          setState(() {
                            _hasErrorU = true;
                          });
                          return 'Please enter a username';
                        } else if (value.length < 2) {
                          setState(() {
                            _hasErrorU = true;
                          });
                          return 'Username must be atleast 2 characters long';
                        } else if (value.length >= 50) {
                          setState(() {
                            _hasErrorU = true;
                          });
                          return 'Username must be less than 50 characters long';
                        } else {
                          return null;
                        }
                      },
                    ),

                    // password field
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
                          return 'Please enter a password';
                        } else if (value.length < 8 ||
                            !value.contains(RegExp(r'\d+')) ||
                            !value.contains(RegExp(r'[A-Z]')) ||
                            !value.contains(RegExp(r'[!@#$%^&*()_+-~`?]'))) {
                          setState(() {
                            _hasErrorP = true;
                          });
                          return 'Password must be atleast 8 characters long, contain a number, a capital letter and a special character';
                        } else {
                          return null;
                        }
                      },
                    ),

                    // confirm password field
                    MyTextFormField(
                      hasError: _hasErrorCP,
                      controller: _confirmPasswordController,
                      hintText: 'Confirm password',
                      obscureText: _passwordNotVisible,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value != _passwordController.text) {
                          setState(() {
                            _hasErrorCP = true;
                          });
                          return 'Passwords don\'t match';
                        } else {
                          return null;
                        }
                      },
                    ),

                    const SizedBox(height: 15),

                    // sign up button
                    if (!isAuthenticating)
                      AuthButton(
                        onTap: signUserUp,
                        msg: 'Sign Up',
                      ),

                    if (isAuthenticating) const CircularProgressIndicator(),

                    const SizedBox(height: 20),

                    // already a member, sign in
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Already a member?',
                            style: TextStyle(
                                color: Colors.grey[700], fontSize: 16)),
                        const SizedBox(width: 4),
                        GestureDetector(
                          onTap: widget.onTap,
                          child: Text(
                            'Login here',
                            style: TextStyle(
                              color: isDarkMode
                                  ? Colors.blue[300]
                                  : Colors.blue[700],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
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
