import 'package:stark/src/injector.dart';
import 'package:stark/stark.dart';

typedef FactoryFunc<T> = T Function(Injector i);
typedef FactoryFuncParams<T> = T Function(
    Injector i, Map<String, dynamic> params);

class Bind<T> {
  Bind._internal({
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
    //Return instance is exists
    if (isSingleton && instance != null) {
      return instance;
    }

    //Return last scoped Instance is exists
    if (isSingleton && instances.isNotEmpty) {
      return instances[instances.keys.last];
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

Bind single<T>(FactoryFunc<T> factory, {String named}) {
  return Bind<T>._internal(
    factoryFunc: factory,
    isSingleton: true,
    name: named,
    type: T,
  );
}

Bind singleWithParams<T>(FactoryFuncParams<T> factory, {String named}) {
  return Bind<T>._internal(
    factoryFuncParams: factory,
    isSingleton: true,
    name: named,
    type: T,
  );
}

Bind factory<T>(FactoryFunc<T> factory, {String named}) {
  return Bind<T>._internal(
    factoryFunc: factory,
    isSingleton: false,
    name: named,
    type: T,
  );
}

Bind factoryWithParams<T>(FactoryFuncParams<T> factory, {String named}) {
  return Bind<T>._internal(
    factoryFuncParams: factory,
    isSingleton: false,
    name: named,
    type: T,
  );
}
