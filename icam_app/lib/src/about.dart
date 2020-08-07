import 'package:flutter/material.dart';
import 'package:icam_app/localization/localization_constants.dart';
import 'package:icam_app/main.dart';

import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(getTranslated(context, "about")),
        ),
        body: Stack(
          children: <Widget> [
              ListView(
                  padding: const EdgeInsets.fromLTRB(
                    30.0,
                    kToolbarHeight - 40.0,
                    35.0,
                    30.0,
                  ),
                  children: <Widget> [
                    ProjectInfo(),
                    Divider(height: 40),
                    Features(),
                    Divider(height: 40),
                    Contact(),
                    Divider(height: 40),
                    SpecialThanks(),
                  ]
             )
          ]
       )
    );
  }
}

TextStyle _textStyleTitle = TextStyle(
    fontSize: 22,
    color: Colors.black87,
    fontWeight: FontWeight.w600
);

TextStyle _textStyleContent = TextStyle(
  fontSize: 15,
  color: Colors.black87,
  height: 1.5,
);

class ProjectInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                getTranslated(context, "project_info"),
                style: _textStyleTitle,
              ),
            ],
          ),
          SizedBox(height: 10.0),
          SingleChildScrollView(
              child: Text(
                appTitle + " " + getTranslated(context, "project_description"),
                style: _textStyleContent,
                textAlign: TextAlign.justify,
              )
          )
        ]
    );
  }
}


class Contact extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                getTranslated(context, "contact"),
                style: _textStyleTitle,
              ),
            ],
          ),
          SingleChildScrollView(
              child:
              Text(getTranslated(context, "contact_info"),
                style: _textStyleContent,
                textAlign: TextAlign.justify,
              )
          ),
          GestureDetector(
              child: Text(
                getTranslated(context, "join"),
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Colors.blue,
                    height: 2.5
                ),
                textAlign: TextAlign.justify,
              ),
              onTap: _launchURL
          )
        ]
    );
  }
}

_launchURL() async {
  const url = 'https://github.com/lauricdd/ICAM_app';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}


class SpecialThanks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                getTranslated(context, "thanks"),
                style: _textStyleTitle,
              ),
            ],
          ),
          SingleChildScrollView(
              child:
              Text(getTranslated(context, "thanks_info"),
                style: _textStyleContent,
                textAlign: TextAlign.justify,
              )
          ),
          SizedBox(height: 20),
          Image(
            image: AssetImage('assets/images/invemar.png'),
            height: 100,
            width: 100,
          )
        ]
    );
  }
}

class Features extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(getTranslated(context, "features"),
                style: _textStyleTitle,
              ),
            ],
          ),
          SizedBox(height: 30),
          _buildItem(
              icon: Icons.equalizer,
              title: getTranslated(context, "real_data").toUpperCase(),
              content: getTranslated(context, "real_data_text")
          ),
          SizedBox(height: 30),
          _buildItem(
              icon: Icons.lock_open,
              title: getTranslated(context, "no_restrictions").toUpperCase(),
              content: getTranslated(context, "no_restrictions_text") + appTitle +getTranslated(context, "no_restrictions_text2")
          ),
          SizedBox(height: 30),
          _buildItem(
              icon: Icons.cloud_download,
              title: getTranslated(context, "download").toUpperCase(),
              content: getTranslated(context, "download_text")
          )
        ]
    );
  }
}

Widget _buildItem({icon, String title, String content}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Material(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          color: Colors.red,
          child: Container(
              padding: EdgeInsets.all(5.0),
              child: Icon(
                  icon,
                  color: Colors.white,
                  size: 28.0
              )
          )
      ),
      SizedBox(
        width: 16.0,
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(title,
                style:
                TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0)
            ),
            SizedBox(
              height: 10.0,
            ),
            SingleChildScrollView(
                child: Text(
                  content,
                  style: _textStyleContent,
                  textAlign: TextAlign.justify,
                )
            )
//            Text(content),
          ],
        ),
      )
    ],
  );
}

//Container(
//height: 30,
//child: Row(
//children: <Widget>[
//Expanded(
//child: Row(
//mainAxisAlignment: MainAxisAlignment.center,
//children: <Widget>[
//Icon(Icons.memory),
//SizedBox(
//width: 5.0,
//),
//Text("65%")
//],
//),
//),
//VerticalDivider(),
//Expanded(
//child: Text(
//"Vegetarian",
//textAlign: TextAlign.center,
//),
//),
//VerticalDivider(),
//Expanded(
//child: Row(
//mainAxisAlignment: MainAxisAlignment.center,
//children: <Widget>[
//Icon(Icons.timer),
//SizedBox(
//width: 5.0,
//),
//Text("10 min")
//],
//),
//),
//],
//),
//),