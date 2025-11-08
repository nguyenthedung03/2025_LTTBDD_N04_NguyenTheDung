import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../bloc/state_provider.dart';
import 'car_carousel.dart';

class CarDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<StateProvider>(
        builder: (context, stateProvider, child) {
      return Container(
          child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 30),
            child: _carTitle(stateProvider),
          ),
          Container(
            width: double.infinity,
            child: CarCarousel(),
          )
        ],
      ));
    });
  }

  Widget _carTitle(StateProvider stateProvider) {
    final car = stateProvider.currentCar;
    if (car == null) return Container();

    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: <Widget>[
        RichText(
          text: TextSpan(
              style: TextStyle(
                  color: Colors.pinkAccent,
                  fontSize: 38),
              children: [
                TextSpan(text: car.companyName),
                TextSpan(text: "\n"),
                TextSpan(
                    text: car.carName,
                    style: TextStyle(
                        fontWeight:
                            FontWeight.w700)),
              ]),
        ),
        SizedBox(height: 10),
        RichText(
          text: TextSpan(
              style: TextStyle(fontSize: 16),
              children: [
                TextSpan(
                    text: car.price.toString(),
                    style: TextStyle(
                        color: Colors.pink[100])),
                TextSpan(
                    text: " / ngày",
                    style: TextStyle(
                        color: Colors.pink))
              ]),
        ),
      ],
    );
  }
}
