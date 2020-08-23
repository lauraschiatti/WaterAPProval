import 'package:flutter/material.dart';

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
