import 'package:flutter/material.dart';
import 'package:your_daily_words/widget/navigation_drawer_widget.dart';

class TranslatorPage extends StatefulWidget {
  TranslatorPage({Key? key}) : super(key: key);

  @override
  State<TranslatorPage> createState() => _TranslatorPageState();
}

class _TranslatorPageState extends State<TranslatorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigatorDrawerWidget(),
      appBar: AppBar(
        title: Text(
          'Translator',
          style: TextStyle(
              fontSize: 27, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Container(),
    );
  }
}
