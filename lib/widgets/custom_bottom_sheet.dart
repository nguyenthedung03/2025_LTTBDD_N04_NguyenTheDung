import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../bloc/state_provider.dart';
import 'sheet_container.dart';

class CustomBottomSheet extends StatefulWidget {
  @override
  _CustomBottomSheetState createState() =>
      _CustomBottomSheetState();
}

class _CustomBottomSheetState
    extends State<CustomBottomSheet>
    with SingleTickerProviderStateMixin {
  double sheetTop = 250;
  double minSheetTop = -20;
  late StateProvider stateBloc;
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    stateBloc = Provider.of<StateProvider>(
        context,
        listen: false);
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
    return Stack(
      children: [
        Positioned(
          top: animation.value,
          left: 0,
          child: SheetContainer(),
        ),
        Positioned(
          bottom: 30,
          left: 30,
          child: FloatingActionButton.extended(
            backgroundColor: Colors.deepPurple,
            onPressed: () {
              controller.isCompleted
                  ? reverseAnimation()
                  : forwardAnimation();
            },
            label: Text(
              controller.isCompleted
                  ? 'Hide Details'
                  : 'Show Details',
              style:
                  TextStyle(color: Colors.white),
            ),
            icon: Icon(
              controller.isCompleted
                  ? Icons.keyboard_arrow_down
                  : Icons.keyboard_arrow_up,
              color: Colors.white,
            ),
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.horizontal(
                right: Radius.circular(30),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
