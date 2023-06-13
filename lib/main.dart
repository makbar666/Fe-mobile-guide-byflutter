import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';

import 'Page1.dart';
import 'Page2.dart';
import 'Page3.dart';
import 'Page4.dart';
import 'article_search_delegate.dart';
import 'saved_articles.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => SavedArticles()..loadSavedArticles(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Guide by Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  void _showArticleSearch() {
    showSearch(
      context: context,
      delegate: ArticleSearchDelegate(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: IndexedStack(
                index: _currentIndex,
                children: [
                  Page1(),
                  GestureDetector(
                    onTap: () {
                      _showArticleSearch();
                    },
                    child: Page2(),
                  ),
                  Page3(),
                  Page4(),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 20,
                color: Colors.black.withOpacity(.1),
              )
            ],
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 1),
                child: GNav(
                  onTabChange: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  tabBorderRadius: 15,
                  curve: Curves.ease,
                  duration:
                      Duration(milliseconds: 500), // tab animation duration
                  gap: 8, // the tab button gap between icon and text
                  color: Colors.grey[600], // unselected icon color
                  activeColor:
                      Color(0xFF1B1B1B), // selected icon and text color
                  iconSize: 24, // tab button icon size
                  tabBackgroundColor: Color(0xFF1B1B1B)
                      .withOpacity(0.1), // selected tab background color
                  tabMargin: EdgeInsets.symmetric(vertical: 10),
                  padding: EdgeInsets.symmetric(
                      horizontal: 30, vertical: 14), // navigation bar padding
                  tabs: [
                    GButton(
                      icon: Icons.home,
                      text: 'Beranda',
                    ),
                    GButton(
                      icon: CupertinoIcons.search,
                      text: 'Cari',
                      onPressed: _showArticleSearch,
                    ),
                    GButton(
                      icon: CupertinoIcons.square_list_fill,
                      text: 'Kategori',
                    ),
                    GButton(
                      icon: CupertinoIcons.heart_fill,
                      text: 'Like',
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
