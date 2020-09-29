import 'package:flutter/material.dart';
import 'package:stark/src/injector.dart';

mixin StarkComponent<Widget extends StatefulWidget> on State<Widget> {
  T get<T>({String named, Map<String, dynamic> params}) {
    return Injector.getInjector()
        .get<T>(component: this, named: named, params: params);
  }

  @override
  void dispose() {
    Injector.getInjector().disposeComponent(this);
    super.dispose();
  }
}
