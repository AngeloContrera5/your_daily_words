import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:group_button/group_button.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:your_daily_words/models/Words.dart';
import 'package:http/http.dart' as http;
import 'package:your_daily_words/providers/words_provider.dart';
import 'package:your_daily_words/widget/gallery_words.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, this.title}) : super(key: key);
  final title;

  @override
  State<HomePage> createState() => _HomePageState();
}

TextEditingController _textController = TextEditingController();
TextEditingController _textEnglishController = TextEditingController();

class _HomePageState extends State<HomePage> {
  SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';
  bool listening = false;

  @override
  void initState() {
    super.initState();
    _initSpeech();

    //widget.jsonWords = "[${widget.oWords.toModelString()}]";
  }

  /// This has to happen only once per app
  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  /// Each time to start a speech recognition session
  void _startListening() async {
    listening = true;
    await _speechToText.listen(onResult: _onSpeechResult);

    setState(() {
      _textController.text = "";
      _textEnglishController.text = "";
    });

    Fluttertoast.showToast(
      msg: "Escuchando...",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
    );
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  void _stopListening() async {
    listening = false;
    await _speechToText.stop();
    setState(() {});
  }

  /* Future traduccion() async {
    final textTranslator = await _lastWords.translate(from: "en", to: "es");
    textoTraducido = textTranslator.text;
  } */

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;

      print(_lastWords);

      _lastWords = _lastWords.substring(0, _lastWords.length - 1).toLowerCase();

      _textEnglishController.text = _lastWords != null ? _lastWords : "vacio";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.title,
            style: TextStyle(
                fontSize: 27, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        floatingActionButton: listening
            ? FloatingActionButton.large(
                onPressed: _stopListening, child: Icon(Icons.cancel, size: 60))
            : FloatingActionButton.large(
                onPressed: _startListening, child: Icon(Icons.mic, size: 60)),
        body: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                children: <Widget>[
                  Expanded(
                      child: SizedBox(
                    height: 400,
                    child: GalleryWords(),
                  ))
                ],
              ),

              /* _buildTextField(_textController, "Resultado"), */
              _buildTextField(_textEnglishController, "Resultado en ingles xd"),
            ],
          ),
        ));
  }

  /* _buildTextField(_textController, "Resultado"),
              _buildTextField(_textEnglishController, "Resultado en ingles xd"), */

  /* Widget basicDemo() {
    return CarouselSlider(
        options: CarouselOptions(height: 50),
        items: listWords
            .map((e) => Container(
                  color: Colors.green,
                  child: Center(child: Text(e.toString())),
                ))
            .toList());
  } */
}

////// TEXTFIELDS
_buildTextField(TextEditingController controller, String labelText) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
    child: TextField(
        controller: controller,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
            labelText: labelText,
            labelStyle: TextStyle(color: Colors.black),
            //prefix: Icon(Icons.add_circle),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            )),
        enabled: false),
  );
}
