import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/Words.dart';

class GalleryWords extends StatefulWidget {
  const GalleryWords({Key? key}) : super(key: key);

  @override
  State<GalleryWords> createState() => _GalleryWordsState();
}

late Future<List<Words>> _listWords;

List<Words> _listTempWords = [];

class _GalleryWordsState extends State<GalleryWords> {
  @override
  void initState() {
    super.initState();
    _listWords = _getWords();
    _getWords();
    // getDataFromList();
  }

  Future<List<Words>> _getWords() async {
    String url = "https://api-ydw-contreras.herokuapp.com/api/v1/words/1";
    final response = await http.get(Uri.parse(url));

    List<Words> words = [];

    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);

      final jsonData = jsonDecode(body);

      for (var item in jsonData) {
        words.add(Words(item["idWord"], item["wordsEng"], item["wordsEsp"]));
      }

      print(jsonData[0]["wordsEng"].toString());

      return words;
    } else {
      throw Exception("Fallo _getWords");
    }
  }

  void getDataFromList() async {
    _listTempWords = await _getWords();
  }

  ///////////////////////////////// IMPLEMENTAR EL CARRUSEL AQUI CON LA DATA EN ARRAY

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: /* CarouselSlider(
        options: CarouselOptions(height: 400.0),
        items: _listTempWords.map((i) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(color: Colors.amber),
                  child: Text(
                    'text' + i.wordsEng!,
                    style: TextStyle(fontSize: 16.0),
                  ));
            },
          );
        }).toList(),
      ), */

          FutureBuilder(
              future: _listWords,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView(
                    scrollDirection: Axis.horizontal,
                    children: _listadoWords(snapshot.data),
                  );
                } else if (snapshot.hasError) {
                  print(snapshot.error);
                  return Text("error");
                }

                return Center(child: CircularProgressIndicator());
              }),
    );
  }

  List<Widget> _listadoWords(data) {
    List<Widget> words = [];
    for (var word in data) {
      words.add(Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: RaisedButton(
          onPressed: () {
            print(word.idWord);
          },
          child: Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.20),
            child: Text(
              word.wordsEng,
              style: TextStyle(fontSize: 60),
            ),
          ),
        ),
      ));
    }
    return words;
  }
}
