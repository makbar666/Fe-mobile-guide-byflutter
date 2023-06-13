import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'profil.dart';
import 'saved_articles.dart';
import 'viewArticle2new.dart';
import 'Page2.dart';

class Page4 extends StatefulWidget {
  @override
  _Page4State createState() => _Page4State();
}

String _getShortContent(String content) {
  // Mengambil substring pertama dengan panjang tertentu
  return content.replaceAll(
      RegExp(r'<[^>]*>'), ''); // Menghapus tag HTML dari konten
}

class _Page4State extends State<Page4> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Disukai',
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
        body: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
            ),
            color: Color(0xFFF3F4F8),
          ),
          child: Consumer<SavedArticles>(
            builder: (context, savedArticles, _) {
              final articles = savedArticles.savedArticles;
              // Bangun tampilan berdasarkan perubahan pada savedArticles
              if (articles.isEmpty) {
                return Center(
                  child: Text('Belum ada artikel yang disimpan.'),
                );
              } else {
                return ListView.builder(
                  itemCount: articles.length,
                  itemBuilder: (context, index) {
                    final article = articles[index];
                    return Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10.0),
                      child: ListTile(
                        leading: Transform.scale(
                          scale: 1.0,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5.0),
                            child: Image.network(
                              article.imageUrl,
                              fit: BoxFit.cover,
                              width: 80.0, // Atur lebar gambar sesuai kebutuhan
                              height:
                                  50.0, // Atur tinggi gambar sesuai kebutuhan
                            ),
                          ),
                        ),
                        title: Text(
                          article.title,
                          style: TextStyle(
                            color: Colors.grey[900],
                            fontSize: 16.0,
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
                        },
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
