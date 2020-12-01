import 'package:flutter/material.dart';

class SharedDataWidget extends InheritedWidget {
  final int data;
  Widget child;

  SharedDataWidget({this.data, this.child}) : super(child: child);

  static of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<SharedDataWidget>();
  }

  @override
  bool updateShouldNotify(covariant SharedDataWidget oldWidget) {
    // TODO: implement updateShouldNotify
    return oldWidget.data != data;
  }
}
