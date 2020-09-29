import 'package:stark/src/injector.dart';

import 'internal_module.dart';

typedef FactoryFunc<T> = T Function(Injector i);
typedef FactoryFuncParams<T> = T Function(
    Injector i, Map<String, dynamic> params);

Bind single<T>(FactoryFunc<T> factory, {String named, String scope}) {
  return Bind<T>(
    factoryFunc: factory,
    isSingleton: true,
    name: named,
    type: T,
  );
}

Bind singleWithParams<T>(FactoryFuncParams<T> factory,
    {String named, String scope}) {
  return Bind<T>(
    factoryFuncParams: factory,
    isSingleton: true,
    name: named,
    type: T,
  );
}

Bind factory<T>(FactoryFunc<T> factory, {String named, String scope}) {
  return Bind<T>(
    factoryFunc: factory,
    isSingleton: false,
    name: named,
    type: T,
  );
}

Bind factoryWithParams<T>(FactoryFuncParams<T> factory,
    {String named, String scope}) {
  return Bind<T>(
    factoryFuncParams: factory,
    isSingleton: false,
    name: named,
    type: T,
  );
}
