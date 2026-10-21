import 'package:flutter/material.dart';

extension WidgetExtensions on Widget {
  Widget allPadding(double padding) =>
      Padding(padding: EdgeInsets.all(padding), child: this);
  Widget verticalPadding(double padding) => Padding(
    padding: EdgeInsets.symmetric(vertical: padding),
    child: this,
  );
  Widget horizontalPadding(double padding) => Padding(
    padding: EdgeInsets.symmetric(horizontal: padding),
    child: this,
  );
  Widget clip(double radius)=>ClipRRect(
    borderRadius: BorderRadiusGeometry.circular(radius),
    child: this,
  );
}
