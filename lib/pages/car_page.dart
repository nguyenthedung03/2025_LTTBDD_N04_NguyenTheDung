import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../bloc/state_bloc.dart';
import '../bloc/state_provider.dart';
import '../model/car.dart';
import '../widgets/car_carousel.dart';
import '../widgets/car_details.dart';
import '../widgets/custom_bottom_sheet.dart';
import '../widgets/list_item.dart';
import '../widgets/sheet_container.dart';

var currentCar = carList.cars[0];
final stateBloc = StateBloc();

class CarDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Container(
          margin: EdgeInsets.only(left: 8),
          child: IconButton(
            icon: Icon(Icons.arrow_back,
                color: Colors.pinkAccent),
            onPressed: () =>
                Navigator.of(context).pop(),
          ),
        ),
        title: Consumer<StateProvider>(
            builder: (context, state, _) {
          final car =
              state.currentCar ?? currentCar;
          return Text(
            '${car.companyName} - ${car.carName}',
            style: TextStyle(
                color: Colors.white,
                fontSize: 18),
            overflow: TextOverflow.ellipsis,
          );
        }),
        centerTitle: true,
        actions: <Widget>[
          Consumer<StateProvider>(
              builder: (context, state, _) {
            final car =
                state.currentCar ?? currentCar;
            final fav = state.isFavorite(car);
            return Container(
              margin: EdgeInsets.only(right: 8),
              child: IconButton(
                icon: Icon(
                  fav
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: fav
                      ? Colors.redAccent
                      : Colors.white,
                ),
                onPressed: () {
                  state.toggleFavorite(car);
                },
              ),
            );
          })
        ],
      ),
      backgroundColor: Colors.deepPurple,
      body: LayoutStarts(),
    );
  }
}

/// Wrapper page that ensures the current car is set to the Corvette before
/// showing the shared CarDetailPage UI.
class CarDetailCorvettePage
    extends StatefulWidget {
  @override
  _CarDetailCorvettePageState createState() =>
      _CarDetailCorvettePageState();
}

class _CarDetailCorvettePageState
    extends State<CarDetailCorvettePage> {
  @override
  void initState() {
    super.initState();
    // set the current car to the corvette
    final corv = carList.cars.firstWhere((c) => c
        .carName
        .toLowerCase()
        .contains('corvette'));
    WidgetsBinding.instance
        .addPostFrameCallback((_) {
      Provider.of<StateProvider>(context,
              listen: false)
          .setCurrentCar(corv);
    });
  }

  @override
  Widget build(BuildContext context) =>
      CarDetailPage();
}

/// Wrapper page that ensures the current car is set to the Lamborghini before
/// showing the shared CarDetailPage UI.
class CarDetailLamboPage extends StatefulWidget {
  @override
  _CarDetailLamboPageState createState() =>
      _CarDetailLamboPageState();
}

class _CarDetailLamboPageState
    extends State<CarDetailLamboPage> {
  @override
  void initState() {
    super.initState();
    final lambo = carList.cars.firstWhere((c) =>
        c.companyName
            .toLowerCase()
            .contains('lamborghini') ||
        c.carName
            .toLowerCase()
            .contains('aventador'));
    WidgetsBinding.instance
        .addPostFrameCallback((_) {
      Provider.of<StateProvider>(context,
              listen: false)
          .setCurrentCar(lambo);
    });
  }

  @override
  Widget build(BuildContext context) =>
      CarDetailPage();
}

class LayoutStarts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        CarDetailsAnimation(),
        CustomBottomSheet(),
        RentButton(),
      ],
    );
  }
}

class RentButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomRight,
      child: SizedBox(
        width: 200,
        child: TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
            backgroundColor: Colors.deepPurple,
            padding: EdgeInsets.all(25),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35)),
            ),
          ),
          child: Text(
            "Thuê Xe",
            style: TextStyle(
                color: Colors.pinkAccent,
                fontSize: 18,
                letterSpacing: 1.4,
                fontFamily: "arial"),
          ),
        ),
      ),
    );
  }
}

class CarDetailsAnimation extends StatefulWidget {
  @override
  _CarDetailsAnimationState createState() =>
      _CarDetailsAnimationState();
}

