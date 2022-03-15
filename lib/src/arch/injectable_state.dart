import 'package:flutter/material.dart';
import 'package:stark/stark.dart';

abstract class InjectableState<T extends StatefulWidget> extends State<T>
    with StarkComponent {}
