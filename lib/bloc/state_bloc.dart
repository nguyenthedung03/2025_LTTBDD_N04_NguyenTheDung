import 'dart:async';
import '../model/car.dart';

class StateBloc {
  Car? currentCar;
  StreamController animationController =
      StreamController();

  Stream get animationStatus =>
      animationController.stream;

  void toggleAnimation() {
    animationController.sink.add(true);
  }

  void dispose() {
    animationController.close();
  }
}
