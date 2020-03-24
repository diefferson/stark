

import 'package:stark/src/disposable.dart';

import '../stark.dart';
import 'instance_factory.dart';

class Injector {

  final _factories = Map<String, InstanceFactory<Object>>();
  final _scopedFactories = Map<String, Set<String>>();

  static Injector _instance;

  static Injector getInjector() {
    if (_instance == null) {
      _instance = Injector._internal();
    }
    return _instance;
  }

  Injector._internal();

  void registerBind<T>(Bind<T> bind) {

    final objectKey = _getKey(bind.type, bind.name);

    if (!_factories.containsKey(objectKey) ) {

      if(bind.factoryFuncParams != null){
        _factories[objectKey] = InstanceFactory<T>(bind.factoryFuncParams, bind.isSingleton);
      }else{
        _factories[objectKey] = InstanceFactory<T>((i, p) => bind.factoryFunc(i), bind.isSingleton);
      }

      _registerBindScope(bind, objectKey);

    }else{
      throw StarkException("Object $objectKey is already defined!, consider use named bind to register the same type.");
    }
  }

  void _registerBindScope<T>(Bind<T> bind, String objectKey){
    if(bind.scope!= null){
      if(_scopedFactories[bind.scope] == null){
        _scopedFactories[bind.scope] = Set<String>();
      }
      _scopedFactories[bind.scope].add(objectKey);
    }
  }

  T get<T>({String named, String scope, Map<String, dynamic> params}) {

    final objectKey = _getKey(T, named);
    final objectFactory = _factories[objectKey];

    if (objectFactory == null) {
      throw StarkException("Cannot find object factory for '$objectKey'");
    }

    return objectFactory.get(this, params);
  }

  void dispose() {
    _factories.clear();
    _scopedFactories.clear();
  }

  void disposeScope(String scope){
    _scopedFactories[scope].forEach((e){
      if(_factories[e].instance is Disposable){
        (_factories[e].instance as Disposable).dispose();
      }
      _factories[e].instance = null;
    });
  }

  String _getKey<T>(T type, [String name]) =>
      "${type.toString()}::${name == null ? "default" : name}";
}