class _CarDetailsAnimationState
    extends State<CarDetailsAnimation>
    with TickerProviderStateMixin {
  late AnimationController fadeController;
  late AnimationController scaleController;
  late Animation<double> fadeAnimation;
  late Animation<double> scaleAnimation;
  late StateProvider stateBloc;

  @override
  void initState() {
    super.initState();
    stateBloc = Provider.of<StateProvider>(
        context,
        listen: false);
    fadeController = AnimationController(
        duration: Duration(milliseconds: 180),
        vsync: this);
    scaleController = AnimationController(
        duration: Duration(milliseconds: 350),
        vsync: this);
    fadeAnimation = Tween(begin: 0.0, end: 1.0)
        .animate(fadeController);
    scaleAnimation = Tween(begin: 0.8, end: 1.0)
        .animate(CurvedAnimation(
      parent: scaleController,
      curve: Curves.easeInOut,
      reverseCurve: Curves.easeInOut,
    ));
  }

  void forward() {
    scaleController.forward();
    fadeController.forward();
  }

  void reverse() {
    scaleController.reverse();
    fadeController.reverse();
  }

  @override
  void dispose() {
    fadeController.dispose();
    scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        initialData:
            Provider.of<StateProvider>(context)
                .isAnimating,
        stream: stateBloc.animationStatus
            .cast<bool>(),
        builder: (context, snapshot) {
          if (snapshot.data == true) {
            forward();
          } else {
            reverse();
          }

          return ScaleTransition(
            scale: scaleAnimation,
            child: FadeTransition(
              opacity: fadeAnimation,
              child: CarDetails(),
            ),
          );
        });
  }
}

class CarCarousel extends StatefulWidget {
  @override
  _CarCarouselState createState() =>
      _CarCarouselState();
}

class _CarCarouselState
    extends State<CarCarousel> {
  static final List<String> imgList =
      currentCar.imgList;

  final List<Widget> child = _map<Widget>(imgList,
      (index, String assetName) {
    return Container(
        child: Image.asset("assets/$assetName",
            fit: BoxFit.fitWidth));
  }).toList();

  static List<T> _map<T>(
      List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          CarouselSlider(
            items: child,
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
              children: _map<Widget>(imgList,
                  (index, assetName) {
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

class CustomBottomSheet extends StatefulWidget {
  @override
  _CustomBottomSheetState createState() =>
      _CustomBottomSheetState();
}

class _CustomBottomSheetState
    extends State<CustomBottomSheet>
    with SingleTickerProviderStateMixin {
  double sheetTop = 400;
  double minSheetTop = 30;

  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration:
            const Duration(milliseconds: 200),
        vsync: this);
    animation = Tween<double>(
            begin: sheetTop, end: minSheetTop)
        .animate(CurvedAnimation(
      parent: controller,
      curve: Curves.easeInOut,
      reverseCurve: Curves.easeInOut,
    ))
      ..addListener(() {
        setState(() {});
      });
  }

  forwardAnimation() {
    controller.forward();
    stateBloc.toggleAnimation();
  }

  reverseAnimation() {
    controller.reverse();
    stateBloc.toggleAnimation();
  }

  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: animation.value,
      left: 0,
      child: GestureDetector(
        onTap: () {
          controller.isCompleted
              ? reverseAnimation()
              : forwardAnimation();
        },
        onVerticalDragEnd:
            (DragEndDetails dragEndDetails) {
          //upward drag
          if (dragEndDetails.primaryVelocity !=
                  null &&
              dragEndDetails.primaryVelocity! <
                  0.0) {
            forwardAnimation();
            controller.forward();
          } else if (dragEndDetails
                      .primaryVelocity !=
                  null &&
              dragEndDetails.primaryVelocity! >
                  0.0) {
            //downward drag
            reverseAnimation();
          } else {
            return;
          }
        },
        child: SheetContainer(),
      ),
    );
  }
}

class SheetContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double sheetItemHeight = 110;
    return Container(
      padding: EdgeInsets.only(top: 25),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(
              top: Radius.circular(40)),
          color: Color(0xfff1f1f1)),
      child: Column(
        children: <Widget>[
          drawerHandle(),
          Expanded(
            flex: 1,
            child: ListView(
              children: <Widget>[
                specifications(sheetItemHeight),
                features(sheetItemHeight),
                SizedBox(height: 220),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget drawerHandle() {
    return Container(
      margin: EdgeInsets.only(bottom: 25),
      height: 3,
      width: 65,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Color(0xffd9dbdb)),
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
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: currentCar
                  .specifications.length,
              itemBuilder: (context, index) {
                return ListItem(
                    sheetItemHeight:
                        sheetItemHeight,
                    mapVal: currentCar
                        .specifications[index]);
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
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount:
                  currentCar.features.length,
              itemBuilder: (context, index) {
                return ListItem(
                    sheetItemHeight:
                        sheetItemHeight,
                    mapVal: currentCar
                        .features[index]);
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
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount:
                  currentCar.offerDetails.length,
              itemBuilder: (context, index) {
                return ListItem(
                    sheetItemHeight:
                        sheetItemHeight,
                    mapVal: currentCar
                        .offerDetails[index]);
              },
            ),
          )
        ],
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  final double sheetItemHeight;
  final Map mapVal;

  ListItem({
    required this.sheetItemHeight,
    required this.mapVal,
  });

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
              ? Text(
                  innerMap.keys.elementAt(0),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.deepPurple,
                    letterSpacing: 1.2,
                    fontSize: 11,
                  ),
                )
              : Container(),
          Text(
            innerMap.values.elementAt(0),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.deepPurple,
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}
