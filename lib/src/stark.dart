import 'package:stark/src/di/injector.dart';
import 'package:stark/stark.dart';

class Stark {
  Stark._();
  static var _initialized = false;

  static void init(List<Module> modules, {Logger? logger}) {
    if (!_initialized) {
      _initialized = true;
      final _logger = logger ?? Logger(level: Level.DEBUG);
      _logger.info('Initializing Stark');
      Injector.initInjector(logger: _logger);
      modules.forEach(Injector.getInjector().registerModule);
    }
  }

  static void registerModule(Module module) {
    if (!_initialized) {
      throw StarkException(
          'Stark not initialized please call Stark.init before');
    } else {
      Injector.getInjector().registerModule(module);
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
