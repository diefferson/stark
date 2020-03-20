

import 'package:stark/src/module.dart';

import 'injector.dart';

class InstanceFactory<T> {

  final bool _isSingleton;
  final FactoryFuncParams<T> _factoryFn;

  T _instance;

  InstanceFactory(this._factoryFn, this._isSingleton);

  T get(Injector injector, Map<String, dynamic> params) {
    if (_isSingleton && _instance != null) {
      return _instance;
    }

    final instance = _factoryFn(injector, params);
    if (_isSingleton) {
      _instance = instance;
    }
    return instance;
  }
}