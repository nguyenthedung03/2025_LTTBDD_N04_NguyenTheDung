import 'package:flutter/foundation.dart';
import 'dart:async';
import '../model/car.dart';

class StateProvider extends ChangeNotifier {
  bool isAnimating = false;
  Car? currentCar;
  // track favorites by a simple key (company_carName)
  final Set<String> _favorites = {};

  final StreamController<bool>
      _animationController =
      StreamController<bool>.broadcast();
  Stream<bool> get animationStatus =>
      _animationController.stream;

  void setCurrentCar(Car car) {
    currentCar = car;
    notifyListeners();
  }

  String _keyFor(Car car) =>
      '${car.companyName}_${car.carName}';

  bool isFavorite(Car car) =>
      _favorites.contains(_keyFor(car));

  void toggleFavorite(Car car) {
    final key = _keyFor(car);
    if (_favorites.contains(key)) {
      _favorites.remove(key);
    } else {
      _favorites.add(key);
    }
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
