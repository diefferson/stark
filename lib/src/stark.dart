import 'package:stark/src/di/injector.dart';
import 'package:stark/stark.dart';

class Stark {
  Stark._();
  static var _initialized = false;

  static void init(List<Set<Bind>> modules, {Logger? logger}) {
    if (!_initialized) {
      final _logger = logger ?? Logger(level: Level.DEBUG);
      _logger.info('Initializing Stark');
      _initialized = true;
      for (var binds in modules) {
        binds.forEach(Injector.getInjector(logger: _logger).registerBind);
      }
    }
  }

  static void registerModule(Set<Bind> module) {
    if (!_initialized) {
      throw StarkException(
          'Stark not initialized please call Stark.init before');
    } else {
      module.forEach(Injector.getInjector().registerBind);
    }
  }

  static void registerBind(Bind bind) {
    if (!_initialized) {
      throw StarkException(
          'Stark not initialized please call Stark.init before');
    } else {
      Injector.getInjector().registerBind(bind);
    }
  }

  static T get<T>({
    StarkComponent? component,
    String? named,
    Map<String, dynamic>? params,
  }) {
    return Injector.getInjector().get<T>(
      component: component,
      named: named,
      params: params,
    );
  }

  static void disposeComponent(StarkComponent component) {
    Injector.getInjector().disposeComponent(component);
  }

  static void clear() {
    Injector.getInjector().dispose();
  }
}
