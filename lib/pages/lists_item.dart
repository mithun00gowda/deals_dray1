import 'package:flutter/material.dart';

class ListsItem extends StatefulWidget {
  const ListsItem({super.key});

  @override
  State<ListsItem> createState() => _ListsItemState();
}

class _ListsItemState extends State<ListsItem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Text('List'),
        ),
      ),
    );
  }
}
