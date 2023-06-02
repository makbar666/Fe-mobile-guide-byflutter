import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'Page1.dart';

class SavedArticles extends ChangeNotifier {
  List<Article> _savedArticles = [];

  bool _isLoading = false;

  List<Article> get savedArticles => _savedArticles;

  bool get isLoading => _isLoading;

  void addSavedArticle(Article article) {
    _savedArticles.add(article);
    notifyListeners(); // Menyampaikan perubahan pada data kepada pendengar
  }

  void removeSavedArticle(Article article) {
    _savedArticles.remove(article);
    notifyListeners(); // Menyampaikan perubahan pada data kepada pendengar
  }

  Future<void> loadSavedArticles() async {
    _isLoading = true;
    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedArticleStrings = prefs.getStringList('saved_articles');

    if (savedArticleStrings != null) {
      _savedArticles = savedArticleStrings
          .map((articleJson) => Article.fromJson(jsonDecode(articleJson)))
          .toList();
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> toggleSaved(Article article) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedArticleStrings = prefs.getStringList('saved_articles');

    if (savedArticleStrings != null) {
      List<Article> savedArticles = savedArticleStrings
          .map((articleJson) => Article.fromJson(jsonDecode(articleJson)))
          .toList();

      if (savedArticles.contains(article)) {
        savedArticles.remove(article);
      } else {
        savedArticles.add(article);
      }

      savedArticleStrings =
          savedArticles.map((article) => jsonEncode(article.toJson())).toList();
    } else {
      savedArticleStrings = [jsonEncode(article.toJson())];
    }

    await prefs.setStringList('saved_articles', savedArticleStrings);
    _savedArticles = savedArticleStrings
        .map((articleJson) => Article.fromJson(jsonDecode(articleJson)))
        .toList();

    notifyListeners();
  }
}
