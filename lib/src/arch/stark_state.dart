import 'package:flutter/material.dart';
import 'package:stark/src/arch/stark_presenter.dart';
import 'package:stark/src/arch/injectable_state.dart';

abstract class StarkState<T extends StatefulWidget,
    Presenter extends StarkPresenter> extends InjectableState<T> {
  late Presenter presenter;

  @override
  @mustCallSuper
  void initState() {
    presenter = get();
    presenter.view = this;
    super.initState();
    presenter.init();
  }
}
