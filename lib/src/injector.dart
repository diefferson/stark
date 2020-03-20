

import '../stark.dart';
import 'instance_factory.dart';

class Injector {

  final Map<String, InstanceFactory<Object>> _factories = Map<String, InstanceFactory<Object>>();

  static Injector _instance;

  static Injector getInjector() {
    if (_instance == null) {
      _instance = Injector._internal();
    }
    return _instance;
  }

  Injector._internal();

  void registerBind<T>(Bind<T> bind) {
    final type = _getType(bind);
    final objectKey = _getName(type, bind.name);
    if (!_factories.containsKey(objectKey) ) {
      if(bind.factoryFuncParams != null){
        _factories[objectKey] = InstanceFactory<T>(bind.factoryFuncParams, bind.isSingleton);
      }else{
        _factories[objectKey] = InstanceFactory<T>((i, p) => bind.factoryFunc(i), bind.isSingleton);
      }
    }else{
      throw StarkException("Object $objectKey is already defined!, consider use named bind to register the same type.");
    }
  }

  T get<T>({String named, Map<String, dynamic> params}) {
    final objectKey = _getName(T.toString(), named);
    final objectFactory = _factories[objectKey];
    if (objectFactory == null) {
      throw StarkException("Cannot find object factory for '$objectKey'");
    }

    return objectFactory.get(this, params);
  }

  void dispose() {
    _factories.clear();
  }

  String _getName<T>(String type, [String name]) =>
      "${type.toString()}::${name == null ? "default" : name}";

  String _getType(Bind bind){
    if(bind.factoryFuncParams != null){
      return bind.factoryFuncParams.toString().replaceAll("Closure: (Injector, Map<String, dynamic>) => ", "");
    }else{
      return bind.factoryFunc.toString().replaceAll("Closure: (Injector) => ", "");
    }
  }
}
