import 'package:flutter/material.dart';
import 'package:flutter_shop/Utlis/myColors.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
class progressInd extends StatelessWidget {
  final Widget child;
  final bool isAsync;
  final double opacity;
  final Color color;
  final Animation<Color> valueColor;

  progressInd({Key key,
    @required this.child,
    @required this.isAsync,
    this.opacity = 0.3,
    this.color = myColors.lightPink,
    this.valueColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = [];
    widgetList.add(child);
    if (isAsync) {
      final modal = Stack(
        children: [
          Opacity(
            opacity: opacity,
            child: ModalBarrier(dismissible: false, color: color,),
          ),
          Center(
            child: SpinKitDoubleBounce(
              color: myColors.deepPurple,
            ),
          )
        ],
      );
      widgetList.add(modal);
    }
    return Stack(
      children: widgetList,
    );
  }
}