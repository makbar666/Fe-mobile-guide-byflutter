import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_gifs/loading_gifs.dart';
import 'package:shimmer/shimmer.dart';
import 'Page2.dart';
import 'profil.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'viewArticle2new.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';

class Article {
  final int id;
  final String title;
  final String imageUrl;
  final String content;

  Article({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.content,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id'],
      title: json['title'],
      imageUrl: json['imageUrl'],
      content: json['content'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'imageUrl': imageUrl,
      'content': content,
    };
  }
}

class Page1 extends StatefulWidget {
  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  late Future<List<Article>> _futureArticles;
  late List<Article> _articles = [];

  @override
  void initState() {
    super.initState();
    _futureArticles = fetchArticles();
    _loadData();
  }

  Future<List<Article>> fetchArticles() async {
    final blogId = '2724810228291298258';
    final apiKey = 'AIzaSyAptK7bUXkAZL4UAY31Xfw0fP4xkEa9VTc';

    final url =
        'https://www.googleapis.com/blogger/v3/blogs/$blogId/posts?key=$apiKey&maxResults=50';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final articles = <Article>[];

      for (var item in data['items']) {
        final title = item['title'];
        final content = item['content'];

        // Mengambil URL gambar menggunakan regex
        final regex = RegExp(r'(?<=src=")(.*?)(?=")');
        final match = regex.firstMatch(content);
        final imageUrl = match?.group(0) ?? '';

        articles.add(Article(
            id: articles.length + 1,
            title: title,
            imageUrl: imageUrl,
            content: content));
      }

      return articles;
    } else {
      throw Exception('Failed to fetch articles');
    }
  }

  String _getShortContent(String content) {
    // Mengambil substring pertama dengan panjang tertentu
    return content.replaceAll(
        RegExp(r'<[^>]*>'), ''); // Menghapus tag HTML dari konten
  }

  void main() async {
    try {
      final articles = await fetchArticles();
      for (var article in articles) {
        print('Title: ${article.title}');
        print('Image URL: ${article.imageUrl}');
        print('Content: ${article.content})');

        print('---');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  // i want to create a function to load more articles when the user click the button
  Future<void> loadMoreArticles() async {
    try {
      final articles = await fetchArticles();
      setState(() {
        _articles.addAll(articles);
      });
    } catch (e) {
      print('Error: $e');
    }
  }

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
          title: Text('Guide by flutter',
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
            //  using flutter profile picture
            GestureDetector(
              child: ProfilePicture(
                // import name from Profil.dart
                name: _firstName.isNotEmpty || _lastName.isNotEmpty
                    ? _firstName + ' ' + _lastName
                    : 'Blank',
                radius: 18,
                fontsize: 16,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Profil(),
                  ),
                );
              },
            ),
            SizedBox(
              width: 10,
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
            ),
            color: Color(0xFFF3F4F8),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                FutureBuilder<List<Article>>(
                  future: _futureArticles,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final articles = snapshot.data!;
                      _articles.addAll(articles);
                      final topArticle = _articles[0];

                      return Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(10, 5, 10, 5),
                                      child: ImageSlideshow(
                                        height: 230,
                                        children: [
                                          for (var article in articles.take(5))
                                            Stack(
                                              children: [
                                                // ==================== Gambar Artikel ====================
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              10.0)),
                                                  child: Image.network(
                                                    article.imageUrl,
                                                    height: 200.0,
                                                    width: double.infinity,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),

                                                //  ==================== Judul Artikel ====================
                                                Positioned(
                                                  bottom: 30.0,
                                                  left: 0.0,
                                                  right: 0.0,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      gradient: LinearGradient(
                                                        colors: [
                                                          Colors.black
                                                              .withOpacity(0.3),
                                                          Colors.black
                                                              .withOpacity(0.5)
                                                        ],
                                                        begin:
                                                            Alignment.topCenter,
                                                        end: Alignment
                                                            .bottomCenter,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        bottomLeft:
                                                            Radius.circular(
                                                                10.0),
                                                        bottomRight:
                                                            Radius.circular(
                                                                10.0),
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 5.0,
                                                              horizontal: 10.0),
                                                      child: Column(
                                                        children: [
                                                          Text(
                                                            article.title,
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 16.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                // SizedBox(height: 10.0),
                              ],
                            ),
                          ),
                          // ============================ List of articles ============================
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: articles.length -
                                0, // Mengurangi satu dari jumlah artikel karena sudah menampilkan yang paling atas
                            itemBuilder: (context, index) {
                              final article = articles[index +
                                  0]; // Melakukan penyesuaian indeks untuk artikel selain yang paling atas
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 10.0),
                                child: ListTile(
                                    leading: Transform.scale(
                                      scale: 1.0,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        child: FadeInImage.assetNetwork(
                                          placeholder:
                                              cupertinoActivityIndicator, // Gambar placeholder yang ditampilkan saat sedang memuat
                                          image: article.imageUrl,
                                          fit: BoxFit.cover,
                                          width: 80.0,
                                          height: 50.0,
                                          // onError menangani kasus ketika gambar gagal dimuat
                                          // Misalnya, Anda dapat menampilkan ikon error atau teks error
                                          // atau widget lain yang sesuai dengan kebutuhan Anda.
                                          // Contoh di bawah ini menampilkan teks 'Failed to load image'
                                          // dengan latar belakang berwarna merah.
                                        ),
                                      ),
                                    ),
                                    title: Text(
                                      article.title,
                                      style: TextStyle(
                                        color: Color(0xFF1B1B1B),
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    subtitle: Text(
                                      _getShortContent(article.content),
                                      style: TextStyle(
                                        color: Colors.grey.withOpacity(1),
                                        fontSize: 14.0,
                                      ),
                                      maxLines: 2,
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ViewArticle2(article: article),
                                        ),
                                      );
                                    }),
                              );
                            },
                          ),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Failed to fetch articles'));
                    }
                    return Column(children: [
                      // menampilkan skeleton loading selama 5 detik sebelum data ditampilkan
                      // membuat time delay selama 5 detik
                      FutureBuilder(
                        future: Future.delayed(Duration(seconds: 10)),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return Container(
                              child: Center(
                                child: Text('Failed to fetch articles'),
                              ),
                            );
                          }
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: 10,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.symmetric(vertical: 10.0),
                                child: ListTile(
                                  leading: Shimmer.fromColors(
                                    baseColor: Colors.grey[300]!,
                                    highlightColor: Colors.grey[100]!,
                                    loop: 1,
                                    child: Container(
                                      width: 80.0,
                                      height: 50.0,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                    ),
                                  ),
                                  title: Shimmer.fromColors(
                                    baseColor: Colors.grey[300]!,
                                    highlightColor: Colors.grey[100]!,
                                    child: Container(
                                      width: 200.0,
                                      height: 10.0,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                    ),
                                  ),
                                  subtitle: Shimmer.fromColors(
                                    baseColor: Colors.grey[300]!,
                                    highlightColor: Colors.grey[100]!,
                                    child: Container(
                                      width: 200.0,
                                      height: 8.0,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ]);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
