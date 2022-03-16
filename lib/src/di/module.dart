import 'package:stark/src/di/bind.dart';

class Module {
  final List<Bind> _binds = [];
  List<Bind> get binds => _binds;

  Module single<T>(
    FactoryFunc<T> factory, {
    String? named,
    bool replaceIfExists = false,
  }) {
    final bind = Bind<T>(
      factoryFunc: factory,
      isSingleton: true,
      name: named,
      type: T,
      replaceIfExists: replaceIfExists,
    );
    _binds..add(bind);
    return this;
  }

  Module singleWithParams<T>(
    FactoryFuncParams<T> factory, {
    String? named,
    bool replaceIfExists = false,
  }) {
    final bind = Bind<T>(
      factoryFuncParams: factory,
      isSingleton: true,
      name: named,
      type: T,
      replaceIfExists: replaceIfExists,
    );
    _binds..add(bind);
    return this;
  }

  Module factory<T>(
    FactoryFunc<T> factory, {
    String? named,
    bool replaceIfExists = false,
  }) {
    final bind = Bind<T>(
      factoryFunc: factory,
      isSingleton: false,
      name: named,
      type: T,
      replaceIfExists: replaceIfExists,
    );
    _binds..add(bind);
    return this;
  }

  Module factoryWithParams<T>(
    FactoryFuncParams<T> factory, {
    String? named,
    bool replaceIfExists = false,
  }) {
    final bind = Bind<T>(
      factoryFuncParams: factory,
      isSingleton: false,
      name: named,
      type: T,
      replaceIfExists: replaceIfExists,
    );
    _binds..add(bind);
    return this;
  }
}
