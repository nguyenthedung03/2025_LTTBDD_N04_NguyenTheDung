import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  final double sheetItemHeight;
  final Map mapVal;

  ListItem(
      {required this.sheetItemHeight,
      required this.mapVal});

  @override
  Widget build(BuildContext context) {
    var innerMap;
    bool isMap;

    if (mapVal.values.elementAt(0) is Map) {
      innerMap = mapVal.values.elementAt(0);
      isMap = true;
    } else {
      innerMap = mapVal;
      isMap = false;
    }

    return Container(
      margin: EdgeInsets.only(right: 20),
      width: sheetItemHeight,
      height: sheetItemHeight,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.pinkAccent,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.spaceEvenly,
        crossAxisAlignment:
            CrossAxisAlignment.center,
        children: <Widget>[
          mapVal.keys.elementAt(0),
          isMap
              ? Text(innerMap.keys.elementAt(0),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.deepPurple,
                      letterSpacing: 1.2,
                      fontSize: 11))
              : Container(),
          Text(
            innerMap.values.elementAt(0),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.deepPurple,
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          )
        ],
      ),
    );
  }
}
