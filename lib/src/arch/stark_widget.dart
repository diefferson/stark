import 'package:flutter/material.dart';
import 'package:stark/src/arch/stark_presenter.dart';
import 'package:stark/src/arch/stark_state.dart';
import 'package:stark/src/arch/injectable_state.dart';

abstract class StarkWidget extends StatefulWidget {
  const StarkWidget({Key? key}) : super(key: key);

  @override
  @protected
  @factory
  StarkState createState();
}
