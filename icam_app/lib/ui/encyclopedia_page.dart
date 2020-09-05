import 'package:flutter/material.dart';
import 'package:icam_app/localization/localization_constants.dart';
import 'package:icam_app/theme.dart';
import 'package:icam_app/classes/widgets.dart';

class EncyclopediaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(getTranslated(context, "encyclopedia")),
        ),
        body: Stack(
            children: <Widget> [
              ListView(
                  padding: const EdgeInsets.fromLTRB(
                    30.0,
                    kToolbarHeight - 20.0,
                    35.0,
                    30.0,
                  ),
                  children: <Widget> [
                    IcamInfo(),
                    SizedBox(height: 10,),
                    IcamValues(),
                    Divider(height: 40),
                    DissolvedOxygen(),
                    Divider(height: 40),
                    NitratesAndPhosphates(),
                    Divider(height: 40),
                    TotalSuspendedSolids(),
                    Divider(height: 40),
                    ThermotolerantColiforms(),
                    Divider(height: 40),
                    pH(),
                    Divider(height: 40),
                    ChlorophyllA(),
                    Divider(height: 40),
                    BiochemicalOxygenDemand()
                  ]
              )
            ]
        )
    );
  }
}

TextStyle _textStyleTitle = TextStyle(
    fontSize: 20,
    color: Colors.black87,
    fontWeight: FontWeight.w600
);

TextStyle _textStyleContent = TextStyle(
  fontSize: 13,
  color: Colors.black87,
  height: 1.5,
);

class IcamInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                getTranslated(context, "what_is_icam"),
                style: _textStyleTitle,
              ),
            ],
          ),
          SizedBox(height: 10.0),
          SingleChildScrollView(
              child: Text(
                getTranslated(context, "icam_details"),
                style: _textStyleContent,
                textAlign: TextAlign.justify,
              )
          ),
        ]
    );
  }
}

class IcamValues extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                getTranslated(context, "icam_values"),
                style: _textStyleTitle,
              ),
            ],
          ),
          SizedBox(height: 10.0),
          SingleChildScrollView(
            padding: EdgeInsets.all(0),
            child: ListBody(
              children: <Widget>[
                DialogItem(
                  icon: Icons.brightness_1,
                  color: Colors.black54,
                  text: getTranslated(context, "unavailable"),
                ),
                DialogItem(
                  icon: Icons.brightness_1,
                  color: Colors.redAccent[700],
                  text: getTranslated(context, "poor"),
                ),
                DialogItem(
                  icon: Icons.brightness_1,
                  color: Colors.orange,
                  text: getTranslated(context, "inadequate"),
                ),
                DialogItem(
                  icon: Icons.brightness_1,
                  color: Colors.yellow[600],
                  text: getTranslated(context, "acceptable"),
                ),
                DialogItem(
                  icon: Icons.brightness_1,
                  color: Colors.green,
                  text: getTranslated(context, "adequate"),
                ),
                DialogItem(
                  icon: Icons.brightness_1,
                  color: myTheme.primaryColor,
                  text: getTranslated(context, "optimal"),
                ),
              ],
            ),
          )
        ]

    );
  }

}

class DissolvedOxygen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                getTranslated(context, "dissolved_oxygen"),
                style: _textStyleTitle,
              ),
            ],
          ),
          SingleChildScrollView(
              child:
              Text(
                getTranslated(context, "what_is_dissolved_oxygen"),
                style: _textStyleContent,
                textAlign: TextAlign.justify,
              )
          )
        ]
    );
  }
}

class NitratesAndPhosphates extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                getTranslated(context, "nitrate") + "-" + getTranslated(context, "phosphates"),
                style: _textStyleTitle,
              ),
            ],
          ),
          SingleChildScrollView(
              child:
              Text(
                getTranslated(context, "what_is_nitrate_phosphates"),
                style: _textStyleContent,
                textAlign: TextAlign.justify,
              )
          )
        ]
    );
  }
}

class TotalSuspendedSolids extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                getTranslated(context, "total_suspended_solids"),
                style: _textStyleTitle,
              ),
            ],
          ),
          SingleChildScrollView(
              child:
              Text(
                getTranslated(context, "what_is_total_suspended_solids"),
                style: _textStyleContent,
                textAlign: TextAlign.justify,
              )
          )
        ]
    );
  }
}

class ThermotolerantColiforms extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                getTranslated(context, "thermotolerant_coliforms"),
                style: _textStyleTitle,
              ),
            ],
          ),
          SingleChildScrollView(
              child:
              Text(
                getTranslated(context, "what_is_thermotolerant_coliforms"),
                style: _textStyleContent,
                textAlign: TextAlign.justify,
              )
          )
        ]
    );
  }
}

class pH extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                getTranslated(context, "ph"),
                style: _textStyleTitle,
              ),
            ],
          ),
          SingleChildScrollView(
              child:
              Text(
                getTranslated(context, "what_is_ph"),
                style: _textStyleContent,
                textAlign: TextAlign.justify,
              )
          )
        ]
    );
  }
}

class ChlorophyllA extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                getTranslated(context, "chrolophyll_a"),
                style: _textStyleTitle,
              ),
            ],
          ),
          SingleChildScrollView(
              child:
              Text(
                getTranslated(context, "what_is_chrolophyll_a"),
                style: _textStyleContent,
                textAlign: TextAlign.justify,
              )
          )
        ]
    );
  }
}


class BiochemicalOxygenDemand extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                getTranslated(context, "biochemical_oxygen_demand"),
                style: _textStyleTitle,
              ),
            ],
          ),
          SingleChildScrollView(
              child:
              Text(
                getTranslated(context, "what_is_biochemical_oxygen_demand"),
                style: _textStyleContent,
                textAlign: TextAlign.justify,
              )
          )
        ]
    );
  }
}
