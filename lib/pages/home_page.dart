// Contains only partial code
// For preview or code access email Varun at kaushalvarunkv@gmail.com
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text(
        'Home page\nFor Full code preview/access\n email Varun @kaushalvarunkv@gmail.com',
      ),
    );
  }
}
