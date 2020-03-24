

import 'package:flutter/material.dart';
import 'package:stark/src/injector.dart';

class Scope extends StatefulWidget{

  final Widget child;
  final String name;

  const Scope({Key key, this.child, this.name}): super(key:key);

  @override
  State<StatefulWidget> createState() => _ScopeState();
}

class _ScopeState extends State<Scope>{

  @override
  void dispose() {
    Injector.getInjector().disposeScope(widget.name);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

}

