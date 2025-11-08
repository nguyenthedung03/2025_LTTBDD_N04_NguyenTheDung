import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import '../bloc/state_provider.dart';

class CarCarousel extends StatefulWidget {
  @override
  _CarCarouselState createState() =>
      _CarCarouselState();
}

class _CarCarouselState
    extends State<CarCarousel> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    final stateProvider =
        Provider.of<StateProvider>(context);
    final imgList =
        stateProvider.currentCar?.imgList ?? [];

    if (imgList.isEmpty) {
      return SizedBox.shrink();
    }

    return Container(
      child: Column(
        children: <Widget>[
          CarouselSlider.builder(
            itemCount: imgList.length,
            itemBuilder:
                (context, index, realIndex) {
              return Container(
                child: Image.asset(
                  "assets/${imgList[index]}",
                  fit: BoxFit.fitWidth,
                ),
              );
            },
            options: CarouselOptions(
              height: 250,
              viewportFraction: 1.0,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 25),
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.start,
              children: List.generate(
                  imgList.length, (index) {
                return Container(
                  width: 50,
                  height: 2,
                  decoration: BoxDecoration(
                      color: _current == index
                          ? Colors.pink[100]
                          : Colors.pink[600]),
                );
              }),
            ),
          )
        ],
      ),
    );
  }
}
