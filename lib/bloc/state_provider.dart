import 'package:flutter/foundation.dart';
import 'dart:async';
import '../model/car.dart';

class StateProvider extends ChangeNotifier {
  bool isAnimating = false;
  Car? currentCar;

  final StreamController<bool>
      _animationController =
      StreamController<bool>.broadcast();
  Stream<bool> get animationStatus =>
      _animationController.stream;

  void setCurrentCar(Car car) {
    currentCar = car;
    notifyListeners();
  }

  void toggleAnimation() {
    isAnimating = !isAnimating;
    _animationController.sink.add(isAnimating);
    notifyListeners();
  }

  @override
  void dispose() {
    _animationController.close();
    super.dispose();
  }
}
