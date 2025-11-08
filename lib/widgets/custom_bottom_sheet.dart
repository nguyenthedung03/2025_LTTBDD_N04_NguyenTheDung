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
  double sheetTop = 400;
  double minSheetTop = 30;
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
