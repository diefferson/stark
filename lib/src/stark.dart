import 'package:stark/src/injector.dart';
import 'package:stark/stark.dart';
import 'internal_module.dart';

class Stark {
  Stark._();
  static var _initialized = false;

  static void init(List<Set<Bind>> modules) {
    if (!_initialized) {
      _initialized = true;
      for (var binds in modules) {
        binds.forEach(Injector.getInjector().registerBind);
      }
    }
  }

  static T get<T>(
      {StarkComponent component, String named, Map<String, dynamic> params}) {
    return Injector.getInjector()
        .get<T>(component: component, named: named, params: params);
  }

  static void disposeComponent(StarkComponent component) {
    Injector.getInjector().disposeComponent(component);
  }

  static void clear() {
    Injector.getInjector().dispose();
  }
}
