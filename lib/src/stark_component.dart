import 'package:flutter/material.dart';
import 'package:stark/src/injector.dart';

mixin StarkComponent<Widget extends StatefulWidget> on State<Widget> {
  @override
  void dispose() {
    Injector.getInjector().disposeComponent(this);
    super.dispose();
  }
}
