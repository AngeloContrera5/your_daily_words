import 'package:flutter/material.dart';
import 'package:your_daily_words/pages/home_page.dart';
import 'package:your_daily_words/pages/translator_page.dart';

class NavigatorDrawerWidget extends StatefulWidget {
  NavigatorDrawerWidget({Key? key}) : super(key: key);

  @override
  State<NavigatorDrawerWidget> createState() => _NavigatorDrawerWidgetState();
}

class _NavigatorDrawerWidgetState extends State<NavigatorDrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.green,
      child: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 1),
            padding: EdgeInsets.all(10),
            width: double.infinity,
            child: buildMenuItem(
                text: "Learn",
                icon: Icons.abc,
                onClicked: () {
                  Navigator.of(context).pop();
                  selectedItem(context, 0);
                }),
          ),
          Container(
            margin: EdgeInsets.only(top: 1),
            padding: EdgeInsets.all(10),
            width: double.infinity,
            child: buildMenuItem(
                text: "Translate",
                icon: Icons.translate,
                onClicked: () {
                  Navigator.of(context).pop();
                  selectedItem(context, 1);
                }),
          ),
        ],
      ),
    );
  }

  void selectedItem(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
        break;
      case 1:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => TranslatorPage()));
        break;
    }
  }

  Widget buildMenuItem({
    String? text,
    IconData? icon,
    VoidCallback? onClicked,
  }) {
    final color = Colors.white;
    final hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(icon, color: color, size: 30),
      title: Text(text!, style: TextStyle(color: color, fontSize: 20)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }
}
