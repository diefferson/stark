
import 'package:stark/src/injector.dart';

typedef T FactoryFunc<T>(Injector i);
typedef T FactoryFuncParams<T>(Injector i, Map<String,dynamic> params);

class Bind<T> {

  final FactoryFuncParams<T> factoryFuncParams;
  final FactoryFunc<T> factoryFunc;
  final String name;
  final Type type;
  final String scope;
  final bool isSingleton;

  Bind._internal({
    this.factoryFuncParams,
    this.factoryFunc,
    this.name,
    this.type,
    this.scope,
    this.isSingleton
  });
}

Bind single<T>(FactoryFunc<T> factory, {String named, String scope}){
  return Bind._internal(
      factoryFunc: factory,
      isSingleton: true,
      name: named,
      type: T,
      scope:scope
  );
}

Bind singleWithParams<T>(FactoryFuncParams<T> factory, {String named, String scope}){
  return Bind._internal(
      factoryFuncParams: factory,
      isSingleton: true,
      name: named,
      type: T,
      scope:scope
  );
}

Bind factory<T>(FactoryFunc<T> factory, {String named, String scope}){
  return Bind._internal(
      factoryFunc: factory,
      isSingleton: false,
      name: named,
      type: T,
      scope:scope
  );
}

Bind factoryWithParams<T>(FactoryFuncParams<T> factory, {String named, String scope}){
  return Bind._internal(
      factoryFuncParams: factory,
      isSingleton: false,
      name: named,
      type: T,
      scope:scope
  );
}


