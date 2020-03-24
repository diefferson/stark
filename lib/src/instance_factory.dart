

import 'package:stark/src/module.dart';

import 'injector.dart';

class InstanceFactory<T> {

  final bool _isSingleton;
  final FactoryFuncParams<T> _factoryFn;

  T instance;

  InstanceFactory(this._factoryFn, this._isSingleton);

  T get(Injector injector, Map<String, dynamic> params) {
    if (_isSingleton && instance != null) {
      return instance;
    }

    final newInstance = _factoryFn(injector, params);
    if (_isSingleton) {
      instance = newInstance;
    }
    return newInstance;
  }
}