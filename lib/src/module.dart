
import 'package:stark/src/injector.dart';

typedef T FactoryFunc<T>(Injector i);
typedef T FactoryFuncParams<T>(Injector i, Map<String,dynamic> params);

abstract class Bind<T> {

  final FactoryFuncParams<T> factoryFuncParams;
  final FactoryFunc<T> factoryFunc;
  final String name;
  final bool isSingleton;

  Bind({this.factoryFuncParams, this.factoryFunc,this.name,this.isSingleton, });
}

class Single<T> extends Bind<T>{

  Single(
      FactoryFunc<T> factory,
      {
        String named,
      }
  ) : super(factoryFunc: factory, isSingleton: true, name: named);

  Single.withParams(
      final FactoryFuncParams<T> factory,
      {
        String named,
      }
  ): super(factoryFuncParams: factory, isSingleton: true, name: named);
}

class Factory<T> extends Bind<T> {

  Factory(
      FactoryFunc<T> factory,
      {
        String named,
      }
  ) : super(factoryFunc: factory, isSingleton: false, name: named);

  Factory.withParams(
      final FactoryFuncParams<T> factory,
      {
        String named,
      }
  ) : super(factoryFuncParams: factory, isSingleton: false, name: named);
}