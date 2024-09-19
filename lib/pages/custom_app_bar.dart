import 'package:deals_dray/pages/colors.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
            style: IconButton.styleFrom(
                backgroundColor: kcontentColor,
                padding: const EdgeInsets.all(20)),
            onPressed: () {},
            icon: const Icon(Icons.menu_outlined)),
        IconButton(
            style: IconButton.styleFrom(
                backgroundColor: kcontentColor,
                padding: const EdgeInsets.all(20)),
            onPressed: () {},
            icon: const Icon(Icons.notifications_outlined)),
      ],
    );
  }
}
