import 'package:stark/src/disposable.dart';
import 'package:stark/src/internal_module.dart';

import '../stark.dart';

class Injector {
  Injector._internal();

  final Map<String, Bind> _factories = {};

  static Injector _instance;

  static Injector getInjector() {
    _instance ??= Injector._internal();
    return _instance;
  }

  void registerBind<T>(Bind<T> bind) {
    final objectKey = _getKey(bind.type, bind.name);

    if (!_factories.containsKey(objectKey)) {
      _factories[objectKey] = bind;
    } else {
      final objectKey2 = objectKey;
      throw StarkException(
          'Object $objectKey2 is already defined!, consider use named bind to register the same type.');
    }
  }

  T get<T>(
      {String named, StarkComponent component, Map<String, dynamic> params}) {
    final objectKey = _getKey(T, named);
    final bind = _factories[objectKey];

    if (bind == null) {
      throw StarkException("Cannot find object factory for '$objectKey'");
    }

    return bind.get(this, component, params);
  }

  void dispose() {
    _factories.clear();
  }

  void disposeComponent(StarkComponent component) {
    _factories.forEach((key, bind) {
      bind.instances.forEach((instanceComponent, dynamic instance) {
        if (instance is Disposable) {
          instance.dispose();
        }
        bind.instances.remove(instanceComponent);
      });
    });
  }

  String _getKey<T>(T type, [String name]) =>
      '${type.toString()}::${name ?? "default"}';
}
