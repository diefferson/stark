import '../../stark.dart';

class Injector {
  Injector._internal({required this.logger});

  final Logger logger;
  final Map<String, Bind> _factories = {};

  static Injector? _instance;

  static Injector getInjector({Logger? logger}) {
    _instance ??= Injector._internal(logger: logger ?? Logger());
    return _instance!;
  }

  void registerBind<T>(Bind<T> bind) {
    final objectKey = _getKey(bind.type, bind.name);

    if (!_factories.containsKey(objectKey)) {
      logger.debug(
          'Registering ${bind.isSingleton ? 'singleton' : 'factory'}  $objectKey');
      _factories[objectKey] = bind;
    } else if (bind.replaceIfExists) {
      logger.info(
          'Replacing ${bind.isSingleton ? 'singleton' : 'factory'} $objectKey to new object');
      _factories[objectKey] = bind;
    } else {
      final objectKey2 = objectKey;
      final message =
          'Object $objectKey2 is already defined!, consider use named bind to register the same type.';
      logger.error(message);
      throw StarkException(message);
    }
  }

  T get<T>({
    String? named,
    StarkComponent? component,
    Map<String, dynamic>? params,
  }) {
    final objectKey = _getKey(T, named);
    final bind = _factories[objectKey];
    logger.debug('Getting $objectKey');

    if (bind == null) {
      final message = "Cannot find object factory for '$objectKey'";
      logger.debug(message);
      throw StarkException(message);
    }

    return bind.get(this, component, params);
  }

  void dispose() {
    logger.info('Disposing injector');
    _factories.clear();
  }

  void disposeComponent(StarkComponent component) {
    logger.info('Disposing component ${component.runtimeType}');
    _factories.forEach((key, bind) {
      final List<StarkComponent> toDispose = [];
      bind.instances.forEach((instanceComponent, Object? instance) {
        if (instanceComponent == component) {
          if (instance is Disposable) {
            instance.dispose();
          }
          toDispose.add(instanceComponent);
        }
      });
      bind.instances.removeWhere(
        (componentKey, Object? instance) => toDispose.contains(componentKey),
      );
    });
  }

  String _getKey<T>(T type, [String? name]) =>
      '${type.toString()}::${name ?? "default"}';
}
