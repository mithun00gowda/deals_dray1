import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class cart_Screen extends StatefulWidget {
  const cart_Screen({super.key});

  @override
  State<cart_Screen> createState() => _cart_ScreenState();
}

class _cart_ScreenState extends State<cart_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Text('Cart'),
        ),
      ),
    );
  }
}
