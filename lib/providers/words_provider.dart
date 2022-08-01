/* import 'package:flutter/material.dart';
import 'package:your_daily_words/models/Words.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:your_daily_words/util/util.dart' as util;

class WordsProvider {
  String urlWords = "words";
  String urlWordsEng = "wordsEng";
  String urlWordsEsp = "wordsEsp";
  String jsonResult = "";

  Future<List<Words>> _getWords(Words pWords) async {
    final urlListAllWords = '${util.urlBase}/${this.urlWords}';

    var response = await http.get(Uri.parse(urlListAllWords));
    var data = response.body;
    jsonResult = "[${Words().toModelString()}]";
    print(jsonResult);
    List<Words> oListWords = [];
    if (data != "") {
      oListWords =
          List<Words>.from(json.decode(data).map((x) => Words.fromJson(x)));
      jsonResult = data;
    }
    return oListWords;
  }
}
 */