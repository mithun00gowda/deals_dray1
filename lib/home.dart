import 'package:deals_dray/pages/cart.dart';
import 'package:deals_dray/pages/colors.dart';
import 'package:deals_dray/pages/favorite.dart';
import 'package:deals_dray/pages/home_screen.dart';
import 'package:deals_dray/pages/lists_item.dart';
import 'package:deals_dray/pages/profile.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    int currentIndex = 2;
    List sreens = [
      ListsItem(),
      Favorite(),
      HomeScreen(),
      cart_Screen(),
      Profile(),
    ];
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            currentIndex = 2;
          });
        },
        backgroundColor: kPrimaryColor,
        shape: CircleBorder(),
        child: const Icon(
          Icons.home,
          color: Colors.white,
          size: 30,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        elevation: 1,
        height: 60,
        color: Colors.white,
        shape: CircularNotchedRectangle(),
        notchMargin: 20,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                onPressed: () {
                  setState(() {
                    currentIndex = 0;
                  });
                },
                icon: Icon(
                  Icons.grid_view_outlined,
                  size: 30,
                  color:
                      currentIndex == 0 ? kPrimaryColor : Colors.grey.shade400,
                )),
            IconButton(
                onPressed: () {
                  setState(() {
                    currentIndex = 1;
                  });
                },
                icon: Icon(
                  Icons.favorite_outline,
                  size: 30,
                  color:
                      currentIndex == 1 ? kPrimaryColor : Colors.grey.shade400,
                )),
            SizedBox(
              width: 15,
            ),
            IconButton(
                onPressed: () {
                  setState(() {
                    currentIndex = 3;
                  });
                },
                icon: Icon(
                  Icons.shopping_cart_outlined,
                  size: 30,
                  color:
                      currentIndex == 3 ? kPrimaryColor : Colors.grey.shade400,
                )),
            IconButton(
                onPressed: () {
                  setState(() {
                    currentIndex = 4;
                  });
                },
                icon: Icon(
                  Icons.person_2_outlined,
                  size: 30,
                  color:
                      currentIndex == 4 ? kPrimaryColor : Colors.grey.shade400,
                ))
          ],
        ),
      ),
      body: sreens[currentIndex],
    );
  }
}
