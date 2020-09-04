import 'package:flutter/material.dart';
import 'package:icam_app/localization/localization_constants.dart';
import 'package:data_connection_checker/data_connection_checker.dart';


class DialogItem extends StatelessWidget {
  const DialogItem({
    Key key,
    this.icon,
    this.color,
    this.text,
  }) : super(key: key);

  final IconData icon;
  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SimpleDialogOption(
      padding: EdgeInsets.all(2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, size: 30, color: color),
          Flexible(
            child: Padding(
              padding: const EdgeInsetsDirectional.only(start: 5, end: 0),
              child: Text(text,
                style: TextStyle(height: 1.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


showConnectivityDialog(context, function){
  return showDialog(
      context: context,
      builder: (_) => new AlertDialog(
        title: new Text("No internet connection"),
        content: new Text(getTranslated(context, "check_internet_connection")),
        actions: <Widget>[
          FlatButton(
            child: Text('Close me!'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            child: Text(getTranslated(context, "try_again")),
            onPressed: () async {
              // add markers to map
              function();

              if(await DataConnectionChecker().hasConnection){
                Navigator.of(context).pop();
              }
            },
          )
        ],
      ));
}
