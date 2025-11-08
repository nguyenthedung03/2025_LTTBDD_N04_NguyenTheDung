import 'package:flutter/foundation.dart';
import 'dart:async';
import '../model/car.dart';

class StateProvider extends ChangeNotifier {
  bool isAnimating = false;
  Car? currentCar;
  // track favorites by a simple key (company_carName)
  final Set<String> _favorites = {};
  // simple user/auth state
  bool loggedIn = false;
  String? userName;
  String? userEmail;

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

  // Simple auth methods (no backend)
  void register(String name, String email,
      String password) {
    userName = name;
    userEmail = email;
    loggedIn = true;
    notifyListeners();
  }

  void login(String email, String password) {
    // In real app verify credentials. Here we accept any input.
    userEmail = email;
    if (userName == null)
      userName = email.split('@').first;
    loggedIn = true;
    notifyListeners();
  }

  void logout() {
    loggedIn = false;
    userName = null;
    userEmail = null;
    notifyListeners();
  }

  // Return favorite cars as list
  List<Car> getFavoriteCars() {
    try {
      return carList.cars
          .where((c) =>
              _favorites.contains(_keyFor(c)))
          .toList();
    } catch (e) {
      return [];
    }
  }

  @override
  void dispose() {
    _animationController.close();
    super.dispose();
  }
}
