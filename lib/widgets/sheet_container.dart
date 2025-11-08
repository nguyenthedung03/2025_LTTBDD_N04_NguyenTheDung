import 'package:flutter/material.dart';
import '../bloc/state_provider.dart';
import 'package:provider/provider.dart';
import '../widgets/list_item.dart';

class SheetContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double sheetItemHeight = 110;
    return Container(
      padding: EdgeInsets.only(top: 15),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(
              top: Radius.circular(40)),
          color:
              Color(0xfff1f1f1).withOpacity(0.95),
          boxShadow: [
            BoxShadow(
              color:
                  Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 10,
              offset: Offset(0, -3),
            ),
          ]),
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: ListView(
              children: <Widget>[
                specifications(sheetItemHeight),
                features(sheetItemHeight),
                SizedBox(height: 50),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget specifications(double sheetItemHeight) {
    return Container(
      padding: EdgeInsets.only(top: 15, left: 40),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Thông số kỹ thuật",
            style: TextStyle(
              color: Colors.deepPurple,
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 15),
            height: sheetItemHeight,
            child: Consumer<StateProvider>(
              builder: (context, stateProvider,
                  child) {
                final car =
                    stateProvider.currentCar;
                return ListView.builder(
                  scrollDirection:
                      Axis.horizontal,
                  itemCount: car?.specifications
                          .length ??
                      0,
                  itemBuilder: (context, index) {
                    return ListItem(
                      sheetItemHeight:
                          sheetItemHeight,
                      mapVal: car!
                          .specifications[index],
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget features(double sheetItemHeight) {
    return Container(
      padding: EdgeInsets.only(top: 15, left: 40),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Tính năng",
            style: TextStyle(
              color: Colors.deepPurple,
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 15),
            height: sheetItemHeight,
            child: Consumer<StateProvider>(
              builder: (context, stateProvider,
                  child) {
                final car =
                    stateProvider.currentCar;
                return ListView.builder(
                  scrollDirection:
                      Axis.horizontal,
                  itemCount:
                      car?.features.length ?? 0,
                  itemBuilder: (context, index) {
                    return ListItem(
                      sheetItemHeight:
                          sheetItemHeight,
                      mapVal:
                          car!.features[index],
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget offerDetails(double sheetItemHeight) {
    return Container(
      padding: EdgeInsets.only(top: 15, left: 40),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Chi tiết ưu đãi",
            style: TextStyle(
              color: Colors.deepPurple,
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 15),
            height: sheetItemHeight,
            child: Consumer<StateProvider>(
              builder: (context, stateProvider,
                  child) {
                final car =
                    stateProvider.currentCar;
                return ListView.builder(
                  scrollDirection:
                      Axis.horizontal,
                  itemCount:
                      car?.offerDetails.length ??
                          0,
                  itemBuilder: (context, index) {
                    return ListItem(
                      sheetItemHeight:
                          sheetItemHeight,
                      mapVal: car!
                          .offerDetails[index],
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
