import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'saved_articles.dart';
import 'article.dart';

class ViewArticle2 extends StatefulWidget {
  final Article article;

  ViewArticle2({required this.article});

  @override
  State<ViewArticle2> createState() => _ViewArticle2State();
}

class _ViewArticle2State extends State<ViewArticle2> {
  bool isSaved = false;

  @override
  void initState() {
    super.initState();
    checkIfSaved();
  }

  void checkIfSaved() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedArticleStrings = prefs.getStringList('saved_articles');

    if (savedArticleStrings != null) {
      List<Article> savedArticles = savedArticleStrings
          .map((articleJson) => Article.fromJson(jsonDecode(articleJson)))
          .toList();

      setState(() {
        isSaved = savedArticles
            .any((article) => article.title == widget.article.title);
      });
    }
  }

  void toggleSaved() async {
    setState(() {
      isSaved = !isSaved;
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedArticleStrings = prefs.getStringList('saved_articles');

    if (savedArticleStrings != null) {
      List<Article> savedArticles = savedArticleStrings
          .map((articleJson) => Article.fromJson(jsonDecode(articleJson)))
          .toList();

      bool isArticleSaved =
          savedArticles.any((article) => article.title == widget.article.title);

      if (isArticleSaved) {
        savedArticles
            .removeWhere((article) => article.title == widget.article.title);
      } else {
        savedArticles.add(widget.article);
      }

      savedArticleStrings =
          savedArticles.map((article) => jsonEncode(article.toJson())).toList();
    } else {
      savedArticleStrings = [jsonEncode(widget.article.toJson())];
    }

    await prefs.setStringList('saved_articles', savedArticleStrings);

    // fungsi if dimana jika artikel disimpan maka akan muncul snackbar
    if (isSaved) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Artikel disimpan'),
          duration: Duration(seconds: 3),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Artikel dihapus'),
          duration: Duration(seconds: 3),
        ),
      );
    }

    // Reload Page4 setelah proses penyimpanan selesai
    Provider.of<SavedArticles>(context, listen: false).loadSavedArticles();
  }

  List<Widget> _parseContent(String content) {
    List<Widget> widgets = [];

    widgets.add(
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          widget.article.title,
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
    widgets.add(SizedBox(height: 10.0));

    widgets.add(
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Html(
          data: content,
          tagsList: [],
          style: {},
          // saya ingin mengubah  "alt text" , "title text" , "toggle caption"
        ),
      ),
    );

    return widgets;
  }

  String _stripHtmlTags(String htmlString) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    return htmlString.replaceAll(exp, '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xFF1B1B1B)),
        title: Text(
          widget.article.title,
          style: TextStyle(fontSize: 18.0, color: Color(0xFF1B1B1B)),
        ),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: toggleSaved,
            tooltip: isSaved ? 'Hapus dari Disukai' : 'Simpan',
            icon: Icon(
                isSaved
                    ? Icons.bookmark_outlined
                    : Icons.bookmark_border_rounded,
                color: Color(0xFF1B1B1B)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10.0),
            Column(
              children: _parseContent(widget.article.content),
            ),
          ],
        ),
      ),
    );
  }
}
