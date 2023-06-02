import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'profil.dart';

class Page3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xFF2C7873),
        appBar: AppBar(
          title: Text(
            'Kategori',
          ),
          elevation: 0,
          backgroundColor: Color(0xFF2C7873),
          toolbarHeight: 78,
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(CupertinoIcons.person_crop_circle),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Profil(),
                  ),
                );
              },
            ),
          ],
        ),
        body: Column(
            // children: [
            //   Expanded(
            //     child: Container(
            //       decoration: BoxDecoration(
            //         borderRadius: BorderRadius.only(
            //           topLeft: Radius.circular(32),
            //           topRight: Radius.circular(32),
            //         ),
            //         color: Colors.white,
            //       ),
            //     ),
            //   ),
            // ],
            ),
      ),
    );
  }
}
