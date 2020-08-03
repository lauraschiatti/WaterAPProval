import 'package:flutter/material.dart';
import 'package:icam_app/localization/localization_constants.dart';
import 'package:icam_app/main.dart';
import 'package:icam_app/theme.dart';

import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(getTranslated(context, "about")),
        ),
        body: SafeArea(
          child: ListView(
              children: <Widget>[
                Container(
                    margin: const EdgeInsets.fromLTRB(40.0, 30.0, 40.0, 30.0),
                    child: new Column(
                      children: <Widget>[
                        ProjectInfo(),
                        Contact(),
                        Features(),
                        SpecialThanks(),
                      ],
                    )
                ),
              ]
          ),
        )
    );
  }
}


TextStyle _textStyleTitle = TextStyle(
    height: 2.2,
    fontSize: 20,
    color: Colors.black87,
    fontWeight: FontWeight.w600
);

TextStyle _textStyleSubtitle = TextStyle(
    fontWeight: FontWeight.bold,
    height: 2.0
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
          Text(
            getTranslated(context, "project_info"),
            style: _textStyleTitle,
          ),
          SingleChildScrollView(
              child: Text(
                appTitle + " " + getTranslated(context, "project_description"),
                style: _textStyleContent,
                textAlign: TextAlign.justify,
              )
          ),
          Divider(
            height: 30,
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
          Text(getTranslated(context, "contact"),
            style: _textStyleTitle,
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
          ),
          Divider(
            height: 30,
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
          Text(getTranslated(context, "thanks"),
            style: _textStyleTitle,
          ),
          SingleChildScrollView(
              child: Text(getTranslated(context, "thanks_info"),
                style: _textStyleContent,
                textAlign: TextAlign.justify,
              )
          ),
          SizedBox(height: 20),
          Image(
            image: AssetImage('assets/images/invemar.png'),
            height: 100,
            width: 100,
          ),
          Divider(
            height: 30,
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
          Text(getTranslated(context, "features"),
            style: _textStyleTitle,
          ),
          SizedBox(height: 20),
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(Icons.equalizer),
                  Text(
                     " " + getTranslated(context, "real_data"),
                     style: _textStyleSubtitle
                  ),
                  SizedBox(height: 20),
                ],
              ),
              SingleChildScrollView(
                  child: Text(
                      getTranslated(context, "real_data_text"),
                      style: _textStyleContent,
                      textAlign: TextAlign.justify,
                  )
              ),
            ],
          ),
          SizedBox(height: 20),
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(Icons.lock_open),
                  Text(
                    " " + getTranslated(context, "no_restrictions"),
                    style: _textStyleSubtitle
                  ),
                  SizedBox(height: 20),
                ],
              ),
              SingleChildScrollView(
                  child: Text(
                    getTranslated(context, "no_restrictions_text") + appTitle +getTranslated(context, "no_restrictions_text2"),
                    style: _textStyleContent,
                    textAlign: TextAlign.justify,
                  )
              ),
            ],
          ),
          SizedBox(height: 20),
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(Icons.cloud_download),
                  Text(
                    " " + getTranslated(context, "download"),
                    style: _textStyleSubtitle
                  ),
                  SizedBox(height: 20),
                ],
              ),
              SingleChildScrollView(
                  child: Text(
                    getTranslated(context, "download_text"),
                    style: _textStyleContent,
                    textAlign: TextAlign.justify,
                  )
              ),
            ],
          )
        ]
    );
  }
}