import 'package:stark/src/model/disposable.dart';

abstract class StarkPresenter<ViewContract> implements Disposable {
  late ViewContract view;

  void init() {}

  @override
  void dispose() {}
}
