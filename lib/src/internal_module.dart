import '../stark.dart';
import 'injector.dart';

class Bind<T> {
  Bind({
    this.factoryFuncParams,
    this.factoryFunc,
    this.name,
    this.type,
    this.isSingleton,
  });

  final FactoryFuncParams<T> factoryFuncParams;
  final FactoryFunc<T> factoryFunc;
  final String name;
  final Type type;
  final bool isSingleton;

  Map<StarkComponent, T> instances = {};
  T instance;

  T get(Injector injector, StarkComponent component,
      Map<String, dynamic> params) {
    if (component != null) {
      return _scopedInstance(component, injector, params);
    } else {
      return _singleInstance(injector, params);
    }
  }

  T _scopedInstance(StarkComponent component, Injector injector,
      Map<String, dynamic> params) {
    if (isSingleton && instances.containsKey(component)) {
      return instances[component];
    }

    final newInstance = _getNewInstance(injector, params);

    if (isSingleton) {
      instances[component] = newInstance;
    }

    return newInstance;
  }

  T _singleInstance(Injector injector, Map<String, dynamic> params) {
    if (isSingleton && instance != null) {
      return instance;
    }

    final newInstance = _getNewInstance(injector, params);

    if (isSingleton) {
      instance = newInstance;
    }
    return newInstance;
  }

  T _getNewInstance(Injector injector, Map<String, dynamic> params) {
    return factoryFuncParams != null
        ? factoryFuncParams(injector, params)
        : factoryFunc(injector);
  }
}
