import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testing_gdrive/onboarding.dart';

import 'Page1.dart';
import 'Page2.dart';
import 'Page3.dart';
import 'Page4.dart';
import 'article_search_delegate.dart';
import 'saved_articles.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(
    ChangeNotifierProvider(
      create: (_) => SavedArticles()..loadSavedArticles(),
      child: MyApp(),
    ),
  );
  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  Future<bool> checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seenOnboarding') ?? false);

    if (_seen) {
      return false;
    } else {
      await prefs.setBool('seenOnboarding', true);
      return true;
    }
  }

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: checkFirstSeen(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        } else {
          if (snapshot.hasError) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                body: Center(
                  child: Text('Error: ${snapshot.error}'),
                ),
              ),
            );
          } else {
            if (snapshot.data == true) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                home: OnboardingPage(),
              );
            } else {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                home: MyHomePage(),
              );
            }
          }
        }
      },
    );
    // return MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   title: 'Guide by Flutter',
    //   theme: ThemeData(
    //     primarySwatch: Colors.blue,
    //   ),
    //   home: OnboardingPage(),
    //   // home: MyHomePage(),
    // );
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
            // scrollDirection: Axis.horizontal,
            child: SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0),
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
                  // iconSize: 24, // tab button icon size
                  tabBackgroundColor: Color(0xFF1B1B1B)
                      .withOpacity(0.1), // selected tab background color
                  tabMargin: EdgeInsets.symmetric(vertical: 10),
                  padding: EdgeInsets.symmetric(
                      horizontal: 20, vertical: 14), // navigation bar padding
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
