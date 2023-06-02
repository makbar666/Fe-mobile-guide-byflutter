import 'package:flutter/material.dart';
import 'package:anim_search_app_bar/anim_search_app_bar.dart';

class Page2 extends StatefulWidget {
  const Page2({super.key});

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            AnimSearchAppBar(
              backgroundColor: Color(0xFF2C7873),
              cancelButtonText: "Cancel",
              hintText: 'Cari Yang Kamu Mau Disini',
              appBar: AppBar(
                backgroundColor: Color(0xFF2C7873),
                title: Text('Cari Guide'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
