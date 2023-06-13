import 'package:flutter/material.dart';
import 'package:loading_gifs/loading_gifs.dart';
import 'package:testing_gdrive/Page1.dart';
import 'package:testing_gdrive/viewArticle2new.dart';
import 'article.dart';

String _getShortContent(String content) {
  // Mengambil substring pertama dengan panjang tertentu
  return content.replaceAll(
      RegExp(r'<[^>]*>'), ''); // Menghapus tag HTML dari konten
}

class ArticleSearchDelegate extends SearchDelegate<List<Article>> {
  @override
  String get searchFieldLabel => 'Cari artikel';

  @override
  TextStyle get searchFieldStyle =>
      TextStyle(color: Color(0xFF1B1B1B), fontSize: 16);

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      appBarTheme: AppBarTheme(
        color: Colors.white,
        elevation: 0,
      ),
      textTheme: theme.textTheme.copyWith(
        headline6: TextStyle(
          color: Color(0xFF1B1B1B),
          fontSize: 18,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(
          color: Colors.grey.withOpacity(0.8),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.withOpacity(0.8), width: 1),
        ),
      ),
      scaffoldBackgroundColor: Colors.white,
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        color: Color(0xFF1B1B1B),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      color: Color(0xFF1B1B1B),
      onPressed: () {
        close(context, []);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isEmpty) {
      return Center(
        child: Text('Masukkan kata kunci pencarian'),
      );
    } else {
      return FutureBuilder<List<Article>>(
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Gagal memuat data'),
            );
          } else {
            final articles = snapshot.data ?? [];
            if (articles.isEmpty) {
              return Center(
                child: Text('Tidak ada artikel yang ditemukan'),
              );
            } else {
              return ListView.builder(
                itemCount: articles.length,
                itemBuilder: (context, index) {
                  final article = articles[index];
                  return ListTile(
                    title: Text(article.title),
                    subtitle: Text(article.content),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ViewArticle2(article: article),
                        ),
                      );
                    },
                  );
                },
              );
            }
          }
        },
      );
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Center(
        child: Text('Masukkan kata kunci pencarian'),
      );
    } else {
      return FutureBuilder<List<Article>>(
        future: searchArticles(query),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Failed to load articles'),
            );
          } else {
            final articles = snapshot.data ?? [];
            if (articles.isEmpty) {
              return Center(
                child: Text('No articles found'),
              );
            } else {
              return ListView.builder(
                itemCount: articles.length,
                itemBuilder: (context, index) {
                  final article = articles[index];
                  return Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                    child: ListTile(
                      leading: Transform.scale(
                        scale: 1.0,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5.0),
                          child: FadeInImage.assetNetwork(
                            placeholder:
                                cupertinoActivityIndicator, // Gambar placeholder yang ditampilkan saat sedang memuat
                            image: article.imageUrl,
                            fit: BoxFit.cover,
                            width: 80.0,
                            height: 50.0,
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
                      },
                    ),
                  );
                },
              );
            }
          }
        },
      );
    }
  }
}
