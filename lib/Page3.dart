import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:testing_gdrive/Page2.dart';
import 'profil.dart';
import 'label/Label1.dart';

class Page3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            title: Text('Kategori',
                style: TextStyle(
                  color: Color(0xFF1B1B1B),
                  fontSize: 24,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                )),
            elevation: 0,
            backgroundColor: Color(0xFFFFFFFF),
            toolbarHeight: 68,
            actions: [
              IconButton(
                icon: Icon(Icons.search),
                // icon color and size
                color: Color(0xFF1B1B1B),
                iconSize: 30,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Page2(),
                    ),
                  );
                },
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.count(
              crossAxisCount: 3,
              mainAxisSpacing: 15,
              crossAxisSpacing: 10,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              Label1()), // Ganti dengan halaman yang sesuai
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFA4E3DA),
                      borderRadius:
                          BorderRadius.circular(5), // Tambahkan border radius
                    ),
                    height: 100,
                    width: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Korea',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFFDA88B),
                    borderRadius:
                        BorderRadius.circular(5), // Tambahkan border radius
                  ),
                  height: 100,
                  width: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Barat',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF9EBEF1),
                    borderRadius:
                        BorderRadius.circular(5), // Tambahkan border radius
                  ),
                  height: 100,
                  width: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Japan',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFF69FD6),
                    borderRadius:
                        BorderRadius.circular(5), // Tambahkan border radius
                  ),
                  height: 100,
                  width: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Indonesia',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF8786FB),
                    borderRadius:
                        BorderRadius.circular(5), // Tambahkan border radius
                  ),
                  height: 100,
                  width: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Trending',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFF88C8C),
                    borderRadius:
                        BorderRadius.circular(5), // Tambahkan border radius
                  ),
                  height: 100,
                  width: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Old',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
