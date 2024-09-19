import 'package:deals_dray/modules/products.dart';
import 'package:deals_dray/pages/categoriesScreen.dart';
import 'package:deals_dray/pages/colors.dart';
import 'package:deals_dray/pages/custom_app_bar.dart';
import 'package:deals_dray/pages/imageSlider.dart';
import 'package:deals_dray/pages/productWidget.dart';
import 'package:deals_dray/pages/search_bar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentSlide = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            const CustomAppBar(),
            const SizedBox(
              height: 10,
            ),
            const SearchBar_widget(),
            const SizedBox(
              height: 10,
            ),
            ImageSlider(
                currentSlide: currentSlide,
                onChange: (value) {
                  setState(() {
                    currentSlide = value;
                  });
                }),
            const SizedBox(
              height: 10,
            ),
            const Categoriesscreen(),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Special For You',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800),
                ),
                Text(
                  'See All',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ),
            GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context, index) {
                  return;
                })
          ],
        ),
      ),
    ));
  }
}
