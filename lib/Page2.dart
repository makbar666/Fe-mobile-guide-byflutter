import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testing_gdrive/profil.dart';

import 'article_search_delegate.dart';

class Page2 extends StatefulWidget {
  const Page2({super.key});

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  String _firstName = '';
  String _lastName = '';

// cek isi shared_preferences apakah ada data atau tidak
  Future<void> _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Memeriksa apakah ada data yang tersimpan
    if (prefs.containsKey('first_name') && prefs.containsKey('last_name')) {
      // Mengambil data dari shared preferences
      String firstName = prefs.getString('first_name') ?? '';
      String lastName = prefs.getString('last_name') ?? '';

      setState(() {
        _firstName = firstName;
        _lastName = lastName;
      });

      // Menampilkan data di log
      print('First Name: $firstName');
      print('Last Name: $lastName');
    } else {
      print('Tidak ada data yang tersimpan di SharedPreferences');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xFFF3F4F8),
        appBar: AppBar(
          title: Text('Cari Artikel Disini',
              style: TextStyle(
                color: Color(0xFF1B1B1B),
                fontSize: 20,
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
                showSearch(
                  context: context,
                  delegate: ArticleSearchDelegate(),
                );
              },
            ),
            //  using flutter profile picture
            // GestureDetector(
            //   child: ProfilePicture(
            //     // import name from Profil.dart
            //     name: _firstName.isNotEmpty || _lastName.isNotEmpty
            //         ? _firstName + ' ' + _lastName
            //         : 'Blank',
            //     radius: 18,
            //     fontsize: 16,
            //   ),
            //   onTap: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => Profil(),
            //       ),
            //     );
            //   },
            // ),
            SizedBox(
              width: 10,
            ),
          ],
        ),
      ),
    );
  }
}
