import 'dart:math';

import 'package:flutter/material.dart';

class CircleMultiChildLayoutDelegate extends MultiChildLayoutDelegate {
  final List<LayoutId> ids;
  final double screenWidth;
  final double radius;

  CircleMultiChildLayoutDelegate({
    required this.ids,
    required this.screenWidth,
    required this.radius,
  });

  @override
  void performLayout(Size size) {
    for (int i = 1; i < 13; i++) {
      final id = ids[i - 1];
      double radians = (30 * i - 90) * pi / 180;
      if (hasChild(id.id)) {
        final size = layoutChild(
          id.id,
          BoxConstraints.loose(
            Size(
              screenWidth * 0.056,
              screenWidth * 0.056,
            ),
          ),
        );

        final dx = radius -
            size.width / 2 +
            cos(radians) * (radius - size.width * 2.5);
        final dy =
            radius - size.height / 2 + sin(radians) * (radius - size.height);
        positionChild(
          id.id,
          Offset(
            dx,
            dy,
          ),
        );
      }
    }
  }

  @override
  bool shouldRelayout(covariant MultiChildLayoutDelegate oldDelegate) {
    return false;
  }
}
