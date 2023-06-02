import 'package:flutter/material.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Guide by Flutter'),
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(
                color: Colors.white,
                child: Center(
                  child: Text(
                    'Content',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ),
            ),
            DotNavigationBar(
              currentIndex: _currentIndex,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                  if (index == 2) {
                    Navigator.pushNamed(context,
                        '/Page1'); // Pindah ke halaman Person jika indeks adalah 2 (Person)
                  }
                });
              },
              items: [
                DotNavigationBarItem(
                  icon: Icon(Icons.home),
                  selectedColor: Colors.blue,
                ),
                DotNavigationBarItem(
                  icon: Icon(Icons.search),
                  selectedColor: Colors.red,
                ),
                DotNavigationBarItem(
                  icon: Icon(Icons.person),
                  selectedColor: Colors.green,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
