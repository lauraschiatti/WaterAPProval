import 'package:flutter/material.dart';
import 'package:icam_app/localization/localization_constants.dart';

final priceTextStyle = TextStyle(
  color: Colors.grey.shade600,
  fontSize: 20.0,
  fontWeight: FontWeight.bold,
);

class EncyclopediaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(getTranslated(context, "encyclopedia"))
      ),
      body: Stack(
        children: <Widget> [
          ListView(
            padding: const EdgeInsets.fromLTRB(
              16.0,
              kToolbarHeight - 20.0,
              16.0,
              16.0,
            ),
            children: <Widget> [
              ICAMInfo(),
            ],
          ),
        ],
      ),
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

class ICAMInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                "What is ICAMpff?",
                style: _textStyleTitle,
              ),
            ],
          ),
          SizedBox(height: 10.0),
          SingleChildScrollView(
              child: Text(
                "In Colombia, the Water quality index to preserve the marine biota (ICAMPFF) developed by the Institute of Marine and Coastal Research (INVEMAR, due to its initials in Spanish), considers seven parameters: dissolved oxygen, nitrates and nitrites, total phosphates, total suspended solids, biological oxygen demand, fecal coliforms and pH, to study the impact of domestic contamination in marine waters. ",
                style: _textStyleContent,
                textAlign: TextAlign.justify,
              )
          )
        ]
    );
  }
}




// ICAM calculator

class OrderItem {
  final String title;
  final int qty;
  final double price;
  final String image;
  final Color bgColor;
  OrderItem({this.title, this.qty, this.price, this.image, this.bgColor});
}

class OrderListItem extends StatelessWidget {
  final OrderItem item;

  const OrderListItem({Key key, this.item}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Container(
            width: 100,
            height: 100,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: item.bgColor,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: item.image != null
                ? Image.network(
              item.image,
              fit: BoxFit.cover,
            )
                : null,
          ),
          const SizedBox(width: 20.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  item.title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10.0),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  height: 40.0,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        iconSize: 18.0,
                        padding: const EdgeInsets.all(2.0),
                        icon: Icon(Icons.remove),
                        onPressed: () {},
                      ),
                      Text(
                        "${item.qty}",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                      IconButton(
                        iconSize: 18.0,
                        padding: const EdgeInsets.all(2.0),
                        icon: Icon(Icons.add),
                        onPressed: () {},
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          const SizedBox(width: 10.0),
          Text(
            "\$${item.price * item.qty}",
            style: priceTextStyle,
          ),
        ],
      ),
    );
  }
}




